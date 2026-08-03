using System;

namespace WebApplication4
{
    [Serializable]
    public class ReferenceModel
    {
        public string ReferenceName { get; set; }

        public string Relationship { get; set; }

        public string Organization { get; set; }

        public string JobTitle { get; set; }

        public string Email { get; set; }

        public string Phone { get; set; }

        public string Address { get; set; }

        public string YearsKnown { get; set; }
    }
}