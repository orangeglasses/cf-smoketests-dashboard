# Getting stuff up-and-running
- [Install Elm 0.19](https://guide.elm-lang.org/install.html)
- [Install .NET Core 2.2](https://dotnet.microsoft.com/download)
- Run `elm make elm\AppStyles.elm elm\Main.elm elm\Model.elm elm\View.elm elm\TestResult\Model.elm elm\TestResult\View.elm --output wwwroot\js\main.js`
- Run `dotnet run` (or `dotnet watch run`)
- Browse to [`localhost:5000`](http://localhost:5000)

# Providing data
The app exposes an endpoint at [/api/smokestate](http://localhost:5000/api/smokestate). You can post JSON data there with the following format:

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