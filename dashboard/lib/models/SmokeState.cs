namespace cf_smoketests_dashboard.lib.models
{
    public class SmokeTest
    {
        public string Key {get;set;}
        public string Name {get;set;}
        public bool Result {get;set;}
        public SmokeTestResult[] Results {get;set;}
    }

    public class SmokeTestResult
    {
        public string Name {get;set;}
        public bool Result {get;set;}
    }
}