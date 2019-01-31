using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;

namespace SmokeTestsDashboardServer
{
    public class SmokeHub : Hub
    {
        private readonly SmokeStateRepo smokeStateRepo;

        public SmokeHub(SmokeStateRepo smokeStateRepo)
        {
            this.smokeStateRepo = smokeStateRepo;

        }

        public override async Task OnConnectedAsync()
        {
            var connId = this.Context.ConnectionId;
            var currentClient = this.Clients.Client(connId);

            // Get current last received state and send to connecting client.
            var lastReceived = smokeStateRepo.LastReceived;
            var lastReceivedStatus = LastReceivedHostedService.GetLastReceived(lastReceived);
            
            await currentClient.SendAsync("UpdateLastReceived", lastReceived);

            // Get current smoke state and send to connecting client.
            var currentSmokeState = smokeStateRepo.CurrentSmokeState;
            if (currentSmokeState != null)
            {
                await currentClient.SendAsync("UpdateTestResults", currentSmokeState);
            }

            await base.OnConnectedAsync();
        }
    }
}
