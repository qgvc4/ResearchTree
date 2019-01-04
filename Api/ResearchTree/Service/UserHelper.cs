using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ResearchTree.Entities.Api;
using ResearchTree.Entities.Declaration;

namespace ResearchTree.Service
{
    public class UserHelper
    {
        public User Converter(Entities.DALs.User user)
        {
            return new User
            {
                Id = user.Id,
                Email = user.Email,
                Firstname = user.Firstname,
                Lastname = user.Lastname,
                Description = user.Description,
                Image = user.Image,
                Location = user.Location,
                Majors = user.Majors.Split(',').Select(c => (Major) Enum.Parse(typeof(Major), c)).ToList(),
                Role = user.Role,
                Standing = user.Standing,
                Resume = user.Resume
            };
        }

        public Entities.DALs.User Converter(User user)
        {
            return new Entities.DALs.User
            {
                Id = user.Id,
                UserName = user.Email,
                Email = user.Email,
                Firstname = user.Firstname,
                Lastname = user.Lastname,
                Description = user.Description,
                Image = user.Image,
                Location = user.Location,
                Majors = string.Join(", ", user.Majors.Select(e => e.ToString())),
                Role = user.Role,
                Standing = user.Standing,
                Resume = user.Resume
            };
        }
    }
}
