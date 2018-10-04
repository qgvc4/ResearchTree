using Microsoft.EntityFrameworkCore;
using ResearchTree.Entities.DALs;

namespace ResearchTree.Context
{
    public class JobContext : DbContext
    {
        public JobContext(DbContextOptions<JobContext> options) : base(options)
        {

        }

        public DbSet<Job> Jobs { get; set; }
    }
}
