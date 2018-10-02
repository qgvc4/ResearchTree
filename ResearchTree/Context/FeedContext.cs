using Microsoft.EntityFrameworkCore;
using ResearchTree.Models;

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
