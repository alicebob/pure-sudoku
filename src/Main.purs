module Main where

import Control.Monad.Eff (Eff)
import Prelude
import React.DOM as R
import React.DOM.Props as RP
import Thermite as T
import DOM (DOM) as DOM

-- import Sudoku as S


data Action = Increment | Decrement

-- type State = { -- sudoku :: S.Sudoku
             -- counter :: Int
             -- }
type State = { counter :: Int }

initialState :: State
-- initialState = { sudoku: S.example, counter: 0 }
initialState = { counter: 0 }

render :: T.Render State _ Action
render dispatch _ state _ =
  [ R.p' [ R.text "Value: "
         , R.text $ show state.counter
         ]
  , R.p' [ R.button [ RP.onClick \_ -> dispatch Increment ]
                    [ R.text "Increment" ]
         , R.button [ RP.onClick \_ -> dispatch Decrement ]
                    [ R.text "Decrement" ]
         ]
  ]

performAction :: T.PerformAction _ State _ Action
performAction Increment _ _ = void (T.cotransform (\state -> state { counter = state.counter + 1 }))
performAction Decrement _ _ = void (T.cotransform (\state -> state { counter = state.counter - 1 }))

spec :: T.Spec _ State _ Action
spec = T.simpleSpec performAction render

main :: Eff (dom :: DOM.DOM) Unit
main = T.defaultMain spec initialState unit
