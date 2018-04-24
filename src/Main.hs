module Main where

import Control.Monad.IO.Class
import Data.List
import Data.Map.Strict (Map,empty,toList,insertWith)
import Data.Ord (comparing,Down(..))
import System.Clock
import System.Timeout (timeout)

import UI.NCurses

type State = Map String Int

newState :: State
newState = empty

minNBy :: (a -> a -> Ordering) -> Int -> [a] -> [a]
minNBy _ _ [] = []
minNBy cmp n list = foldl (\l x -> take n $ insertBy cmp x l) [] list


main :: IO ()
main = runCurses $ do
	setEcho False
	_ <- setCursorMode CursorInvisible
	w <- defaultWindow
	starttime <- liftIO $ getTime Monotonic
	_ <- loop w starttime newState
	return ()
	where
		format name value = (show value) ++ ": " ++ name
		writeline n text = do
			moveCursor n 0
			drawString text
			clearLine
		loop w lastupdate state = do
			state' <- liftIO $ eventloop state
			now <- liftIO $ getTime Monotonic
			if toNanoSecs (diffTimeSpec lastupdate now) > 100000000 then
				do
					(heigth,width) <- screenSize
					updateWindow w $ do
						mapM_ (uncurry writeline) $ zip [0..] $ map (take (fromInteger width-1) . uncurry format) $ minNBy (comparing $ Down . snd) (fromInteger $ heigth) $ toList state'
					render
					loop w now state'
			else
				loop w lastupdate state'

eventloop :: State -> IO State
eventloop state = do
		maybeline <- timeout 100000 getLine
		return $ update maybeline state
	where
		update maybeline state' = case maybeline of
			Just line -> insertWith (+) line 1 state'
			Nothing -> state'

