using ResearchTree.Entities.Api;

namespace ResearchTree.Service.FeedService
{
    public class FeedHelper
    {
        public Feed Converter(Entities.DALs.Feed feed)
        {
            return new Feed
            {
                Id = feed.Id,
                PeopleId = feed.PeopleId,
                Title = feed.Title,
                Description = feed.Description,
                ModifyTime = feed.ModifyTime,
                Attachment = feed.Attachment
            };
        }

        public Entities.DALs.Feed Converter(Feed feed)
        {
            return new Entities.DALs.Feed
            {
                Id = feed.Id,
                PeopleId = feed.PeopleId,
                Title = feed.Title,
                Description = feed.Description,
                ModifyTime = feed.ModifyTime,
                Attachment = feed.Attachment
            };
        }
    }
}
