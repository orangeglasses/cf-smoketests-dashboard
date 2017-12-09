using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;

namespace SmokeTestsDashboardServer
{
    public class SmokeHub : Hub
    {
        public Task Send(string message)
        {
            return Clients.All.InvokeAsync("Send", message);
        }
    }
}
