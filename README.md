# Metrics dashboard and tester

The repo contains all the source for a dashboard and smoketesting client.

### Getting the dashboard up and running:
- [Install .NET Core 3.1](https://dotnet.microsoft.com/download)
- Install libman: `dotnet tool install -g Microsoft.Web.LibraryManager.Cli`
- Install SignalR client libs: `libman install @microsoft/signalr@latest -p unpkg -d wwwroot/js/signalr --files dist/browser/signalr.js --files dist/browser/signalr.min.js`
- Run `dotnet run` (or `dotnet watch run`)
- Browse to [`localhost:5000`](http://localhost:5000)

### Getting the tester up and running:
- Have .NET Core installed
- Add any tests you might want to run to the appsettings.json
- Run `dotnet run`

## Testing the dashboard

You can submit testdata using the following `curl` command while the dashboard webserver is running:

    curl -X POST -H "Content-Type: application/json" -d '{"node":"test-node", "fpsvalue": 100}' localhost:5000/api/metrics