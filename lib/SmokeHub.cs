using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;

namespace SmokeTestsDashboardServer
{
    public class SmokeHub : Hub
    {
        public Task Send(int counter)
        {
            return Clients.All.InvokeAsync("Send", counter);
        }
    }
}
