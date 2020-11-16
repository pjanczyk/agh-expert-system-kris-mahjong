using System;
using Microsoft.AspNetCore.Mvc;

namespace Mahjong.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GameController : ControllerBase
    {
        // POST: api/Game
        [HttpPost("move")]
        public bool Post([FromBody] Movement value)
        {
            return new Random().Next(0, 2) == 0;
        }
    }
}
