using System.Threading;
using System.Threading.Tasks;

namespace SmokeTestsDashboardServer
{
    internal class SmokeStateHostedService : HostedService
    {
        private string data = "[{\"key\":\"me\",\"result\":true,\"name\":\"Me\"},{\"key\":\"mysql\",\"result\":true,\"name\":\"MySQL\",\"results\":[{\"result\":true,\"name\":\"Read service binding\"},{\"result\":true,\"name\":\"Open connection\"},{\"result\":true,\"name\":\"Prepare create table\"},{\"result\":true,\"name\":\"Create table\"},{\"result\":true,\"name\":\"Prepare insert record\"},{\"result\":true,\"name\":\"Insert record\"},{\"result\":true,\"name\":\"Select records\"},{\"result\":true,\"name\":\"Prepare delete record\"},{\"result\":true,\"name\":\"Delete record\"}]},{\"key\":\"sso\",\"result\":true,\"name\":\"Single Sign-On\",\"results\":[{\"result\":true,\"name\":\"Read service binding\"},{\"result\":true,\"name\":\"Client credentials grant\"},{\"result\":true,\"name\":\"Create local user\"},{\"result\":true,\"name\":\"Get local groups/scopes\"},{\"result\":true,\"name\":\"Add local user to group\"},{\"result\":true,\"name\":\"Resource owner password credentials grant\"},{\"result\":true,\"name\":\"Authorization code grant (UAA)\"},{\"result\":true,\"name\":\"Authorization code grant (ADFS)\"}]},{\"key\":\"sharepoint\",\"result\":true,\"name\":\"SharePoint\",\"results\":[{\"result\":true,\"name\":\"Read service binding\"},{\"result\":true,\"name\":\"Test /info endpoint\"},{\"result\":true,\"name\":\"Add file\"},{\"result\":true,\"name\":\"Get file\"},{\"result\":true,\"name\":\"Read file\"},{\"result\":true,\"name\":\"Compare file with uploaded\"},{\"result\":true,\"name\":\"Delete file\"}]},{\"key\":\"rabbitmq\",\"result\":true,\"name\":\"RabbitMQ\",\"results\":[{\"result\":true,\"name\":\"Create publishing channel\"},{\"result\":true,\"name\":\"Declare queue\"},{\"result\":true,\"name\":\"Publish message\"},{\"result\":true,\"name\":\"Create listening channel\"},{\"result\":true,\"name\":\"Consume message\"},{\"result\":true,\"name\":\"Check message\"}]},{\"key\":\"rabbitmq\",\"result\":true,\"name\":\"RabbitMQ\",\"results\":[{\"result\":true,\"name\":\"Ping\"},{\"result\":true,\"name\":\"Pong\"}]}]";

        protected override Task ExecuteAsync(CancellationToken cancellationToken)
        {
            throw new System.NotImplementedException();
        }
    }
}