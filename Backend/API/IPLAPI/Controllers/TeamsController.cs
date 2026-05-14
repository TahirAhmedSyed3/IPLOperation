using IPLAPI.Data;
using IPLAPI.Dtos;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace IPLAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TeamsController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public TeamsController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TeamResponseDto>>> GetTeams()
        {
            var teams = await _context.Teams.Select(t => new TeamResponseDto
            {
                TeamId = t.TeamId,
                OfficialName = t.OfficialName,
                ShortName = t.ShortName,
                City = t.City
            }).ToListAsync();

            return Ok(teams);
        }
    }
}
