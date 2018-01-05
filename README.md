# Getting stuff up-and-running
- [Install Elm](https://guide.elm-lang.org/install.html)
- Install .NET Core
- Run `dotnet restore`
- Run `elm-make elm\AppStyles.elm elm\Main.elm elm\Model.elm elm\View.elm elm\TestResult\Model.elm elm\TestResult\View.elm --output wwwroot\js\main.js`
- Run `dotnet run` or `dotnet watch run`
- Browse to [`localhost:5000`](http://localhost:5000)
