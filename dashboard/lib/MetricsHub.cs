using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;

namespace MetricDashboard
{
    public class MetricsHub : Hub
    {
        private readonly MetricsRepo _metricsRepo;

        public MetricsHub(MetricsRepo metricsRepo)
        {
            _metricsRepo = metricsRepo;
        }

        public override async Task OnConnectedAsync()
        {
            var connId = this.Context.ConnectionId;
            var currentClient = this.Clients.Client(connId);

            var currentMetrics = _metricsRepo.CurrentMetricsCollection;
            if (currentMetrics != null)
            {
                await currentClient.SendAsync("updateCounters", currentMetrics);
            }

            await base.OnConnectedAsync();
        }
    }
}
