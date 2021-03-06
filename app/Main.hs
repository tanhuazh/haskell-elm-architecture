module Main where

import Prelude          hiding (init)
import Program
import System.Directory (getCurrentDirectory)
import System.Random    (randomRIO)

main :: IO ()
main = mkProgram init update view


type Model = Int

data Msg =
     NoOp ()
   | Hello
   | Add Int
   | CurrentDir
   | RandomAdd


-- Init

init :: (Model, Cmd Msg)
init = (0, sayHello)


-- Update

update :: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp _     -> (model, noCmd)
    Hello      -> (model, sayHello)
    Add n      -> (model + n, noCmd)
    CurrentDir -> (model, printCurrentDir)
    RandomAdd  -> (model, randomAdd)


-- Cmds

printCurrentDir :: Cmd Msg
printCurrentDir = mkCmd NoOp $ ("Current Dir is: " ++) <$> getCurrentDirectory >>= putStrLn

sayHello :: Cmd Msg
sayHello = mkCmd NoOp $ putStrLn "hellooooo!"

randomAdd :: Cmd Msg
randomAdd = mkCmd Add $ randomRIO (1, 100)


-- View

view :: Model -> View Msg
view _ =
  mkView
    [ ("hello",  Hello)
    , ("add 1",  Add 1)
    , ("add 2",  Add 2)
    , ("dir",    CurrentDir)
    , ("random", RandomAdd)
    ]
