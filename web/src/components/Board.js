import { EMPTY_TILE } from "../board";
import { isEqual } from "lodash";
import Tile from "./Tile";
import TilePlaceholder from "./TilePlaceholder";

export default function Board({
  board,
  selectedTile,
  highlightedTiles,
  onTileClick,
}) {
  return (
    <div
      style={{
        display: "grid",
        gridTemplateColumns: `repeat(${board[0].length}, 54px)`,
        gridAutoRows: `54px`,
        gap: "8px",
      }}
    >
      {board.map((row, y) =>
        row.map((kind, x) =>
          kind === EMPTY_TILE ? (
            <TilePlaceholder key={`${x}-${y}`} />
          ) : (
            <Tile
              key={`${x}-${y}`}
              kind={kind}
              isSelected={isEqual(selectedTile, [x, y])}
              isHighlighted={highlightedTiles.some((pos) =>
                isEqual(pos, [x, y])
              )}
              onClick={() => onTileClick([x, y])}
            />
          )
        )
      )}
    </div>
  );
}
