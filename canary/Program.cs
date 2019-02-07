using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using cf_smoketests_canary.Configuration;
using cf_smoketests_canary.Runners;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Configuration.Json;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace cf_smoketests_canary
{
    public class Program
    {
        public static void Main(string[] args) =>
            Run(args);

        public static void Run(string[] args)
        {
            var serviceCollection = new ServiceCollection();
            Configure(serviceCollection);

            var provider = serviceCollection.BuildServiceProvider();

            // Ask for all the testrunners we've configured and start them.
            var runners = provider.GetServices<ITestRunner>();
            foreach (var r in runners)
            {
                r.Start();
            }

            // Don't exit.
            Console.ReadLine();
        }

        private static void Configure(IServiceCollection services)
        {
            // Set the default JSON.net format to camelCase
            JsonConvert.DefaultSettings = () => new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver()
            };

            // Load configuration.
            var configBuilder = new ConfigurationBuilder();
            configBuilder.SetBasePath(Directory.GetCurrentDirectory());

            configBuilder.AddJsonFile("appsettings.json", optional: false);
            configBuilder.AddJsonFile("appsettings.Development.json", optional: true);
            configBuilder.AddEnvironmentVariables();

            var configuration = configBuilder.Build();

            // Set up logging.
            services.AddLogging(builder =>
            {
                builder.AddConsole();
            });

            // Set up an empty client for the basic http test runner.
            services.AddHttpClient();
            // Set up a client that can send test results to the dashboard.
            services.AddHttpClient("smokeState", client =>
            {
                var endpointAddress = configuration.GetValue<string>("DashboardSmokeStateEndpoint");
                client.BaseAddress = new Uri(endpointAddress);
            });

            // Grab the configured tests from the configuration.
            var tests = new List<TestConfiguration>();
            configuration.GetSection("Tests").Bind(tests);

            // Load a tester for every test we find in the config.
            foreach (var t in tests)
            {
                services.AddSingleton(typeof(ITestRunner), sp =>
                {
                    return new BasicHttpTestRunner(t, sp.GetService<ILogger<BasicHttpTestRunner>>(), sp.GetService<IHttpClientFactory>());
                });
            }
        }
    }
}
