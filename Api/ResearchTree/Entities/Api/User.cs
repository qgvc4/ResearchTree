using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ResearchTree.Entities.Declaration;

namespace ResearchTree.Entities.Api
{
    public class User
    {
        public string Id { get; set; }

        public string Email { get; set; }

        public string Password { get; set; }

        public string Token { get; set; }

        public string FirstName { get; set; }

        public string Lastname { get; set; }

        public List<Major> Majors { get; set; }

        public byte[] Image { get; set; }

        public Role Role { get; set; }

        public Standing Standing { get; set; }

        public string Location { get; set; }

        public string Description { get; set; }

        public byte[] Resume { get; set; }
    }
}
