FROM mcr.microsoft.com/dotnet/sdk:8.0 as builder

WORKDIR /src
COPY SmokeTestsDashboardServer.csproj ./
RUN dotnet restore

COPY . .
RUN dotnet tool install -g Microsoft.Web.LibraryManager.Cli
RUN /root/.dotnet/tools/libman restore
RUN dotnet publish --output /artifact/ --configuration Release

FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app
COPY --from=builder /artifact .

ENTRYPOINT [ "dotnet", "SmokeTestsDashboardServer.dll"]
