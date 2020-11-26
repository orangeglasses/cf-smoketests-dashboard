using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MetricDashboard.lib.models;
using Microsoft.AspNetCore.SignalR;

namespace MetricDashboard
{
    public class MetricsRepo
    {
        private readonly IHubContext<MetricsHub> _metricsHub;
        internal List<Metric> CurrentMetricsCollection;

        public MetricsRepo(IHubContext<MetricsHub> metricsHub)
        {
            _metricsHub = metricsHub;
            CurrentMetricsCollection = new List<Metric>();
        }

        internal async Task RecordMetricAsync(Metric newMetric)
        {
            var metric = CurrentMetricsCollection.FirstOrDefault(m => m.Node == newMetric.Node);

            if (metric != null)
            {
                if (newMetric.FpsValue == -1)
                {
                    CurrentMetricsCollection.Remove(metric);
                }
                else
                {
                    metric.FpsValue = metric.FpsValue + newMetric.FpsValue;
                }
            }
            else
            {
                CurrentMetricsCollection.Add(newMetric);
            }

            await _metricsHub.Clients.All.SendAsync("updateCounters", CurrentMetricsCollection.ToArray());
        }
    }
}