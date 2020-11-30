FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as builder

WORKDIR /src
COPY . .

RUN dotnet tool install -g Microsoft.Web.LibraryManager.Cli
RUN dotnet add package prometheus-net.AspNetCore
RUN dotnet restore
RUN /root/.dotnet/tools/libman restore
RUN dotnet publish --output /artifact/ --configuration Release

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

EXPOSE 80
WORKDIR /app

COPY --from=builder /artifact .

ENTRYPOINT [ "dotnet", "Dashboard.dll"]