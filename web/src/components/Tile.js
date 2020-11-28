export default function Tile({ kind, isSelected, isHighlighted, onClick }) {
  return (
    <div
      style={{
        background: "#efefef",
        borderWidth: "0",
        borderStyle: "solid",
        display: "grid",
        placeItems: "center",
        fontSize: "30px",
        fontWeight: "bold",
        cursor: "pointer",
        ...(isHighlighted && {
          background: "#dcedc8",
        }),
        ...(isSelected && {
          background: "#aed581",
          borderWidth: "3px",
          borderColor: "#7cb342",
        }),
      }}
      onClick={onClick}
    >
      {kind}
    </div>
  );
}
