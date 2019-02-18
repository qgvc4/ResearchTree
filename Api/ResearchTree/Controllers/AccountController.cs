using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using ResearchTree.Entities.DALs;
using ResearchTree.Service;

namespace ResearchTree.Controllers
{
    public class Credentials
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }

    [Produces("application/json")]
    [Route("api/Account")]
    [EnableCors("AllowSpecificOrigin")]
    public class AccountController : Controller
    {
        private readonly UserManager<User> _userManager;
        private readonly SignInManager<User> _signInManager;
        private readonly UserHelper _userHelper;
        private readonly AppSettings _appSettings;

        public AccountController(UserManager<User> userManager, SignInManager<User> signInManager, UserHelper userHelper, IOptions<AppSettings> appSettings)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _userHelper = userHelper;
            _appSettings = appSettings.Value;
        }

        [HttpPost]
        public async Task<IActionResult> SignUp([FromBody] Entities.Api.User user)
        {
            var userData = _userHelper.Converter(user);

            var result = await _userManager.CreateAsync(userData, user.Password);

            if (!result.Succeeded)
            {
                return BadRequest(result.Errors);
            }

            await _signInManager.SignInAsync(userData, isPersistent: false);

            user = _userHelper.Converter(userData);
            user.Token = CreateToken(userData);
            return Ok(user);
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] Credentials credentials)
        {
            var result = await _signInManager.PasswordSignInAsync(credentials.Email, credentials.Password, false, false);

            if (!result.Succeeded)
            {
                return BadRequest();
            }

            var userData = await _userManager.FindByEmailAsync(credentials.Email);

            var user = _userHelper.Converter(userData);
            user.Token = CreateToken(userData);
            return Ok(user);
        }

        private string CreateToken(User user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.Id),
                    new Claim(ClaimTypes.Email, user.Email),
                    new Claim(ClaimTypes.GivenName, user.Firstname),
                    new Claim(ClaimTypes.Name, user.Firstname+user.Lastname)
                }),
                Expires = DateTime.UtcNow.AddDays(365),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}