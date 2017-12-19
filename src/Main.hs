module Main where

import Control.Monad.IO.Class
import Control.Exception
import Control.Monad.State (MonadIO)
import Data.List ( sortOn )
import System.Environment (getArgs, getProgName)
import System.Exit (exitFailure)
import System.Timeout (timeout)
import Data.Map.Strict (Map,empty,toList,insertWith)

import UI.NCurses

type State = Map String Int

newState :: State
newState = empty

main :: IO ()
main = runCurses $ do
	setEcho False
	_ <- setCursorMode CursorInvisible
	w <- defaultWindow
	_ <- loop w newState
	return ()
	where
		format name value = (show value) ++ ": " ++ name
		headtext state = map (uncurry format) $ reverse $ sortOn snd $ toList state
		writeline n text = do
			moveCursor n 0
			drawString text
		loop w state = do
			state' <- liftIO $ eventloop state
			(heigth,width) <- screenSize
			updateWindow w $ do
				mapM_ (uncurry writeline) $ take (fromInteger $ heigth) $ zip [0..] $ map (take $ fromInteger width-1) $ headtext state'
			render
			loop w state'

eventloop :: State -> IO State
eventloop state = do
		maybeline <- timeout 100000 getLine
		return $ update maybeline state
	where
		update maybeline state' = case maybeline of
			Just line -> insertWith (+) line 1 state'
			Nothing -> state'

