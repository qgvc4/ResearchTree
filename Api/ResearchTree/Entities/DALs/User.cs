using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using ResearchTree.Entities.Declaration;

namespace ResearchTree.Entities.DALs
{
    public class User : IdentityUser
    {
        [Required]
        public string FirstName { get; set; }

        [Required]
        public string Lastname { get; set; }

        [Required]
        public string Majors { get; set; }

        public byte[] Image { get; set; }

        [Required]
        public Role Role { get; set; }

        public Standing Standing { get; set; }

        [Required]
        [RegularExpression(@"^(?!00000)[0-9]{5,5}$")]
        public string Location { get; set; }

        public string Description { get; set; }

        public byte[] Resume { get; set; }
    }
}
