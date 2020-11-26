using System.Threading.Tasks;
using MetricDashboard.lib.models;
using Microsoft.AspNetCore.Mvc;

namespace MetricDashboard.Controllers
{
    [Route("api/[controller]")]
    public class MetricsController : Controller
    {
        private readonly MetricsRepo _metricsRepo;

        public MetricsController(MetricsRepo metricsRepo)
        {
            _metricsRepo = metricsRepo;
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] Metric metric)
        {
            await _metricsRepo.RecordMetricAsync(metric);
            return NoContent();
        }
    }
}