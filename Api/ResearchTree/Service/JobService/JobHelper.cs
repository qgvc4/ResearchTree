using System;
using System.Linq;
using ResearchTree.Entities.Api;
using ResearchTree.Entities.Declaration;

namespace ResearchTree.Service.JobService
{
    public class JobHelper
    {
        public Job Converter(Entities.DALs.Job job)
        {
            return new Job
            {
                Id = job.Id,
                PeopleId = job.PeopleId,
                Title = job.Title,
                Description = job.Description,
                Standing = job.Standing,
                Payment = job.Payment,
                Majors = job.Majors.Split(',').Select(c => (Major)Enum.Parse(typeof(Major), c)).ToList(),
                ModifyTime = job.ModifyTime,
                Location = job.Location
            };
        }

        public Entities.DALs.Job Converter(Job job)
        {
            return new Entities.DALs.Job
            {
                Id = job.Id,
                PeopleId = job.PeopleId,
                Title = job.Title,
                Description = job.Description,
                Standing = job.Standing,
                Payment = job.Payment,
                Majors = string.Join(", ", job.Majors.Select(e => e.ToString())),
                ModifyTime = job.ModifyTime,
                Location = job.Location
            };
        }
    }
}
