using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchTree.Models.FeedService
{
    public class FeedHelper
    {
        public Feed Converter(DALs.Feed feed)
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

        public DALs.Feed Converter(Feed feed)
        {
            return new DALs.Feed
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
