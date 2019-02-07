using System;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Timers;
using cf_smoketests_canary.Configuration;
using cf_smoketests_canary.Models;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace cf_smoketests_canary.Runners
{
    public class BasicHttpTestRunner : ITestRunner
    {
        private readonly TestConfiguration _test;
        private readonly ILogger<BasicHttpTestRunner> _logger;
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly Timer _timer;

        public BasicHttpTestRunner(TestConfiguration test, ILogger<BasicHttpTestRunner> logger, IHttpClientFactory httpClientFactory)
        {
            _test = test;
            _logger = logger;
            _httpClientFactory = httpClientFactory;

            _timer = new Timer(test.TestIntervalInMinutes * 60 * 1000);
            _timer.Elapsed += async (e, a) =>
            {
                LogInfo("Running test...");

                using (var client = _httpClientFactory.CreateClient())
                {
                    try
                    {
                        var response = await client.GetAsync(_test.Url);

                        if (response.IsSuccessStatusCode)
                        {
                            LogInfo("Response OK");
                            await Report(true);
                        }
                        else
                        {
                            LogError("Response Error");
                            await Report(false, new string[] { "Received an error response!" });
                        }
                    }
                    catch (Exception ex)
                    {
                        LogError($"Request failed! {ex.Message}");
                        await Report(false, new string[] { $"Request failed! {ex.Message}" });
                    }
                }
            };
        }

        public void Start()
        {
            _timer.Start();
            LogInfo("Testrunner started");
        }

        private async Task Report(bool success, params string[] errors)
        {
            try
            {
                using (var smokeStateClient = _httpClientFactory.CreateClient("smokeState"))
            {
                var payload = new SmokeState[] 
                {
                    new SmokeState
                    {
                        Key = _test.Key,
                        Name = _test.Name,
                        Result = success,
                        Results = errors.Select(e => new SmokeStateResult 
                        {
                            Name = e,
                            Result = false
                        }).ToArray()
                    }
                };

                var payloadString = JsonConvert.SerializeObject(payload);
                var response = await smokeStateClient.PostAsync("/api/smokestate", new StringContent(payloadString, Encoding.UTF8, "application/json"));
            }
            }
            catch (Exception ex)
            {
                _logger.LogCritical($"Failed to submit test results to dashboard! {ex.Message}");
            }
        }

        private void LogInfo(string message)
        {
            _logger.LogInformation($"{_test.Key} :: {message}");
        }

        private void LogError(string message)
        {
            _logger.LogError($"{_test.Key} :: {message}");
        }
    }
}