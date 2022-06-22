using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using cf_smoketests_dashboard.lib.models;

namespace SmokeTestsDashboardServer.Controllers
{
    [Route("api/[controller]")]
    public class SmokeStateController : Controller
    {
        private readonly SmokeStateRepo smokeStateRepo;

        public SmokeStateController(SmokeStateRepo smokeStateRepo)
        {
            this.smokeStateRepo = smokeStateRepo;
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] SmokeTest[] rawSmokeState)
        {
            // Pass smoke state to repo
            await smokeStateRepo.SetRawSmokeStateAsync(rawSmokeState);

            return NoContent();
        }
    }
}