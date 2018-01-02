using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Hosting;

namespace SmokeTestsDashboardServer
{
    internal class LastReceivedHostedService : HostedService
    {
        private readonly IHubContext<SmokeHub> smokeStatus;

        public LastReceivedHostedService(IHubContext<SmokeHub> smokeStatus)
        {
            this.smokeStatus = smokeStatus;
        }

        protected override async Task ExecuteAsync(CancellationToken ct)
        {
            while (!ct.IsCancellationRequested)
            {
                await smokeStatus.Clients.All.InvokeAsync("UpdateLastReceived", DateTimeOffset.UtcNow);
                await Task.Delay(TimeSpan.FromSeconds(10));
            }
        }
    }
}