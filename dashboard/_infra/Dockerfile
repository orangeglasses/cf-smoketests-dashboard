FROM mcr.microsoft.com/dotnet/sdk:6.0 as builder

WORKDIR /src
COPY . .

RUN dotnet tool install -g Microsoft.Web.LibraryManager.Cli
RUN dotnet restore
RUN /root/.dotnet/tools/libman restore
RUN dotnet publish --output /artifact/ --configuration Release

FROM mcr.microsoft.com/dotnet/aspnet:6.0

WORKDIR /app
COPY --from=builder /artifact .

ENTRYPOINT [ "dotnet", "SmokeTestsDashboardServer.dll"]