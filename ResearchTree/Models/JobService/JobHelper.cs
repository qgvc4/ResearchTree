using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Net.Mail;
using System.Threading.Tasks;
using Newtonsoft.Json;
using ResearchTree.Models.Declaration;

namespace ResearchTree.Models.JobService
{
    public class JobHelper
    {
        public Job Converter(DALs.Job job)
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

        public DALs.Job Converter(Job job)
        {
            return new DALs.Job
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
