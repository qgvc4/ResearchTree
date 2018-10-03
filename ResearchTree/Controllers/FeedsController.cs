using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ResearchTree.Context;
using ResearchTree.Models.FeedService;
using Feed = ResearchTree.Models.DALs.Feed;

namespace ResearchTree.Controllers
{
    [Produces("application/json")]
    [Route("api/Feeds")]
    public class FeedsController : Controller
    {
        private readonly FeedContext _context;
        private readonly FeedHelper _feedHelper;

        public FeedsController(FeedContext context, FeedHelper feedHelper)
        {
            _context = context;
            _feedHelper = feedHelper;
        }

        // GET: api/Feeds
        [HttpGet]
        public IEnumerable<Models.FeedService.Feed> GetFeeds()
        {
            return _context.Feeds?.Select(c => _feedHelper.Converter(c)).ToList();
        }

        // GET: api/Feeds/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetFeed([FromRoute] string id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var feed = await _context.Feeds.SingleOrDefaultAsync(m => m.Id == id);

            if (feed == null)
            {
                return NotFound();
            }

            return Ok(_feedHelper.Converter(feed));
        }

        // PUT: api/Feeds/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutFeed([FromRoute] string id, [FromBody] Models.FeedService.Feed feed)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (!FeedExists(id))
            {
                return NotFound();
            }

            feed.Id = id;
            feed.ModifyTime = DateTime.Now;

            _context.Entry(_feedHelper.Converter(feed)).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!FeedExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetFeed", new { id = feed.Id }, feed);
        }

        // POST: api/Feeds
        [HttpPost]
        public async Task<IActionResult> PostFeed([FromBody] Models.FeedService.Feed feed)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            feed.ModifyTime = DateTime.Now;
            var feedData = _feedHelper.Converter(feed);

            _context.Feeds.Add(feedData);
            await _context.SaveChangesAsync();

            feed = _feedHelper.Converter(feedData);

            return CreatedAtAction("GetFeed", new { id = feed.Id }, feed);
        }

        // DELETE: api/Feeds/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteFeed([FromRoute] string id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var feed = await _context.Feeds.SingleOrDefaultAsync(m => m.Id == id);
            if (feed == null)
            {
                return NotFound();
            }

            _context.Feeds.Remove(feed);
            await _context.SaveChangesAsync();

            return Ok(_feedHelper.Converter(feed));
        }

        private bool FeedExists(string id)
        {
            return _context.Feeds.Any(e => e.Id == id);
        }
    }
}