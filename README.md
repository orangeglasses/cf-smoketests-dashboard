# Metrics dashboard and tester

The repo contains all the source for a dashboard and smoketesting client.

### Getting the dashboard up and running:
- [Install .NET Core 3.1](https://dotnet.microsoft.com/download)
- Install libman: `dotnet tool install -g Microsoft.Web.LibraryManager.Cli`
- Install Prometheus lib: `dotnet add package prometheus-net.AspNetCore`
- Install SignalR client libs: `libman install @microsoft/signalr@latest -p unpkg -d wwwroot/js/signalr --files dist/browser/signalr.js --files dist/browser/signalr.min.js`
- Run `dotnet run` (or `dotnet watch run`)
- Browse to [`localhost:5000`](http://localhost:5000)
- Prometheus metrics exported at [`localhost:5000/metrics`](http://localhost:5000/metrics)

## Testing the dashboard

You can submit testdata using the following `curl` command while the dashboard webserver is running:

    curl -X POST -H "Content-Type: application/json" -d '{"node":"test-node", "fpsvalue": 100}' localhost:5000/api/metrics
    
The submitted data should appear on screen instantly if everything is working correct.

## Docker

Build the image from the `/dashboard` folder:

    docker build -f ./_infra/Dockerfile  -t dashboard .

After building, run the image:

    docker run --rm -p 9001:80 dashboard