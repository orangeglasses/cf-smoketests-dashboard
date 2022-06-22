# ITQ Smoketester dashboard and tester

The repo contains all the source for a dashboard and smoketesting client.

### Getting the dashboard up and running:
- [Install .NET Core 6](https://dotnet.microsoft.com/download)
- Install libman: `dotnet tool install -g Microsoft.Web.LibraryManager.Cli`
- Install SignalR client libs: `libman install @microsoft/signalr@latest -p unpkg -d wwwroot/js/signalr --files dist/browser/signalr.js --files dist/browser/signalr.min.js`
- Run `dotnet run` (or `dotnet watch run`)
- Browse to [`localhost:5000`](http://localhost:5000)

### Getting the tester up and running:
- Have .NET Core installed
- Add any tests you might want to run to the appsettings.json
- Run `dotnet run`

## Dashboard

The dashboard receives its data from the canary test client in the following format:

    [{
      "key": "test0",
      "result": true,
      "name": "Test 0"
    },
    {
      "key": "test1",
      "result": true,
      "name": "Test 1",
      "results": [{
        "result": true,
        "name": "Part 0 of test 1"
      },
      {
        "result": true,
        "name": "Part 1 of test 1"
      }]
    },
    {
      "key": "test2",
      "result": false,
      "name": "Test 2",
      "results": [{
        "result": true,
        "name": "Part 0 of test 2"
      },
      {
        "result": false,
        "name": "Part 1 of test 2",
        "error": "An error occurred in part 1 of test 2"
      }]
    }]

An array that contains objects that describe test results. When the dashboard receives results they are pushed to the UI via a websocket. There are 2 variants as seen above. A simple object describing a passed or failed test and an object that has an array of sub-results that have their own result and name.

The dashboard webserver exposes an endpoint at `/api/smokestate` where clients can post their data. As long as the data is in the format described above, it will accept it.

## Canary (test client)

The testclient is a console app that runs `HTTP GET` requests agains endpoints at a specified interval. These tests can be configured in `appsettings.json` or via environment variables:

appsettings.json:

    {
        "Tests": [
            {
                "Key": "itq_nl",
                "Name": "ITQ.nl site",
                "Url": "https://www.itq.nl",
                "TestIntervalInMinutes": 5
            }
        ]
    }

environment variables: (example in Powershell)

    $env:Tests:0:Key="itq_nl"
    $env:Tests:0:Name="ITQ.nl site"
    $env:Tests:0:Url="https://www.itq.nl"
    $env:Tests:0:TestIntervalInMinutes=5

It also needs a host to send the test result to, it can be configured in the same locations as the tests.

    {
        "DashboardSmokeStateEndpoint": "http://localhost:5000",
    }

See `appsettings.Development.json` for a full example.

# Notes about this project

As you may have seen in the code, smoke state is kept in an in-memory dictionary. This poses challenges to scaling, the obvious solution would be to introduce a storage facility (Redis, etc.) to hold on to that state. We could add support for Redis and/or other databases but we don't want to introduce a dependency into our code that might not work for you, there's no garantees that whatever storage we pick is available in your platforms so for now, we'll leave it as is. This being a dashboard and does not have an interaction besides the websocket it receives from, the need for scaling is probably also very low.

Adding support for storage is done by changing the `SmokeStateRepo.cs` class to store its data somewhere else.