import { range, shuffle, chunk, cloneDeep } from "lodash";

export const EMPTY_TILE = "-";
const BOARD_COLUMNS = 14;
const BOARD_ROWS = 9;
const TILE_KINDS = [
  "🍎",
  "🍐",
  "🍊",
  "🍋",
  "🍌",
  "🍉",
  "🍇",
  "🍓",
  "🫐",
  "🍈",
  "🍒",
  "🍑",
  "🥭",
  "🍍",
  "🥥",
  "🥝",
  "🍅",
  "🍆",
  "🥑",
  "🥦",
  "🥬",
];

export function generateNewBoard() {
  let repetitions = (BOARD_ROWS * BOARD_COLUMNS) / TILE_KINDS.length;
  let board = range(repetitions).flatMap(() => TILE_KINDS);
  board = shuffle(board);
  board = chunk(board, BOARD_COLUMNS);
  return board;
}

export function removeBoardTiles(board, position1, position2) {
  let newBoard = cloneDeep(board);
  newBoard[position1[1]][position1[0]] = EMPTY_TILE;
  newBoard[position2[1]][position2[0]] = EMPTY_TILE;
  return newBoard;
}
