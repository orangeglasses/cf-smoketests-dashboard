using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using Newtonsoft.Json.Linq;

namespace SmokeTestsDashboardServer
{
    internal class SmokeStateHostedService : HostedService
    {
        private string data = "[{\"key\":\"me\",\"result\":true,\"name\":\"Me\"},{\"key\":\"mysql\",\"result\":false,\"name\":\"MySQL\",\"results\":[{\"result\":true,\"name\":\"Read service binding\"},{\"result\":true,\"name\":\"Open connection\"},{\"result\":false,\"name\":\"Prepare create table\"},{\"result\":true,\"name\":\"Create table\"},{\"result\":true,\"name\":\"Prepare insert record\"},{\"result\":true,\"name\":\"Insert record\"},{\"result\":true,\"name\":\"Select records\"},{\"result\":true,\"name\":\"Prepare delete record\"},{\"result\":true,\"name\":\"Delete record\"}]},{\"key\":\"sso\",\"result\":true,\"name\":\"Single Sign-On\",\"results\":[{\"result\":true,\"name\":\"Read service binding\"},{\"result\":true,\"name\":\"Client credentials grant\"},{\"result\":true,\"name\":\"Create local user\"},{\"result\":true,\"name\":\"Get local groups/scopes\"},{\"result\":true,\"name\":\"Add local user to group\"},{\"result\":true,\"name\":\"Resource owner password credentials grant\"},{\"result\":true,\"name\":\"Authorization code grant (UAA)\"},{\"result\":true,\"name\":\"Authorization code grant (ADFS)\"}]},{\"key\":\"sharepoint\",\"result\":true,\"name\":\"SharePoint\",\"results\":[{\"result\":true,\"name\":\"Read service binding\"},{\"result\":true,\"name\":\"Test /info endpoint\"},{\"result\":true,\"name\":\"Add file\"},{\"result\":true,\"name\":\"Get file\"},{\"result\":true,\"name\":\"Read file\"},{\"result\":true,\"name\":\"Compare file with uploaded\"},{\"result\":true,\"name\":\"Delete file\"}]},{\"key\":\"rabbitmq\",\"result\":true,\"name\":\"RabbitMQ\",\"results\":[{\"result\":true,\"name\":\"Create publishing channel\"},{\"result\":true,\"name\":\"Declare queue\"},{\"result\":true,\"name\":\"Publish message\"},{\"result\":true,\"name\":\"Create listening channel\"},{\"result\":true,\"name\":\"Consume message\"},{\"result\":true,\"name\":\"Check message\"}]},{\"key\":\"redis\",\"result\":true,\"name\":\"Redis\",\"results\":[{\"result\":true,\"name\":\"Ping\"},{\"result\":true,\"name\":\"Pong\"}]}]";

        private readonly IHubContext<SmokeHub> smokeStatus;

        public SmokeStateHostedService(IHubContext<SmokeHub> smokeStatus)
        {
            this.smokeStatus = smokeStatus;
        }

        protected override async Task ExecuteAsync(CancellationToken ct)
        {
            // Parse JSON array.
            var dataArray = JArray.Parse(data);

            while (!ct.IsCancellationRequested)
            {
                await smokeStatus.Clients.All.InvokeAsync("UpdateTestResults", dataArray);
                await Task.Delay(TimeSpan.FromSeconds(7));
            }
        }
    }
}