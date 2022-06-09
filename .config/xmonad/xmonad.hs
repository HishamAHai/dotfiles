import XMonad
import XMonad.Layout.Spacing

myTerminal    = "kitty"
myModMask     = mod4Mask -- Win key or Super_L
myBorderWidth = 1
myLayoutHook  = spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True $ layoutHook def

main = do
  xmonad $ def
    { terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    , layoutHook  = myLayoutHook
    }
