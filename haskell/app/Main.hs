module Main where

import           Graphics.Gloss

import           Graphics.Gloss.Interface.Pure.Game
import           Text

window ∷ Display
window = InWindow "Pixly Typography" (1024, 768) (0, 0)

main ∷ IO ()
main = display window white picture
  where
    picture = pictures $ printText (0, 0) "HELLO WORLD."
