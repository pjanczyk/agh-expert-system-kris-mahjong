import { API_URL } from "./config";

export async function getCanRemoveTiles(board, positions) {
  let response = await fetch(`${API_URL}can-remove-tiles`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json",
    },
    body: JSON.stringify({
      board,
      positions: positions.map(([x, y]) => [x + 1, y + 1]),
    }),
  });
  return await response.json();
}

export async function getSuggestedMoves(board) {
  let response = await fetch(`${API_URL}suggest-moves`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json",
    },
    body: JSON.stringify({ board }),
  });
  let json = await response.json();
  return json.map((move) => move.map(([x, y]) => [x - 1, y - 1]));
}
