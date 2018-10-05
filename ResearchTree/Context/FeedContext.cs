using Microsoft.EntityFrameworkCore;
using ResearchTree.Entities.DALs;

namespace ResearchTree.Context
{
    public class FeedContext : DbContext
    {
        public FeedContext(DbContextOptions<FeedContext> options) : base(options)
        {

        }

        public DbSet<Feed> Feeds { get; set; }
    }
}
