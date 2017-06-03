import XMonad
import Data.List
import Data.Maybe
import XMonad.Layout.NoBorders
import XMonad.Layout.ShowWName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.LayoutHints
import XMonad.StackSet (sink, focusUp, shiftMaster)
import XMonad.Layout.Spacing

main = do
  xmonad $ ewmh defaultConfig
    { terminal = "terminology"
    , modMask = mod4Mask
    , borderWidth = 2
    , normalBorderColor = "darkgray"
    , focusedBorderColor = "darkred"
    , workspaces = map show [1..9]
    , layoutHook = let tiled  = Tall 1 (3/100) (56/100)
                       spaced = spacing 12 $ tiled
                       layout = spaced ||| tiled ||| Full
        in smartBorders . avoidStruts . showWName $ layout
    , manageHook = composeAll
      [ doFloat
      , manageDocks
      ]
    , startupHook = setWMName "LG3D"
    , handleEventHook = hintsEventHook <+> fullscreenEventHook
    }
    `additionalKeys`
    [ ((mod4Mask, xK_b), sendMessage ToggleStruts)
    , ((mod4Mask, xK_Up), withFocused $ windows . sink)
    , ((mod4Mask .|. shiftMask, xK_Tab), windows focusUp >> windows shiftMaster)
    , ((mod4Mask, xK_p), safeSpawn "dash" ["-c", "setsid $($HOME/.cabal/bin/yeganesh -x)"])
    ]

