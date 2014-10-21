{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Applicative
import           Snap.Core
import           Snap.Util.FileServe
import           Snap.Http.Server

import           Application.StarTerminal.Controller

main :: IO ()
main = quickHttpServe site

site :: Snap ()
site =
    -- ifTop (formHandler) <|>
    route [ ("ballot/:ballotId/step/:stepId", method GET  showBallotStep)
          , ("ballot/:ballotId/step/:stepId", method POST recordBallotSelection)
          , ("ballot/:ballotId",              method GET  ballotHandler)
          , ("ballot/:ballotId/summary",      method GET  showSummary)
          , ("ballot/:ballotId/summary",      method POST finalize)
          , ("ballot/:ballotId/complete",     method GET  exitInstructions)
          ] <|>
    dir "static" (serveDirectory "static")
