module Grid
    ( Loc (..)
    , Grid (..)
    ) where

-- import Prelude
import Data.Map as M
import Data.Tuple (Tuple)

-- type Grid a = L.NonEmptyList (L.NonEmptyList a)
-- type Grid a = L.NonEmptyList a
-- derive instance eqLoc :: Eq Loc
-- derive instance ordLoc :: Ord Loc
type Loc = Tuple Int Int -- x, y

type Grid a = 
    { dim :: Int
    , cells :: M.Map Loc a
    }
