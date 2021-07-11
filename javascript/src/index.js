const example = require("./text-example.js");
const font = require("./font.js");
const {
  pixelSize,
  widthBetweenCharacters,
  filledPoint,
  lineHeight,
  black,
  magenta,
} = require("./constants.js");
const setPixel = require("./draw.js");

const trimLn = (ln) => ln.trim();

const isPointFilled = (pnt) => pnt === filledPoint;

const drawPntOfCh = (x, y, color, chIndex) => (pixel, pixelX) => {
  if (isPointFilled(pixel)) {
    setPixel(x + pixelX * pixelSize, y + chIndex * pixelSize, color);
  }
};

const drawPntsOfCh = (x, y, color) => (ch, chIndex) =>
  ch.split("").forEach(drawPntOfCh(x, y, color, chIndex));

const getCharWidth = (ch) => ch.split("\n")[2].trim().length;

const sumLnWidth = (acc, ch) =>
  acc + getCharWidth(font[ch]) * pixelSize + widthBetweenCharacters;

const getRelativeX = (ln) => ln.split("").reduce(sumLnWidth, 0);

const drawCharacter = (ln, x, y, color) => (ch, chX) =>
  font[ch]
    .split("\n")
    .map(trimLn)
    .forEach(
      drawPntsOfCh(
        x + getRelativeX(ln.slice(0, chX)),
        y,
        ch in font ? color : magenta
      )
    );

const drawLine = (x, y, color) => (ln, lnY = 0) =>
  ln.trim().length > 0 &&
  ln.split("").forEach(drawCharacter(ln, x, y + lnY * lineHeight, color));

const drawText = (text, color, x, y) =>
  text.split("\n").length === 1
    ? drawLine(x, y, color)(text.toUpperCase())
    : text.toUpperCase().split("\n").forEach(drawLine(x, y, color));

drawText(example, black, 50, 48);
