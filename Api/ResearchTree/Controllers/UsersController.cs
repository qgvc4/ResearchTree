using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using ResearchTree.Entities.DALs;
using ResearchTree.Service;

namespace ResearchTree.Controllers
{
    [Produces("application/json")]
    [Route("api/Users")]
    [EnableCors("AllowSpecificOrigin")]
    public class UsersController : Controller
    {
        private readonly UserManager<User> _userManager;
        private readonly SignInManager<User> _signInManager;
        private readonly UserHelper _userHelper;
        private readonly AppSettings _appSettings;

        public UsersController(UserManager<User> userManager, SignInManager<User> signInManager, UserHelper userHelper, IOptions<AppSettings> appSettings)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _userHelper = userHelper;
            _appSettings = appSettings.Value;
        }

        // GET: api/Users
        [Authorize]
        [HttpGet]
        public IEnumerable<Entities.Api.User> GetUsers()
        {
            return _userManager.Users?.Select(c => _userHelper.Converter(c)).ToList();
        }

        // GET: api/Users/5
        [Authorize]
        [HttpGet("{id}")]
        public async Task<IActionResult> GetUser([FromRoute] string id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var user = await _userManager.Users.SingleOrDefaultAsync(m => m.Id == id);
            if (user == null)
            {
                return NotFound();
            }

            return Ok(_userHelper.Converter(user));
        }
    }
}