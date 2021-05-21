import System.IO (Handle, hPutStrLn)
import System.Exit
import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.Minimize
import XMonad.Hooks.ManageHelpers(doFullFloat, doCenterFloat, isFullscreen, isDialog)
import XMonad.Config.Desktop
import XMonad.Config.Azerty
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.SpawnOn
import XMonad.Util.EZConfig (additionalKeys, additionalMouseBindings)
import XMonad.Actions.CycleWS
import XMonad.Actions.CopyWindow
import XMonad.Hooks.UrgencyHook
import qualified Codec.Binary.UTF8.String as UTF8
import qualified XMonad.Actions.DynamicWorkspaceOrder as DO


import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.Cross(simpleCross)
import XMonad.Layout.Spiral(spiral)
import XMonad.Layout.Grid
import XMonad.Layout.ThreeColumns
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.IndependentScreens
import XMonad.Layout.CenteredMaster(centerMaster)
import XMonad.Layout.Minimize
import XMonad.Layout.Reflect

import Graphics.X11.ExtraTypes.XF86
import qualified System.IO
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified Data.ByteString as B


import XMonad.Util.NamedScratchpad

import Control.Monad (liftM2)

--mod4Mask= super key
--mod1Mask= alt key
--controlMask= ctrl key
--shiftMask= shift key

myModMask                     = mod4Mask
mydefaults = def {
          normalBorderColor   = "#1d1f21"
        , focusedBorderColor  = "#288AD6"
        , focusFollowsMouse   = True
        , mouseBindings       = myMouseBindings
        , workspaces          = myWorkspaces
        , keys                = myKeys
        , modMask             = myModMask
        , borderWidth         = 2
        , layoutHook          = myLayoutHook
        , startupHook         = myStartupHook
        , manageHook          = myManageHook
        , handleEventHook     = fullscreenEventHook <+> docksEventHook <+> minimizeEventHook
        }

-- Autostart
myStartupHook = do
    spawn "$HOME/.xmonad/scripts/autostart.sh"
    setWMName "LG3D"


encodeCChar = map fromIntegral . B.unpack

myTitleLength = 80 -- truncate window title to this length
myCurrentWSColor = "#6790eb" -- color of active workspace
myTitleColor = "#FFFFFF" -- color of window title
myVisibleWSColor = "#aaaaaa" -- color of inactive workspace
myUrgentWSColor = "#c91a1a" -- color of workspace with 'urgent' window
myHiddenNoWindowsWSColor = "white"


terminalScratchpadCmd = "alacritty --title=scratchpad " 
vpnScratchpadCmd = "alacritty --title vpn --command sudo openvpn --config ~/Documents/Work/3Resources/vpn/Connection.ovpn"
runscopeAgentScratchpadCmd = "alacritty --title runscope-agent --command runscope-radar -f ~/Documents/Work/3Resources/runscope/radar.conf"
musicScratchpadCmd = "alacritty --title=music --command=ncmpcpp" 
webcamScratchpadCmd = "mpv /dev/video2"

myLayoutHook =
  spacingRaw True (Border 0 20 20 20) True (Border 20 20 20 20) True $
  mkToggle (NBFULL ?? NOBORDERS ?? EOT) $
  -- noFrillsDeco shrinkText topBarTheme $
  avoidStruts $
  smartBorders $
  gaps [(U,25), (D,25), (R,25), (L,25)] $
  mkToggle (single REFLECTX) $
  mkToggle (single REFLECTY) $
  (reflectHoriz  tiled  ||| reflectVert (ThreeColMid 1 (1/100) (1/2)) ||| Full)
    where
        tiled = Tall nmaster delta tiled_ratio
        nmaster = 1
        delta = 3/100
        tiled_ratio = 1/2



--WORKSPACES
xmobarEscape = concatMap doubleLts
    where doubleLts '<' = "<<"
          doubleLts x = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape) $ [
    "\61612",
    "\61899",
    "\61557",
    "\61501",
    "\61888",
    "\62043",
    "\61485",
    "\61723",
    "\62003",
    "\61872"
  ]
    where
               clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" | (i,ws) <- zip [1, 2, 3, 4, 5, 6, 7, 8, 9, 0] l, let n = i ]


-- Scratchpads
myScratchPads :: [NamedScratchpad]
myScratchPads = [
                  NS "terminal" terminalScratchpadCmd (title =? "scratchpad") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)),
                  NS "vpn" vpnScratchpadCmd (title =? "vpn") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)),
                  NS "music" musicScratchpadCmd (title =? "music") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)),
                  NS "webcam" webcamScratchpadCmd (title =? "webcam") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)),
                  NS "runscope-agent" runscopeAgentScratchpadCmd (title =? "runscope-agent") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
                ]


-- window manipulations
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
    , className =? "obs"                                     --> doShift ( myWorkspaces !! 8 )
    , className =? "VirtualBox Manager"                      --> doShift ( myWorkspaces !! 8 )
    , isDialog --> doCenterFloat
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ] <+> namedScratchpadManageHook myScratchPads
-- keys config

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- SUPER + FUNCTION KEYS

  [
  -- MODKEY + ...
    ((modMask, xK_t),       namedScratchpadAction myScratchPads "terminal")
  , ((modMask, xK_f),       sendMessage $ XMonad.Layout.MultiToggle.Toggle NBFULL)
  , ((modMask, xK_q),       kill)
  , ((modMask, xK_e),       spawn $ "emacsclient -c -a ''")
  , ((modMask, xK_Return),  spawn $ "alacritty")
  , ((modMask, xK_space),   spawn $ "~/.config/rofi/launcher.sh")
  , ((modMask, xK_p),       spawn $ "rofi-pass")
  , ((modMask, xK_b),       spawn $ "rofi-surfraw")
  , ((modMask, xK_Escape),     spawn $ "xkill")


  -- MODKEY + SHIFT KEYS
  , ((modMask .|. shiftMask, xK_v),          namedScratchpadAction myScratchPads "vpn")
  , ((modMask .|. shiftMask, xK_a),          namedScratchpadAction myScratchPads "runscope-agent")
  , ((modMask .|. shiftMask, xK_r),          spawn $ "xmonad --recompile && xmonad --restart")
  , ((modMask .|. shiftMask, xK_m),          namedScratchpadAction myScratchPads "music")
  , ((modMask .|. shiftMask, xK_w),          namedScratchpadAction myScratchPads "webcam")
  , ((modMask .|. shiftMask, xK_Return ),    spawn $ "thunar")
  , ((modMask .|. shiftMask, xK_e ),         spawn $ "~/.config/rofi/power-menu.sh")

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
  , ((modMask .|. mod1Mask, xK_w),       spawn $ "whatsapp-nativefier")
  , ((modMask .|. mod1Mask, xK_d),       spawn $ "dbeaver")
  , ((modMask .|. mod1Mask, xK_z),       spawn $ "zoom")
  , ((modMask .|. mod1Mask, xK_i),       spawn $ "insomnia-designer")
  , ((modMask .|. mod1Mask, xK_c),       spawn $ "rofi -show calc")
  , ((modMask .|. mod1Mask, xK_o),       spawn $ "picom-toggle")
  , ((modMask .|. mod1Mask, xK_j),       spawn $ "variety -n && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
  , ((modMask .|. mod1Mask, xK_k),       spawn $ "variety -p && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")

  --CONTROL + ALT KEYS
  , ((controlMask .|. mod1Mask, xK_Delete ), spawn $ "xfce4-taskmanager")

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
  , ((0, xF86XK_MonBrightnessUp),  spawn $ "xbacklight -inc 2")

  -- Decrease brightness
  , ((0, xF86XK_MonBrightnessDown), spawn $ "xbacklight -dec 2")

--  , ((0, xF86XK_AudioPlay), spawn $ "mpc toggle")
--  , ((0, xF86XK_AudioNext), spawn $ "mpc next")
--  , ((0, xF86XK_AudioPrev), spawn $ "mpc prev")
--  , ((0, xF86XK_AudioStop), spawn $ "mpc stop")

  , ((0, xF86XK_AudioPlay), spawn $ "playerctl play-pause")
  , ((0, xF86XK_AudioNext), spawn $ "playerctl next")
  , ((0, xF86XK_AudioPrev), spawn $ "playerctl previous")
  , ((0, xF86XK_AudioStop), spawn $ "playerctl stop")


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


  , ((modMask, xK_s ), windows copyToAll) -- @@ Make focused window always visible
  , ((modMask .|. shiftMask, xK_s ),  killAllOtherCopies) -- @@ Toggle window state back


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
  , ((modMask, xK_0), setLayout $ XMonad.layoutHook conf )
  ]
  ++

  -- mod-[1..9] @@ Switch to workspace N
  -- mod-shift-[1..9] @@ Move client to workspace N
  -- mod-control-[1..9] @@ Copy client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 ..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask), (copy, controlMask)]]
  ++
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_comma, xK_period] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]



myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, 1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, 2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, 3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))

    ]

--XMOBAR
main = do

        xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.xmobarrc" -- xmobar monitor 1
        xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.xmobarrc" -- xmobar monitor 2
        xmonad $ ewmh $ mydefaults {
        logHook =  dynamicLogWithPP $ def {
        ppOutput = \x -> System.IO.hPutStrLn xmproc0 x  >> System.IO.hPutStrLn xmproc1 x
        , ppTitle = xmobarColor myTitleColor "" . ( shorten myTitleLength)
        , ppCurrent = xmobarColor myCurrentWSColor "" . wrap """"
        , ppVisible = xmobarColor myVisibleWSColor "" . wrap """"
        , ppHidden = wrap """"
        , ppHiddenNoWindows = xmobarColor myHiddenNoWindowsWSColor ""
        , ppUrgent = xmobarColor myUrgentWSColor ""
        , ppSep = " "
        , ppWsSep = "  "
        , ppLayout = (\ x -> case x of
           "Spacing Tall"                 -> "<fn=1>Tall</fn>"
           "Spacing Grid"                 -> "<fn=1>Grid</fn>"
           "Spacing Spiral"               -> "<fn=1>Spiral</fn>"
           "Spacing ThreeCol"             -> "<fn=1>ThreeColMid</fn>"
           "Spacing Full"                 -> "<fn=1>Full</fn>"
           _                                         -> x )
 }
}
