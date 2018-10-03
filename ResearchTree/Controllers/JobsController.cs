using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ResearchTree.Context;
using ResearchTree.Models.JobService;
using Job = ResearchTree.Models.DALs.Job;

namespace ResearchTree.Controllers
{
    [Produces("application/json")]
    [Route("api/Jobs")]
    public class JobsController : Controller
    {
        private readonly JobContext _context;
        private readonly JobHelper _jobHelper;

        public JobsController(JobContext context, JobHelper jobHelper)
        {
            _context = context;
            _jobHelper = jobHelper;
        }

        // GET: api/Jobs
        [HttpGet]
        public IEnumerable<Models.JobService.Job> GetJobs()
        {
            return _context.Jobs.Select(c => _jobHelper.Converter(c)).ToList();
        }

        // GET: api/Jobs/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetJob([FromRoute] string id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var job = await _context.Jobs.SingleOrDefaultAsync(m => m.Id == id);

            if (job == null)
            {
                return NotFound();
            }

            return Ok(_jobHelper.Converter(job));
        }

        // PUT: api/Jobs/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutJob([FromRoute] string id, [FromBody] Models.JobService.Job job)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (!JobExists(id))
            {
                return NotFound();
            }

            job.Id = id;
            job.ModifyTime = DateTime.Now;

            _context.Entry(_jobHelper.Converter(job)).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!JobExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetJob", new { id = job.Id }, job);
        }

        // POST: api/Jobs
        [HttpPost]
        public async Task<IActionResult> PostJob([FromBody] Models.JobService.Job job)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            job.ModifyTime = DateTime.Now;
            var jobData = _jobHelper.Converter(job);

            _context.Jobs.Add(jobData);
            await _context.SaveChangesAsync();

            job = _jobHelper.Converter(jobData);

            return CreatedAtAction("GetJob", new { id = job.Id }, job);
        }

        // DELETE: api/Jobs/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteJob([FromRoute] string id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var job = await _context.Jobs.SingleOrDefaultAsync(m => m.Id == id);
            if (job == null)
            {
                return NotFound();
            }

            _context.Jobs.Remove(job);
            await _context.SaveChangesAsync();

            return Ok(_jobHelper.Converter(job));
        }

        private bool JobExists(string id)
        {
            return _context.Jobs.Any(e => e.Id == id);
        }
    }
}