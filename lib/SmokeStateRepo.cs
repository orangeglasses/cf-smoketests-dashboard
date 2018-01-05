using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace SmokeTestsDashboardServer
{
    public class SmokeStateRepo
    {
        private readonly IHubContext<SmokeHub> smokeHub;

        private JArray currentSmokeState;
        private int? currentSmokeHash;
        private DateTimeOffset? lastReceived;

        public SmokeStateRepo(IHubContext<SmokeHub> smokeHub)
        {
            this.smokeHub = smokeHub;
        }

        internal DateTimeOffset? LastReceived => lastReceived;

        internal JArray CurrentSmokeState => currentSmokeState;

        internal async Task SetRawSmokeStateAsync(JArray rawSmokeState)
        {
            // Calculate hash and compare with current.
            var rawSmokeStateString = JsonConvert.SerializeObject(rawSmokeState, Formatting.None);
            var newSmokeHash = rawSmokeStateString.GetHashCode();

            if (newSmokeHash != currentSmokeHash)
            {
                currentSmokeState = rawSmokeState;
                currentSmokeHash = newSmokeHash;

                // Push new smoke state to client via SignalR.
                await smokeHub.Clients.All.InvokeAsync("UpdateTestResults", rawSmokeState);
            }

            // Update last received.
            lastReceived = DateTimeOffset.UtcNow;
        }
    }
}