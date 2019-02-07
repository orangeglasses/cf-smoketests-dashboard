using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using cf_smoketests_dashboard.lib.models;
using Microsoft.AspNetCore.SignalR;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace SmokeTestsDashboardServer
{
    public class SmokeStateRepo
    {
        private readonly IHubContext<SmokeHub> smokeHub;
        internal List<SmokeTest> CurrentSmokeState;
        private DateTimeOffset? lastReceived;

        public SmokeStateRepo(IHubContext<SmokeHub> smokeHub)
        {
            this.smokeHub = smokeHub;
            this.CurrentSmokeState = new List<SmokeTest>();
        }

        internal DateTimeOffset? LastReceived => lastReceived;


        internal async Task SetRawSmokeStateAsync(SmokeTest[] rawSmokeState)
        {
            foreach(var state in rawSmokeState)
            {
                if(CurrentSmokeState.Any(cs => cs.Key == state.Key))
                {
                    var existing = CurrentSmokeState.First(cs => cs.Key == state.Key);
                    var index = CurrentSmokeState.IndexOf(existing);

                    CurrentSmokeState[index] = state;
                }
                else
                {
                    CurrentSmokeState.Add(state);
                }
            }

            await smokeHub.Clients.All.SendAsync("UpdateTestResults", CurrentSmokeState.ToArray());

            // Update last received.
            lastReceived = DateTimeOffset.UtcNow;
        }
    }
}