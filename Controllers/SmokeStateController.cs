using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace SmokeTestsDashboardServer.Controllers
{
    [Route("api/[controller]")]
    public class SmokeStateController : Controller
    {
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] string rawSmokeState)
        {
            return Ok(rawSmokeState);
        }
    }
}