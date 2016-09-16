import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import System.IO

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad defaultConfig
              { modMask = mod4Mask  -- super instead of alt (usually Windows key)
              , terminal = "urxvt"
              , manageHook = manageDocks <+> manageHook defaultConfig
              , layoutHook = avoidStruts  $  layoutHook defaultConfig
              , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
              }
