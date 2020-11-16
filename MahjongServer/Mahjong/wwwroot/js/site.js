// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
var clickedRow = null;
var clickedCol = null;

function clicked(row, col) {
  console.log("clicked in : " + row + " and " + col)
  var elem = document.getElementById("" + row + " : " + col);
  var div = elem.getElementsByTagName("div")[0];
  if (div.classList.contains("clicked")) {
    clickedRow = null;
    clickedCol = null;
    div.classList.toggle("clicked");
    div.classList.toggle("tile");
    return;
  }
  if (clickedCol === null && clickedRow === null) {
    div.classList.toggle("clicked");
    div.classList.toggle("tile");
    clickedCol = col;
    clickedRow = row;
    return;
  }

  var json = JSON.stringify({
    row1: clickedRow,
    col1: clickedCol,
    row2: row,
    col2: col
  });

  var elem2 = document.getElementById("" + clickedRow + " : " + clickedCol);
  var div2 = elem2.getElementsByTagName("div")[0];
  div2.classList.toggle("clicked");
  div2.classList.toggle("tile");

  $.ajax({
    url: 'api/game/move',
    data: json,
    type: "POST",
    contentType: "application/json",
  }).done(function (result) {

    if (result) {
      elem.hidden = true;
      elem2.hidden = true;
      alert('Poprawny ruch');
    } else {
      alert('Niepoprawny ruch');
    }

    div.classList.remove('clicked');
    div2.classList.remove('clicked');
    div.classList.add("tile");
    div2.classList.add("tile");
    clickedRow = null;
    clickedCol = null;
  });
}