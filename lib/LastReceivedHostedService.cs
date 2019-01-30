using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Hosting;

namespace SmokeTestsDashboardServer
{
    public class LastReceived
    {
        public DateTimeOffset? Time { get; set; }

        public string DiffText { get; set; }

        public double Status { get; set; }
    }

    internal class LastReceivedHostedService : HostedService
    {
        private static readonly TimeSpan MaxAllowedTimeBetweenReceives = TimeSpan.FromSeconds(300);
        private static readonly TimeSpan MaxTimeUntilFullError = TimeSpan.FromMinutes(10);

        private readonly IHubContext<SmokeHub> smokeHub;
        private readonly SmokeStateRepo smokeStateRepo;

        public LastReceivedHostedService(IHubContext<SmokeHub> smokeHub, SmokeStateRepo smokeStateRepo)
        {
            this.smokeHub = smokeHub;
            this.smokeStateRepo = smokeStateRepo;
        }

        protected override async Task ExecuteAsync(CancellationToken ct)
        {
            while (!ct.IsCancellationRequested)
            {
                // Get last received timestamp from smoke state and update UI via SignalR.
                var lastReceived = GetLastReceived(smokeStateRepo.LastReceived);
                await smokeHub.Clients.All.SendAsync("UpdateLastReceived", lastReceived);
                await Task.Delay(TimeSpan.FromSeconds(1));
            }
        }

        internal static LastReceived GetLastReceived(DateTimeOffset? lastReceived)
        {
            if (!lastReceived.HasValue)
            {
                return new LastReceived();
            }

            // Get diff between now and last received.
            var lastReceivedDiff = DateTimeOffset.UtcNow - lastReceived.Value;
            var diffText = lastReceivedDiff < TimeSpan.FromHours(1)
                ? lastReceivedDiff.ToString("%m' minutes, '%s' seconds'")
                : lastReceivedDiff.ToString("%d' hours, '%m' minutes, '%s' seconds'");
            var status =
                    Math.Max((lastReceivedDiff - MaxAllowedTimeBetweenReceives).TotalMilliseconds, 0)
                    /
                    (MaxTimeUntilFullError - MaxAllowedTimeBetweenReceives).TotalMilliseconds;
            var lastReceivedStatus = new LastReceived
            {
                Time = lastReceived,
                DiffText = diffText,
                Status = status

            };
            return lastReceivedStatus;
        }
    }
}