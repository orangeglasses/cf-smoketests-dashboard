using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MetricDashboard.lib.models;
using Microsoft.AspNetCore.SignalR;
using Prometheus;

namespace MetricDashboard
{
    public class MetricsRepo
    {
        private static readonly Gauge Aggregate_FPS = Metrics.CreateGauge("aggregate_fps", "Total FPS from all instances");

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
                    metric.FpsValue = newMetric.FpsValue;
                }
            }
            else
            {
                CurrentMetricsCollection.Add(newMetric);
            }

            //Update Prometheus metric
            Aggregate_FPS.Set(newMetric.FpsValue);

            await _metricsHub.Clients.All.SendAsync("updateCounters", CurrentMetricsCollection.ToArray());
        }
    }
}