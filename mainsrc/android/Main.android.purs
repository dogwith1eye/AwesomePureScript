module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Dispatcher.React (createComponent)
import React (ReactClass, ReactElement, createClass)
import ReactNative.API (REGISTER, registerComponent)
import ReactNative.Components.Text (text)
import ReactNative.Components.View (view)
import ReactNative.PropTypes (center)
import ReactNative.PropTypes.Color (rgbi)
import ReactNative.Styles (Styles, staticStyles, flex, backgroundColor, margin, marginBottom)
import ReactNative.Styles.Flex (justifyContent, alignItems)
import ReactNative.Styles.Text (fontSize, textAlign, color)
import Thermite as T

spec :: T.Spec _ _ _ _
spec = T.simpleSpec T.defaultPerformAction render
  where
    render :: T.Render _ _ _
    render _ _ _ _ =
      [ text sheet.welcome 
          "Welcome to Thermite Native!" 
      , text sheet.instructions 
          "To get started, edit Main.android.purs" 
      , text sheet.instructions 
          "Double tap R on your keyboard to reload,\n Shake or press menu button for dev menu"
      ]

wrapper :: Array ReactElement -> ReactElement
wrapper = view sheet.container

appAndroidT :: ReactClass Unit
appAndroidT = createClass <<< _.spec $ T.createReactSpec' wrapper spec unit

appAndroid :: ReactClass Unit
appAndroid = createComponent unit render unit
  where
    render _ = view sheet.container 
      [ text sheet.welcome 
          "Welcome to Purescript Native!" 
      , text sheet.instructions 
          "To get started, edit Main.android.purs" 
      , text sheet.instructions 
          "Double tap R on your keyboard to reload,\n Shake or press menu button for dev menu"
      ]

sheet :: {
    container :: Styles
  , welcome :: Styles
  , instructions :: Styles
}
sheet = {
  container: staticStyles [
    flex 1,
    justifyContent center,
    alignItems center,
    backgroundColor $ rgbi 0xF5FCFF
  ],
  welcome: staticStyles [
    fontSize 20,
    textAlign center,
    margin 10
  ],
  instructions: staticStyles [
    textAlign center,
    color $ rgbi 0x333333,
    marginBottom 5
  ]
}

main :: forall e. Eff (register:: REGISTER | e) Unit
main = do
  registerComponent "AwesomePureScript" appAndroidT