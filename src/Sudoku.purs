module Sudoku
    ( Sudoku (..)
    , Cell(..)
    , example
    , asLists
    )
where

import Prelude
import Grid as G
import Data.Map as M
import Data.Array as A
import Data.Tuple (Tuple (Tuple))
import Data.Maybe (Maybe(..))
import Data.String as Str
import Data.Int as I

data Cell
    = Clue Int
    | Guess Int

type Sudoku = G.Grid Cell

type Loc = Tuple Int Int


type Borders = { north :: Boolean, east :: Boolean, south :: Boolean, west :: Boolean }

type RenderCell =
    { loc :: Loc
    , borders :: Borders
    , content :: Maybe Cell
    }


example :: Sudoku
example = parse 9 """
53..7....
6..195...
.98....6.
8...6...3
4..8.3..1
7...2...6
.6....28.
...419..5
....8..79
"""

parse :: Int -> String -> Sudoku
parse n s =
    let mlines = map Str.trim $ Str.split (Str.Pattern "\n") s
        lines :: Array String
        lines = A.filter (\l -> Str.length l == n) mlines
        readCell x y c =
            case I.fromString $ Str.singleton c of
                Just i -> Just (Tuple (Tuple x y) (Clue i))
                _ -> Nothing
        clues = A.catMaybes $ A.concat $ A.mapWithIndex (\y row ->
                    A.mapWithIndex (\x c -> readCell x y c) $ Str.toCharArray row
            ) lines    
        m = M.fromFoldable clues
    in
        { dim: n
        , cells: m
        }

asLists :: Sudoku -> Array (Array RenderCell)
asLists s =
    let cell x y =
            { loc : loc
            , borders :
                { north : y == 0 || mod y 3 == 0
                , east : x == s.dim-1
                , south : y == s.dim-1
                , west : mod x 3 == 0
                }    
            , content : M.lookup loc s.cells
            }
            where
                loc = Tuple x y
        r = A.range 0 (s.dim - 1)
    in
        map (\y -> map (\x -> cell x y) r) r
