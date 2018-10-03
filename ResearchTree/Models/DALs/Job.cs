using System;
using System.ComponentModel.DataAnnotations;
using ResearchTree.Models.Declaration;

namespace ResearchTree.Models.DALs
{
    public class Job
    {
        [Key]
        public string Id { get; set; }

        [Required]
        public string PeopleId { get; set; }

        [Required]
        public string Title { get; set; }

        [Required]
        public string Description { get; set; }

        [Required]
        public Standing Standing { get; set; }

        [Required]
        public bool Payment { get; set; }

        [Required]
        public string Majors { get; set; }

        [Required]
        public DateTime ModifyTime { get; set; }

        [Required]
        [RegularExpression(@"^(?!00000)[0-9]{5,5}$")]
        public string Location { get; set; }
    }
}
