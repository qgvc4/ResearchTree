using System;
using System.Collections.Generic;
using ResearchTree.Entities.Declaration;

namespace ResearchTree.Service.JobService
{
    public class Job
    {
        public string Id { get; set; }
        public string PeopleId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public Standing Standing { get; set; }
        public bool Payment { get; set; }
        public List<Major> Majors { get; set; }
        public DateTime ModifyTime { get; set; }
        public string Location { get; set; }
    }
}
