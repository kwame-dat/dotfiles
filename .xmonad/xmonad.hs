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
import XMonad.Actions.WithAll
import XMonad.Util.EZConfig (additionalKeys, additionalMouseBindings)
import XMonad.Actions.CycleWS
import XMonad.Actions.CopyWindow
import XMonad.Hooks.UrgencyHook
import qualified Codec.Binary.UTF8.String as UTF8

import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.Cross(simpleCross)
import XMonad.Layout.Spiral(spiral)
import XMonad.Layout.ThreeColumns
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.IndependentScreens
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.CenteredMaster(centerMaster)

import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified Data.ByteString as B
import Control.Monad (liftM2)
import qualified DBus as D
import qualified DBus.Client as D

import XMonad.Util.NamedScratchpad
import XMonad.ManageHook

myStartupHook = do
    spawn "$HOME/.xmonad/scripts/autostart.sh"
    setWMName "LG3D"

myTerminal = "alacritty"
myFont      = "-*-terminus-medium-*-*-*-*-160-*-*-*-*-*-*"

terminalScratchpadCmd = "alacritty --title=scratchpad " 
vpnScratchpadCmd = "alacritty --title vpn --command sudo openvpn --config ~/Documents/Work/3Resources/vpn/Connection.ovpn"
runscopeAgentScratchpadCmd = "alacritty --title runscope-agent --command runscope-radar -f ~/Documents/Work/3Resources/runscope/radar.conf"
musicScratchpadCmd = "alacritty --title=music --command=ncmpcpp" 
webcamScratchpadCmd = "mpv /dev/video2"

-- colours
base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"

active      = blue
activeWarn  = red
inactive    = base02
focusColor  = blue
unfocusColor = base02

topBarTheme = def
    { 
      fontName              = myFont
    , inactiveBorderColor   = base03
    , inactiveColor         = base03
    , inactiveTextColor     = base03
    , activeBorderColor     = active
    , activeColor           = active
    , activeTextColor       = active
    , urgentBorderColor     = activeWarn
    , urgentTextColor       = activeWarn
    , decoHeight            = 30
    }

myModMask = mod4Mask
encodeCChar = map fromIntegral . B.unpack
myFocusFollowsMouse = True
myBorderWidth = 1
myWorkspaces = [
    "\61612",
    "\61899",
    "\61557",
    "\61501",
    "\61888",
    "\62043",
    "\61485",
    "\61723",
    "\62003",
    "\61705"
    ]

myBaseConfig = desktopConfig

-- Scratchpads
myScratchPads :: [NamedScratchpad]
myScratchPads = [
                  NS "terminal" terminalScratchpadCmd (title =? "scratchpad") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)),
                  NS "vpn" vpnScratchpadCmd (title =? "vpn") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)),
                  NS "music" musicScratchpadCmd (title =? "music") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)),
                  NS "webcam" webcamScratchpadCmd (title =? "webcam") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)),
                  NS "runscope-agent" runscopeAgentScratchpadCmd (title =? "runscope-agent") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
                ]

-- Window Manipulations
myManageHook = composeAll
    [
      className =? "MPlayer"                                 --> doFloat
    , className =? "Gimp"                                    --> doFloat
    , className =? "Evolution-alarm-notify"                  --> doFloat
    , resource  =? "desktop_window"                          --> doIgnore
    , resource  =? "kdesktop"                                --> doIgnore
    , className =? "qutebrowser"                             --> doShift ( myWorkspaces !! 0 )
    , className =? "Google-chrome"                           --> doShift ( myWorkspaces !! 0 )
    , className =? "Brave-browser"                           --> doShift ( myWorkspaces !! 0 )
    , className =? "firefox"                                 --> doShift ( myWorkspaces !! 0 )
    , className =? "Emacs"                                   --> doShift ( myWorkspaces !! 1 )
    , className =? "jetbrains-phpstorm"                      --> doShift ( myWorkspaces !! 1 )
    , className =? "Slack"                                   --> doShift ( myWorkspaces !! 2 )
    , className =? "TelegramDesktop"                         --> doShift ( myWorkspaces !! 2 )
    , className =? "whatsapp-nativefier-d40211"              --> doShift ( myWorkspaces !! 2 )
    , className =? "Signal"                                  --> doShift ( myWorkspaces !! 2 )
    , className =? "Microsoft Teams - Preview"               --> doShift ( myWorkspaces !! 3 )
    , className =? "zoom"                                    --> doShift ( myWorkspaces !! 3 )
    , className =? "Jitsi Meet"                              --> doShift ( myWorkspaces !! 3 )
    , className =? "DBeaver"                                 --> doShift ( myWorkspaces !! 4 )
    , className =? "Insomnia Designer"                       --> doShift ( myWorkspaces !! 5 )
    , className =? "Insomnia"                                --> doShift ( myWorkspaces !! 5 )
    , className =? "Stoplight Studio"                        --> doShift ( myWorkspaces !! 5 )
    , className =? "Postman"                                 --> doShift ( myWorkspaces !! 5 )
    , className =? "calibre"                                 --> doShift ( myWorkspaces !! 6 )
    , className =? "Nextcloud"                               --> doShift ( myWorkspaces !! 8 )
    , className =? "Evolution"                               --> doShift ( myWorkspaces !! 8 )
    , className =? "obs"                                     --> doShift ( myWorkspaces !! 9 )
    , className =? "VirtualBox Manager"                      --> doShift ( myWorkspaces !! 9 )
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ] <+> namedScratchpadManageHook myScratchPads


myLayout =
  spacingRaw True (Border 0 20 20 20) True (Border 20 20 20 20) True $
  mkToggle (NBFULL ?? NOBORDERS ?? EOT) $
  -- noFrillsDeco shrinkText topBarTheme $
  avoidStruts $
  gaps [(U,25), (D,25), (R,25), (L,25)] $
  tiled |||
  ThreeColMid 1 (1/100) (1/2) |||
  Full
    where
        tiled = Tall nmaster delta tiled_ratio
        nmaster = 1
        delta = 3/100
        tiled_ratio = 1/2


-- Mouse Configuration
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, 1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, 2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, 3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
    ]


-- Keys Configuration
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  [
  -- MODKEY + ...
    ((modMask, xK_t),       namedScratchpadAction myScratchPads "terminal")
  , ((modMask, xK_f),       sendMessage $ XMonad.Layout.MultiToggle.Toggle NBFULL)
  , ((modMask, xK_q),       kill)
  , ((modMask, xK_e),       spawn $ "emacsclient -c -a ''")
  , ((modMask, xK_Return),  spawn $ "alacritty")
  , ((modMask, xK_space),   spawn $ "~/.config/rofi/launcher/launcher.sh")
  , ((modMask, xK_p),       spawn $ "rofi-pass")
  , ((modMask, xK_b),       spawn $ "rofi-surfraw")
  , ((modMask, xK_s),       windows copyToAll)
  , ((modMask .|. shiftMask, xK_s),       killAllOtherCopies)


  -- MODKEY + SHIFT KEYS
  , ((modMask .|. shiftMask, xK_v),          namedScratchpadAction myScratchPads "vpn")
  , ((modMask .|. shiftMask, xK_a),          namedScratchpadAction myScratchPads "runscope-agent")
  , ((modMask .|. shiftMask, xK_r),          spawn $ "xmonad --recompile && xmonad --restart")
  , ((modMask .|. shiftMask, xK_m),          namedScratchpadAction myScratchPads "music")
  , ((modMask .|. shiftMask, xK_w),          namedScratchpadAction myScratchPads "webcam")
  , ((modMask .|. shiftMask, xK_Return ),    spawn $ "thunar")
  , ((modMask .|. shiftMask, xK_q ),         killAll)
  -- , ((modMask .|. shiftMask, xK_s ),         spawn $ "maim -s | xclip -selection clipboard -t image/png")
  , ((modMask .|. shiftMask, xK_e ),         spawn $ "~/.config/rofi/powermenu/powermenu.sh")

  -- FUNCTION KEYS
  -- Take a full screenshot and save it in downloads
  , ((0, xK_F5), spawn $ "maim ~/Downloads/screenshot_$(date +%s).png")
  -- Take screenshot of active window and save it in downloads
  , ((0, xK_F6), spawn $ "maim -i $(xdotool getactivewindow) ~/Downloads/screenshot_$(date +%s).jpg")
  -- Take screenshot in clipboard
  , ((0, xK_F7), spawn $ "maim -s | xclip -selection clipboard -t image/png")
  -- , ((0, xK_F9), spawn $ "~/.config/rofi/launchers/misc/launcher.sh")
  , ((0, xK_F11), sendMessage $ XMonad.Layout.MultiToggle.Toggle NBFULL)

  , ((0, xF86XK_Search), spawn $ "~/.config/rofi/launchers/misc/launcher.sh")

  -- MODKEY + FUNCTIONS KEYS
  , ((modMask, xK_F1), spawn $ "qutebrowser")
  , ((modMask, xF86XK_AudioMute), spawn $ "qutebrowser")

  , ((modMask, xK_F2), spawn $ "emacsclient -c -a ''")
  , ((modMask, xF86XK_AudioLowerVolume), spawn $ "emacsclient -c -a ''")

  , ((modMask, xK_F3), spawn $ "slack")
  , ((modMask, xF86XK_AudioRaiseVolume), spawn $ "slack")

  , ((modMask, xK_F4), spawn $ "teams")
  , ((modMask, xF86XK_AudioPrev), spawn $ "teams")

  , ((modMask, xK_F5), spawn $ "dbeaver")
  , ((modMask, xF86XK_AudioPlay), spawn $ "dbeaver")

  , ((modMask, xK_F6), spawn $ "insomnia-designer")
  , ((modMask, xF86XK_AudioNext), spawn $ "insomnia-designer")

  , ((modMask, xK_F7), spawn $ "virtualbox")

  , ((modMask, xK_F8), spawn $ "calibre")

  -- SUPER + ALT KEYS
  , ((modMask .|. mod1Mask, xK_a),       spawn $ "emacsclient -c -a '' --eval '(itechytony/day-view)'")
  , ((modMask .|. mod1Mask, xK_e),       spawn $ "emacs")
  , ((modMask .|. mod1Mask, xK_m),       spawn $ "xfce4-settings-manager")
  , ((modMask .|. mod1Mask, xK_s),       spawn $ "slack")
  , ((modMask .|. mod1Mask, xK_t),       spawn $ "teams")
  , ((modMask .|. mod1Mask, xK_p),       spawn $ "pamac-manager")
  , ((modMask .|. mod1Mask, xK_v),       spawn $ "pavucontrol")
  , ((modMask .|. mod1Mask, xK_f),       spawn $ "firefox")
  , ((modMask .|. mod1Mask, xK_g),       spawn $ "google-chrome-stable -no-default-browser-check")
  , ((modMask .|. mod1Mask, xK_q),       spawn $ "qutebrowser")
  , ((modMask .|. mod1Mask, xK_b),       spawn $ "")
  , ((modMask .|. mod1Mask, xK_w),       spawn $ "whatsapp-nativefier")
  , ((modMask .|. mod1Mask, xK_d),       spawn $ "dbeaver")
  , ((modMask .|. mod1Mask, xK_z),       spawn $ "zoom")
  , ((modMask .|. mod1Mask, xK_i),       spawn $ "insomnia-designer")
  , ((modMask .|. mod1Mask, xK_c),       spawn $ "rofi -show calc")
  , ((modMask .|. mod1Mask, xK_o),       spawn $ "picom-toggle")
  , ((modMask .|. mod1Mask, xK_j),       spawn $ "variety -n && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
  , ((modMask .|. mod1Mask, xK_k),       spawn $ "variety -p && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")

  --CONTROL + ALT KEYS
  , ((controlMask .|. mod1Mask, xK_Escape ), spawn $ "xkill")
  , ((controlMask .|. mod1Mask, xK_Delete ), spawn $ "xfce4-taskmanager")

  --SCREENSHOTS
  -- , ((0, xK_Print), spawn $ "flameshot gui")
  -- , ((controlMask .|. shiftMask , xK_Print ), spawn $ "gnome-screenshot -i")


  --MULTIMEDIA KEYS

  -- Mute volume
  , ((0, xF86XK_AudioMute), spawn $ "amixer -q set Master toggle")

  -- Decrease volume
  , ((0, xF86XK_AudioLowerVolume), spawn $ "amixer -q set Master 10%-")

  -- Increase volume
  , ((0, xF86XK_AudioRaiseVolume), spawn $ "amixer -q set Master 10%+")

  -- Increase brightness
  , ((0, xF86XK_MonBrightnessUp),  spawn $ "xbacklight -inc 10")

  -- Decrease brightness
  , ((0, xF86XK_MonBrightnessDown), spawn $ "xbacklight -dec 10")

  , ((0, xF86XK_AudioPlay), spawn $ "mpc toggle")
  , ((0, xF86XK_AudioNext), spawn $ "mpc next")
  , ((0, xF86XK_AudioPrev), spawn $ "mpc previous")
  , ((0, xF86XK_AudioStop), spawn $ "mpc stop")

  --------------------------------------------------------------------
  --  XMONAD LAYOUT KEYS

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_Tab), toggleWS)

  --  Reset the layouts on the current workspace to default.
  , ((modMask, xK_grave), sendMessage NextLayout)

  --Focus selected desktop
  , ((modMask , xK_bracketleft ), prevWS)

  --Focus selected desktop
  , ((modMask , xK_bracketright ), nextWS)

  -- Move focus to the next window.
  , ((modMask, xK_j), windows W.focusDown)
  , ((modMask, xK_Down), windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k), windows W.focusUp )
  , ((modMask, xK_Up), windows W.focusUp )


  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_k), windows W.swapDown)
  , ((modMask .|. shiftMask, xK_Up), windows W.swapDown)

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_j), windows W.swapUp)
  , ((modMask .|. shiftMask, xK_Down), windows W.swapUp)

  -- Shrink the master area.
  , ((modMask, xK_l), sendMessage Shrink)
  , ((modMask, xK_Right), sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_h), sendMessage Expand)
  , ((modMask, xK_Left), sendMessage Expand)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_equal), sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_minus), sendMessage (IncMasterN (-1)))

  -- Move focus to the master window.
  , ((modMask, xK_0), windows W.focusMaster )
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (myWorkspaces) [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9, xK_0]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask), (copy, controlMask)]]


main :: IO ()
main = do
    dbus <- D.connectSession
    -- Request access to the DBus name
    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

    xmonad . ewmh $
            myBaseConfig
                { startupHook = myStartupHook
                , layoutHook = smartBorders $ myLayout
                , manageHook = manageSpawn <+> myManageHook <+> manageHook myBaseConfig
                , modMask = myModMask
                , terminal = myTerminal
                , borderWidth = myBorderWidth
                , handleEventHook = handleEventHook myBaseConfig <+> fullscreenEventHook
                , focusFollowsMouse = myFocusFollowsMouse
                , workspaces = myWorkspaces
                , focusedBorderColor = active
                , normalBorderColor = inactive
                , keys = myKeys
                , mouseBindings = myMouseBindings
}
