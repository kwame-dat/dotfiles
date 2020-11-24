import System.IO
import System.Exit
import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers(doFullFloat, doCenterFloat, isFullscreen, isDialog)
import XMonad.Config.Desktop
import XMonad.Config.Azerty
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.SpawnOn
import XMonad.Util.EZConfig (additionalKeys, additionalMouseBindings)
import XMonad.Actions.CycleWS
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Hooks.UrgencyHook
import qualified Codec.Binary.UTF8.String as UTF8
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.Cross(simpleCross)
import XMonad.Layout.Spiral(spiral)
import XMonad.Layout.Grid
import XMonad.Layout.ThreeColumns
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.IndependentScreens
import XMonad.Layout.CenteredMaster(centerMaster)
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified Data.ByteString as B
import Control.Monad (liftM2)
import qualified DBus as D
import qualified DBus.Client as D


myStartupHook = do
    spawn "$HOME/.xmonad/scripts/autostart.sh"
    setWMName "LG3D"

-- colours
normBord = "#4c566a"
focdBord = "#5e81ac"
fore     = "#DEE3E0"
back     = "#282c34"
winType  = "#c678dd"

--mod4Mask= super key
--mod1Mask= alt key
--controlMask= ctrl key
--shiftMask= shift key

web           = "\xf0ac"
editor        = "\xf121"
chat          = "\xf075"
reading       = "\xf02d"
videoCalls    = "\xf03d"
dbclient      = "\xf1c0"
restClient    = "\xf25b"
gaming        = "\xf11b"
media         = "\xf001"

myModMask = mod4Mask
encodeCChar = map fromIntegral . B.unpack
myFocusFollowsMouse = False
myBorderWidth = 3
myWorkspaces    = [web, editor, reading, chat, restClient, dbclient, videoCalls, gaming, media]

myBaseConfig = desktopConfig

-- window manipulations
myManageHook = composeAll . concat $
    [ [isDialog --> doCenterFloat]
    , [className =? c --> doCenterFloat | c <- myCFloats]
    , [title =? t --> doFloat | t <- myTFloats]
    , [resource =? r --> doFloat | r <- myRFloats]
    , [resource =? i --> doIgnore | i <- myIgnores]
    , [className =? "qutebrowser"                             --> doShift ( myWorkspaces !! 0 )]
    , [className =? "Google-chrome"                           --> doShift ( myWorkspaces !! 0 )]
    , [className =? "Vivaldi-stable"                          --> doShift ( myWorkspaces !! 0 )]
    , [className =? "Brave-browser"                           --> doShift ( myWorkspaces !! 0 )]
    , [className =? "firefox"                                 --> doShift ( myWorkspaces !! 0 )]
    , [className =? "Emacs"                                   --> doShift ( myWorkspaces !! 1 )]
    , [className =? "calibre"                                 --> doShift ( myWorkspaces !! 2 )]
    , [className =? "Stoplight Studio"                        --> doShift ( myWorkspaces !! 2 )]
    , [className =? "whatsapp-nativefier-d52542"              --> doShift ( myWorkspaces !! 3 )]
    , [className =? "Signal"                                  --> doShift ( myWorkspaces !! 3 )]
    , [className =? "Slack"                                   --> doShift ( myWorkspaces !! 3 )]
    , [className =? "Insomnia"                                --> doShift ( myWorkspaces !! 4 )]
    , [className =? "Postman"                                 --> doShift ( myWorkspaces !! 4 )]
    , [className =? "DBeaver"                                 --> doShift ( myWorkspaces !! 5 )]
    , [className =? "zoom"                                    --> doShift ( myWorkspaces !! 6 )]
    , [className =? "obs"                                     --> doShift ( myWorkspaces !! 7 )]
    , [className =? "vlc"                                     --> doShift ( myWorkspaces !! 7 )]
    , [className =? "VirtualBox Manager"                      --> doShift ( myWorkspaces !! 8 )]
    , [className =? "Spotify"                                 --> doShift ( myWorkspaces !! 8 )]
    ]
    where
    -- doShiftAndGo = doF . liftM2 (.) W.greedyView W.shift
    myCFloats = ["Arandr", "Galculator", "Nitrogen", "mpv", "Xfce4-terminal"]
    myTFloats = ["Downloads", "Save As..."]
    myRFloats = []
    myIgnores = ["desktop_window"]

myLayout =
  spacingRaw True (Border 0 30 30 30) True (Border 30 30 30 30) True
  $ avoidStruts
  $ mkToggle (NBFULL ?? NOBORDERS ?? EOT)
  $ tiled ||| spiral (6/7) ||| ThreeColMid 1 (3/100) (1/2) ||| Full
    where
        tiled = Tall nmaster delta tiled_ratio
        nmaster = 1
        delta = 3/100
        tiled_ratio = 1/2

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, 1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, 2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, 3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))

    ]


-- keys config

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- SUPER + FUNCTION KEYS
  [ ((modMask, xK_e), spawn $ "emacsclient -c -a ''" )
  , ((modMask, xK_f), sendMessage $ Toggle NBFULL)
  , ((modMask, xK_h), spawn $ "alacritty 'htop task manager' -e htop" )
  , ((modMask, xK_t), spawn $ "alacritty" )
  , ((modMask, xK_y), spawn $ "polybar-msg cmd toggle" )
  , ((modMask, xK_Escape), spawn $ "xkill" )
  , ((modMask, xK_Return), spawn $ "urxvt" )
  , ((modMask, xK_F1), spawn $ "emacsclient -c -a ''" )
  , ((modMask, xK_F2), spawn $ "vivaldi-stable" )
  , ((modMask, xK_F3), spawn $ "slack" )
  , ((modMask, xK_F4), spawn $ "Insomnia" )
  , ((modMask, xK_F5), spawn $ "Dbeaver" )
  , ((modMask, xK_F6), spawn $ "vlc --video-on-top" )
  , ((modMask, xK_F7), spawn $ "virtualbox" )
  , ((modMask, xK_F8), spawn $ "thunar" )
  , ((modMask, xK_F9), spawn $ "evolution" )
  , ((modMask, xK_F10), spawn $ "spotify" )
  , ((modMask, xK_F11), spawn $ "rofi -show run -fullscreen" )
  , ((modMask, xK_F12), spawn $ "rofi -show run" )

  , ((modMask, xK_q), kill )
  , ((modMask, xK_Escape), spawn $ "xkill" )
  , ((modMask, xK_Return), spawn $ "alacritty" )
  , ((modMask, xK_space), spawn $ "rofi -show combi" )
  , ((modMask, xK_b), spawn $ "rofi-surfraw" )

  -- FUNCTION KEYS
  , ((0, xK_F12), spawn $ "xfce4-terminal --drop-down" )

  -- SUPER + SHIFT KEYS

  , ((modMask .|. shiftMask , xK_f), sendMessage $ Toggle NBFULL)
  , ((modMask .|. shiftMask , xK_Return ), spawn $ "thunar")
  , ((modMask .|. shiftMask , xK_r ), spawn $ "xmonad --recompile && xmonad --restart")
  , ((modMask .|. shiftMask , xK_e ), spawn $ "arcolinux-logout")
  , ((modMask .|. shiftMask , xK_q ), killAll)

  -- SUPER + CONTROL KEYS

  , ((modMask .|. controlMask, xK_e), spawn "emacsclient -c -a ''")
  , ((modMask .|. controlMask, xK_m), spawn "emacsclient -c -a '' --eval '(mu4e)'")
  , ((modMask .|. controlMask, xK_t), spawn "emacsclient -c -a '' --eval '(org-agenda)'")
  , ((modMask .|. controlMask, xK_s), spawn "flameshot gui")
  , ((modMask .|. controlMask, xK_p), spawn "rofi-pass")
  , ((modMask .|. controlMask, xK_b), spawn "alacritty -e 'bmenu'")
  , ((modMask .|. controlMask, xK_c), spawn "rofi -show calc -modi calc -no-show-match -no-sort")


  -- CONTROL + ALT KEYS

  , ((controlMask .|. mod1Mask , xK_f ), spawn $ "firefox")
  , ((controlMask .|. mod1Mask , xK_b ), spawn $ "brave")
  , ((controlMask .|. mod1Mask , xK_g ), spawn $ "google-chrome-stable -no-default-browser-check")
  , ((controlMask .|. mod1Mask , xK_o ), spawn $ "$HOME/.xmonad/scripts/picom-toggle.sh")
  , ((controlMask .|. mod1Mask , xK_p ), spawn $ "pamac-manager")
  , ((controlMask .|. mod1Mask , xK_s ), spawn $ "spotify")
  , ((controlMask .|. mod1Mask , xK_t ), spawn $ "urxvt")
  , ((controlMask .|. mod1Mask , xK_u ), spawn $ "pavucontrol")
  , ((controlMask .|. mod1Mask , xK_v ), spawn $ "vivaldi-stable")
  , ((controlMask .|. mod1Mask , xK_Return ), spawn $ "urxvt")
  , ((modMask, xK_y), spawn $ "polybar-msg cmd toggle" )

  --CONTROL + SHIFT KEYS

  , ((controlMask .|. shiftMask , xK_Escape ), spawn $ "xfce4-taskmanager")

  --SCREENSHOTS

  , ((0, xK_Print), spawn $ "scrot 'ArcoLinux-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'")
  , ((controlMask, xK_Print), spawn $ "xfce4-screenshooter" )
  , ((controlMask .|. shiftMask , xK_Print ), spawn $ "gnome-screenshot -i")


  --MULTIMEDIA KEYS

  -- Mute volume
  , ((0, xF86XK_AudioMute), spawn $ "amixer -q set Master toggle")

  -- Decrease volume
  , ((0, xF86XK_AudioLowerVolume), spawn $ "amixer -q set Master 5%-")

  -- Increase volume
  , ((0, xF86XK_AudioRaiseVolume), spawn $ "amixer -q set Master 5%+")

  -- Increase brightness
  , ((0, xF86XK_MonBrightnessUp),  spawn $ "xbacklight -inc 1")

  -- Decrease brightness
  , ((0, xF86XK_MonBrightnessDown), spawn $ "xbacklight -dec 1")

  , ((0, xF86XK_AudioPlay), spawn $ "playerctl play-pause")

  , ((0, xF86XK_AudioNext), spawn $ "playerctl next")

  , ((0, xF86XK_AudioPrev), spawn $ "playerctl previous")

  , ((0, xF86XK_AudioStop), spawn $ "playerctl stop")


  --------------------------------------------------------------------
  --  XMONAD LAYOUT KEYS

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_Tab), toggleWS)

  , ((modMask, xK_BackSpace), sendMessage NextLayout)

  --Focus selected desktop
  , ((controlMask .|. mod1Mask , xK_Left ), prevWS)

  --Focus selected desktop
  , ((controlMask .|. mod1Mask , xK_Right ), nextWS)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)

  -- Move focus to the next window.
  , ((modMask, xK_j), windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k), windows W.focusUp  )

  -- Shrink the master area.
  , ((modMask, xK_h), sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_l), sendMessage Expand)

  -- Move focus to the master window.
  , ((modMask .|. shiftMask, xK_m), windows W.focusMaster  )

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j), windows W.swapDown  )

  -- Swap the focused window with the next window.
  , ((controlMask .|. modMask, xK_Down), windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k), windows W.swapUp    )

  -- Swap the focused window with the previous window.
  , ((controlMask .|. modMask, xK_Up), windows W.swapUp  )

  -- Push window back into tiling.
  , ((controlMask .|. shiftMask , xK_t), withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((controlMask .|. modMask, xK_Left), sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((controlMask .|. modMask, xK_Right), sendMessage (IncMasterN (-1)))

  -- Switch focus to next monitor
  -- , ((modMask, xK_dot), nextScreen)

  -- Switch focus to prev monitor
  , ((modMask, xK_comma), prevScreen)

  ]

  ++
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


main :: IO ()
main = do

    dbus <- D.connectSession
    -- Request access to the DBus name
    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

    xmonad . ewmh $
            myBaseConfig

                {startupHook = myStartupHook
, layoutHook = gaps [(U,80), (D,20), (R,20), (L,20)] $ myLayout
-- , layoutHook = gaps [(U,100), (D,30), (R,30), (L,30)] $ myLayout ||| layoutHook myBaseConfig
, manageHook = manageSpawn <+> myManageHook <+> manageHook myBaseConfig
, modMask = myModMask
, borderWidth = myBorderWidth
, handleEventHook    = handleEventHook myBaseConfig <+> fullscreenEventHook
, focusFollowsMouse = myFocusFollowsMouse
, workspaces = myWorkspaces
, focusedBorderColor = focdBord
, normalBorderColor = normBord
, keys = myKeys
, mouseBindings = myMouseBindings
}
