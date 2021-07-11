module Text
  ( printText
  ) where

import qualified Data.Map as Map
import Data.Maybe
import Font
import Graphics.Gloss

type Position = (Int, Int)

type ChFontData = [(Int, [(Int, Char)])]

printText :: Position -> [Char] -> [Picture]
printText pos text =
  concatMap (\(i, ch) -> drawChar ch pos (take i text)) $
  zip [0 .. length text] text

pixelSize :: Int
pixelSize = 3

background :: Color
background = white

forgroundColor :: Color
forgroundColor = black

widthBetweenChs :: Int
widthBetweenChs = pixelSize

formatLine :: [a] -> [(Int, a)]
formatLine lns = zip [0 .. length lns] lns

formatCh :: [[Char]] -> ChFontData
formatCh = formatLine . map formatLine

getLinesOfCh :: Char -> ChFontData
getLinesOfCh =
  formatCh .
  reverse . filter (/= "") . (lines . fromMaybe []) . flip Map.lookup font

getCharWidth :: Char -> Int
getCharWidth = length . snd . head . getLinesOfCh

isPntFull :: Char -> Bool
isPntFull ch = ch == 'O'

setPixel :: Color -> (Float, Float) -> Picture
setPixel rectColor (x, y) =
  translate x y $
  color rectColor $
  rectangleSolid (fromIntegral pixelSize) (fromIntegral pixelSize)

drawChar :: Char -> Position -> [Char] -> [Picture]
drawChar ch pos text =
  concatMap (\fontData -> drawPtnLn fontData pos text) $ getLinesOfCh ch

sumLns :: Int -> Char -> Int
sumLns acc x = acc + getCharWidth x * pixelSize + widthBetweenChs

lineLen :: [Char] -> Int
lineLen = foldl sumLns 0

drawPtnLn :: (Int, [(Int, Char)]) -> Position -> [Char] -> [Picture]
drawPtnLn (y2, ln) pos textSoFar =
  map (\(x2, ch) -> drawLnPart (x2, y2) ch pos (lineLen textSoFar)) ln

drawLnPart :: Position -> Char -> Position -> Int -> Picture
drawLnPart (x2, y2) ch (x1, y1) currLen =
  drawPtn
    (x1 * pixelSize + currLen + x2 * pixelSize, y1 * pixelSize + y2 * pixelSize)
    ch

drawPtn :: Position -> Char -> Picture
drawPtn (x, y) ch =
  setPixel
    (if isPntFull ch
       then forgroundColor
       else background)
    ( fromIntegral x - ((1024 / 2) - (fromIntegral pixelSize / 2))
    , fromIntegral y - ((768 / 2) - (fromIntegral pixelSize / 2)))
