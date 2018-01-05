using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;

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
        public async Task<IActionResult> Post([FromBody] JArray rawSmokeState)
        {
            // Pass smoke state to repo.
            await smokeStateRepo.SetRawSmokeStateAsync(rawSmokeState);

            return NoContent();
        }
    }
}