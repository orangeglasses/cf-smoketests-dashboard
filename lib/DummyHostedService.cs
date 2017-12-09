using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Hosting;

namespace SmokeTestsDashboardServer
{

    internal class CounterHostedService : HostedService
    {
        private int counter;
        private readonly IHubContext<SmokeHub> smokeStatus;

        public CounterHostedService(IHubContext<SmokeHub> smokeStatus)
        {
            this.counter = 0;
            this.smokeStatus = smokeStatus;
        }

        protected override async Task ExecuteAsync(CancellationToken ct)
        {
            while (!ct.IsCancellationRequested)
            {
                await smokeStatus.Clients.All.InvokeAsync("Send", counter++.ToString());
                await Task.Delay(5000);
            }
        }
    }
}