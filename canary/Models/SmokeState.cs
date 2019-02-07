namespace cf_smoketests_canary.Models
{
    public class SmokeState
    {
        public SmokeState()
        {
            Results = new SmokeStateResult[] { };
        }

        public string Key { get; set; }
        public bool Result { get; set; }
        public string Name { get; set; }
        public SmokeStateResult[] Results { get; set; }
    }

    public class SmokeStateResult
    {
        public bool Result { get; set; }
        public string Name { get; set; }
    }
}