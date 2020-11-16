using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Mahjong.Models;

namespace Mahjong.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private static Random _rng = new Random();
        private readonly IDictionary<Tile, int> _proportions = new Dictionary<Tile, int>
        {
            { Tile.First, 8 },
            { Tile.Second, 3 },
            { Tile.Third, 3 },
            { Tile.Fourth, 2 },
            { Tile.Fifth, 1 },
        };

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            const int size = 8;
            var board = GenerateBoard(size);
            return View(board);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        private Tile?[,] GenerateBoard(int size)
        {
            var board = new Tile?[size, size];
            var pairsQuantity = size * size / 2;
            var fields = Enumerable.Range(0, size)
                .SelectMany(c => Enumerable.Range(0, size)
                    .Select(r => (col: c, row: r)))
                .ToList();
            fields = Shuffle(fields);
            var possiblePos = new Stack<(int col, int row)>(fields);
            var tilesProportions = _proportions.SelectMany(p => Enumerable.Repeat(p.Key, p.Value)).ToArray();


            var index = 0;
            while (possiblePos.Count != 0)
            {
                int typeIndex;
                if (index < tilesProportions.Length)
                {
                    typeIndex = index;
                    index++;
                }
                else
                {
                    typeIndex = _rng.Next(0, tilesProportions.Length);
                }

                var tile = tilesProportions[typeIndex];

                var pos = possiblePos.Pop();
                board[pos.col, pos.row] = tile;

                pos = possiblePos.Pop();
                board[pos.col, pos.row] = tile;
            }

            return board;
        }

        public static List<T> Shuffle<T>(List<T> list)
        {
            var n = list.Count;
            while (n > 1)
            {
                n--;
                var k = _rng.Next(n + 1);
                var value = list[k];
                list[k] = list[n];
                list[n] = value;
            }

            return list;
        }
    }
}
