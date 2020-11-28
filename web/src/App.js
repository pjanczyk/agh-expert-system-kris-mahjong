import { useEffect, useState } from "react";
import { isEqual } from "lodash";
import * as api from "./api";
import { EMPTY_TILE, generateNewBoard, removeBoardTiles } from "./board";
import Board from "./components/Board";

function Message({ children }) {
  return (
    <div style={{ padding: "16px", textAlign: "center", fontSize: "20px" }}>
      {children}
    </div>
  );
}

export default function App() {
  let [board, setBoard] = useState(generateNewBoard);
  let [selectedTile, setSelectedTile] = useState(null);
  let [suggestedMoves, setSuggestedMoves] = useState(null);

  let isGameOver = isEqual(suggestedMoves, []);
  let isWin = board.flatMap((x) => x).every((tile) => tile === EMPTY_TILE);

  useEffect(() => {
    setSuggestedMoves(null);
    let timeout = setTimeout(() => {
      api.getSuggestedMoves(board).then(setSuggestedMoves);
    }, 2000);
    return () => clearTimeout(timeout);
  }, [board]);

  async function handleTileClick(clickedTile) {
    if (selectedTile) {
      let canRemoveTiles = await api.getCanRemoveTiles(board, [
        selectedTile,
        clickedTile,
      ]);
      if (canRemoveTiles) {
        let newBoard = removeBoardTiles(board, selectedTile, clickedTile);
        setBoard(newBoard);
      } else {
        setSelectedTile(clickedTile);
      }
    } else {
      setSelectedTile(clickedTile);
    }
  }

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        padding: "64px",
      }}
    >
      <Board
        board={board}
        selectedTile={selectedTile}
        highlightedTiles={suggestedMoves?.[0] ?? []}
        onTileClick={handleTileClick}
      />
      {isWin && <Message>You won!</Message>}
      {isGameOver && <Message>Game over!</Message>}
      <a style={{ textAlign: "center", padding: "32px" }} href="/">
        Restart game
      </a>
    </div>
  );
}
