module Sudoku
    ( Sudoku (..)
    , Cell(..)
    , example
    )
where

import Grid as G
import Data.Map as M
import Data.Tuple (Tuple (Tuple))

data Cell
    = Unknown
    | Clue Int
    | Guess Int

type Sudoku = G.Grid Cell

example :: Sudoku
example = 
    let m = M.fromFoldable [
        Tuple (Tuple 0 0) (Clue 5)
        , Tuple (Tuple 1 0) (Clue 3)
        , Tuple (Tuple 0 1) (Clue 6)
        , Tuple (Tuple 8 8) (Clue 9)
        ]
    in
        { dim: 9
        , cells: m
        }
