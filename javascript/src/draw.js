const { pixelSize } = require('./constants.js');

const canvas = document.querySelector('#canvas');
const context = canvas.getContext('2d');

const setPixel = (x, y, strokeColor) => {
  context.fillStyle = strokeColor;
  context.fillRect(x, y, pixelSize, pixelSize);
};

module.exports = setPixel;
