using System.Collections.Generic;

namespace cf_smoketests_canary.Configuration
{
    public class TestConfiguration
    {
        public string Key { get; set; }
        public string Name { get; set; }
        public string Operation { get; set; }
        public string Url { get; set; }
        public int TestIntervalInMinutes { get; set; }
    }
}