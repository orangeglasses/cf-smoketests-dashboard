using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using SmokeTestsDashboardServer;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSignalR();
builder.Services.AddSingleton<IHostedService, LastReceivedHostedService>();

builder.Services.AddMvc(options =>
{
    options.InputFormatters.Add(new TextPlainInputFormatter());
});

builder.Services.AddSingleton<SmokeStateRepo>();

var app = builder.Build();

app.UseDefaultFiles();
app.UseStaticFiles();
app.UseRouting();
app.UseEndpoints(endpoints => {
    endpoints.MapControllers();
    endpoints.MapHub<SmokeHub>("/smoke");
});

app.Run();