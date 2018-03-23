module Main where

import Control.Monad.Eff (Eff)
import Prelude
import Data.Array as A
import React.DOM as R
import React.DOM.Props as RP
import Thermite as T
import DOM (DOM) as DOM
import Data.Maybe (Maybe(..))
import Data.String as Str

import Sudoku as S


data Action = Increment | Decrement

type State = { sudoku :: S.Sudoku
             , counter :: Int
             }

initialState :: State
initialState = { sudoku: S.example, counter: 0 }

render :: T.Render State _ Action
render dispatch a state b =
  [ R.p' [ R.text "Value: "
         , R.text $ show state.counter
         ]
  , R.p' [ R.button [ RP.onClick \_ -> dispatch Increment ]
                    [ R.text "Increment" ]
         , R.button [ RP.onClick \_ -> dispatch Decrement ]
                    [ R.text "Decrement" ]
         ]
  , R.div' $ renderS dispatch a state.sudoku b
  ]

performAction :: T.PerformAction _ State _ Action
performAction Increment _ _ = void (T.cotransform (\state -> state { counter = state.counter + 1 }))
performAction Decrement _ _ = void (T.cotransform (\state -> state { counter = state.counter - 1 }))

spec :: T.Spec _ State _ Action
spec = T.simpleSpec performAction render

main :: Eff (dom :: DOM.DOM) Unit
main = T.defaultMain spec initialState unit


renderS :: T.Render S.Sudoku _ Action
renderS dispatch _ sudoku _ =
    [
        R.div [RP.className "sudoku"] $ map (
            \row -> R.div' $ map renderCell row
        ) $ S.asLists sudoku
    ]
    where
    renderCell c =
        let content = case c.content of
                            Nothing -> R.text ""
                            Just (S.Clue i) -> R.text $ show i
                            Just (S.Guess i) -> R.text $ show i
            isClue = case c.content of
                            Just (S.Clue _) -> true
                            _ -> false
            cl :: Array String
            cl = A.catMaybes
                [ if c.borders.north then Just "bnorth" else Nothing
                , if c.borders.east then Just "beast" else Nothing
                , if c.borders.south then Just "bsouth" else Nothing
                , if c.borders.west then Just "bwest" else Nothing
                , if isClue then Just "clue" else Nothing
                ]
        in
            R.div [RP.className (Str.joinWith " " cl)] [ content ]
