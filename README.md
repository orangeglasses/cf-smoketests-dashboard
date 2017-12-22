# Getting stuff up-and-running
- [Install Elm](https://guide.elm-lang.org/install.html)
- Run
  - `elm-package install elm-lang/html`
  - `elm-package install mgold/elm-date-format`
  in the root of the project
- Run `elm-make .\elm\Main.elm --output .\wwwroot\js\main.js`
- Install .NET Core
- Run `dotnet restore` in the root of the project
- Run `dotnet run` or `dotnet watch run` in the root of the project
- Browse to [`localhost:5000`](http://localhost:5000)