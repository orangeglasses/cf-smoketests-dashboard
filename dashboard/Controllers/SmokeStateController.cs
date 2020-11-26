using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using cf_smoketests_dashboard.lib.models;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;

namespace MetricDashboard.Controllers
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