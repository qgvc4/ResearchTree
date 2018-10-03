using System;
namespace ResearchTree.Models.FeedService
{
    public class Feed
    {
        public string Id { get; set; }
        public string PeopleId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime ModifyTime { get; set; }
        public byte[] Attachment { get; set; }
    }
}
