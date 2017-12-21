using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;

namespace SmokeTestsDashboardServer
{
    public class SmokeHub : Hub
    {
        public void Send(Counter counter)
        {
            Console.WriteLine("Counter: " + counter.Count);
        }
    }
}
