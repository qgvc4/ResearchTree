using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchTree.Models
{
    public class ResearchTreeContext : DbContext
    {
        public ResearchTreeContext(DbContextOptions<ResearchTreeContext> options)
            : base(options)
        {

        }

        
    }
}
