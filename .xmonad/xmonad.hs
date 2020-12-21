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
focdBord = "#b5bd68"
fore     = "#DEE3E0"
back     = "#282c34"
winType  = "#c678dd"

--mod4Mask= super key
--mod1Mask= alt key
--controlMask= ctrl key
--shiftMask= shift key

myModMask = mod4Mask
encodeCChar = map fromIntegral . B.unpack
myFocusFollowsMouse = True
myBorderWidth = 5
myWorkspaces    = ["\61612","\61899","\61557","\62043","\61888","\61485","\61705","\61723","\61501","\61441"]
--myWorkspaces    = ["1","2","3","4","5","6","7","8","9","10"]
--myWorkspaces    = ["I","II","III","IV","V","VI","VII","VIII","IX","X"]

myBaseConfig = desktopConfig

-- window manipulations
myManageHook = composeAll
    [
      className =? "MPlayer"                                 --> doFloat
    , className =? "Gimp"                                    --> doFloat
    , resource  =? "desktop_window"                          --> doIgnore
    , resource  =? "kdesktop"                                --> doIgnore
    , className =? "qutebrowser"                             --> doShift ( myWorkspaces !! 0 )
    , className =? "Google-chrome"                           --> doShift ( myWorkspaces !! 0 )
    , className =? "Vivaldi-stable"                          --> doShift ( myWorkspaces !! 0 )
    , className =? "Chromium"                                --> doShift ( myWorkspaces !! 0 )
    , className =? "Brave-browser"                           --> doShift ( myWorkspaces !! 0 )
    , className =? "firefox"                                 --> doShift ( myWorkspaces !! 0 )
    , className =? "Emacs"                                   --> doShift ( myWorkspaces !! 1 )
    , className =? "jetbrains-phpstorm"                      --> doShift ( myWorkspaces !! 1 )
    , className =? "whatsapp-nativefier-d52542"              --> doShift ( myWorkspaces !! 2 )
    , className =? "Signal"                                  --> doShift ( myWorkspaces !! 2 )
    , className =? "whatsdesk"                               --> doShift ( myWorkspaces !! 2 )
    , className =? "Slack"                                   --> doShift ( myWorkspaces !! 2 )
    , className =? "Microsoft Teams - Preview"               --> doShift ( myWorkspaces !! 2 )
    , className =? "Insomnia"                                --> doShift ( myWorkspaces !! 3 )
    , className =? "Postman"                                 --> doShift ( myWorkspaces !! 3 )
    , className =? "DBeaver"                                 --> doShift ( myWorkspaces !! 4 )
    , className =? "Stoplight Studio"                        --> doShift ( myWorkspaces !! 5 )
    , className =? "calibre"                                 --> doShift ( myWorkspaces !! 5 )
    , className =? "Thunderbird"                             --> doShift ( myWorkspaces !! 5 )
    , className =? "obs"                                     --> doShift ( myWorkspaces !! 6 )
    , className =? "vlc"                                     --> doShift ( myWorkspaces !! 6 )
    , className =? "VirtualBox Manager"                      --> doShift ( myWorkspaces !! 6 )
    , className =? "Nextcloud"                               --> doShift ( myWorkspaces !! 6 )
    , className =? "zoom"                                    --> doShift ( myWorkspaces !! 8 )
    , className =? "Spotify"                                 --> doShift ( myWorkspaces !! 9 )
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ]


myLayout =
  spacingRaw True (Border 0 15 15 15) True (Border 15 15 15 15) True $
  mkToggle (NBFULL ?? NOBORDERS ?? EOT) $
  avoidStruts $
  tiled |||
  Mirror tiled |||
  spiral (6/7)  |||
  ThreeColMid 1 (3/100) (1/2) |||
  Full
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

  [
    ((modMask, xK_p), spawn $ "rofi-pass")
  , ((modMask, xK_b), spawn $ "rofi-surfraw")
  , ((modMask, xK_space ), spawn $ "rofi -show combi")
  , ((modMask, xK_e), spawn $ "emacsclient -c -a ''" )
  , ((modMask, xK_f), sendMessage $ Toggle NBFULL)
  , ((modMask, xK_h), spawn $ "alacritty 'htop task manager' -e htop" )
  , ((modMask, xK_m), spawn $ "pragha" )
  , ((modMask, xK_q), kill )
  , ((modMask, xK_t), spawn $ "alacritty" )
  , ((modMask, xK_v), spawn $ "pavucontrol" )
  , ((modMask, xK_y), spawn $ "polybar-msg cmd toggle" )
  , ((modMask, xK_Escape), spawn $ "xkill" )
  , ((modMask, xK_Return), spawn $ "alacritty" )


    --FUNCTIONS KEY 
  , ((modMask, xK_F1), spawn $ "chromium")
  , ((modMask, xK_F2), spawn $ "emacsclient -c -a ''")
  , ((modMask, xK_F3), spawn $ "slack")
  , ((modMask, xK_F4), spawn $ "zoom")
  , ((modMask, xK_F5), spawn $ "dbeaver")
  , ((modMask, xK_F6), spawn $ "insomnia")
  , ((modMask, xK_F7), spawn $ "vlc --video-on-top")
  , ((modMask, xK_F8), spawn $ "virtualbox")
  , ((modMask, xK_F9), spawn $ "spotify")
  , ((modMask, xK_F10), spawn $ "termite")


  -- SUPER + FUNCTION KEYS
  , ((modMask, xK_F1), spawn $ "vivaldi-stable" )
  , ((modMask, xK_F2), spawn $ "atom" )
  , ((modMask, xK_F3), spawn $ "inkscape" )
  , ((modMask, xK_F4), spawn $ "gimp" )
  , ((modMask, xK_F5), spawn $ "meld" )
  , ((modMask, xK_F6), spawn $ "vlc --video-on-top" )
  , ((modMask, xK_F7), spawn $ "virtualbox" )
  , ((modMask, xK_F8), spawn $ "thunar" )
  , ((modMask, xK_F9), spawn $ "evolution" )
  , ((modMask, xK_F10), spawn $ "spotify" )

  -- FUNCTION KEYS
  , ((0, xK_F12), spawn $ "xfce4-terminal --drop-down" )

  -- SUPER + SHIFT KEYS

  , ((modMask .|. shiftMask , xK_Return ), spawn $ "thunar")
  , ((modMask .|. shiftMask , xK_d ), spawn $ "dmenu_run -i -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=14'")
  , ((modMask .|. shiftMask , xK_r ), spawn $ "xmonad --recompile && xmonad --restart")
  , ((modMask .|. shiftMask , xK_q ), kill)
  , ((modMask .|. shiftMask, xK_e ), spawn $ "arcolinux-logout")
  -- , ((modMask .|. shiftMask , xK_x ), io (exitWith ExitSuccess))

  -- CONTROL + ALT KEYS
  , ((controlMask .|. mod1Mask , xK_a ), spawn $ "xfce4-appfinder")
  , ((controlMask .|. mod1Mask , xK_b ), spawn $ "thunar")
  , ((controlMask .|. mod1Mask , xK_c ), spawn $ "catfish")
  , ((controlMask .|. mod1Mask, xK_e), spawn $ "emacsclient -c -a ''")
  , ((controlMask .|. mod1Mask, xK_m), spawn $ "emacsclient -c -a '' --eval '(mu4e)'")
  , ((controlMask .|. mod1Mask, xK_a), spawn $ "emacsclient -c -a '' --eval '(itechytony/day-view)'")
  , ((controlMask .|. mod1Mask, xK_s), spawn $ "slack")
  , ((controlMask .|. mod1Mask, xK_t), spawn $ "teams")
  , ((controlMask .|. mod1Mask, xK_p), spawn $ "pamac-manager")
  , ((controlMask .|. mod1Mask, xK_f), spawn $ "firefox")
  , ((controlMask .|. mod1Mask , xK_m ), spawn $ "xfce4-settings-manager")
  , ((controlMask .|. mod1Mask, xK_g), spawn $ "chromium -no-default-browser-check")
  , ((controlMask .|. mod1Mask , xK_t ), spawn $ "alacritty")
  , ((controlMask .|. mod1Mask, xK_b), spawn $ "brave")
  , ((controlMask .|. mod1Mask, xK_w), spawn $ "whatsdesk")
  , ((controlMask .|. mod1Mask, xK_d), spawn $ "dbeaver")
  , ((controlMask .|. mod1Mask, xK_z), spawn $ "zoom")
  , ((controlMask .|. mod1Mask, xK_i), spawn $ "insomnia")
  , ((controlMask .|. mod1Mask, xK_c), spawn $ "rofi -show calc")
  , ((controlMask .|. mod1Mask, xK_o), spawn $ "picom-toggle")
  , ((controlMask .|. mod1Mask, xK_v), spawn $ "pavucontrol")
  , ((controlMask .|. mod1Mask , xK_k ), spawn $ "arcolinux-logout")
  , ((controlMask .|. mod1Mask , xK_l ), spawn $ "arcolinux-logout")
  , ((controlMask .|. mod1Mask , xK_v ), spawn $ "vivaldi-stable")
  , ((controlMask .|. mod1Mask , xK_Return ), spawn $ "alacritty")

  -- ALT + ... KEYS

  , ((mod1Mask, xK_f), spawn $ "variety -f" )
  , ((mod1Mask, xK_n), spawn $ "variety -n" )
  , ((mod1Mask, xK_p), spawn $ "variety -p" )
  , ((mod1Mask, xK_r), spawn $ "xmonad --restart" )
  , ((mod1Mask, xK_t), spawn $ "variety -t" )
  , ((mod1Mask, xK_Up), spawn $ "variety --pause" )
  , ((mod1Mask, xK_Down), spawn $ "variety --resume" )
  , ((mod1Mask, xK_Left), spawn $ "variety -p" )
  , ((mod1Mask, xK_Right), spawn $ "variety -n" )
  , ((mod1Mask, xK_F2), spawn $ "gmrun" )
  , ((mod1Mask, xK_F3), spawn $ "xfce4-appfinder" )

  --VARIETY KEYS WITH PYWAL

  , ((mod1Mask .|. shiftMask , xK_f ), spawn $ "variety -f && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
  , ((mod1Mask .|. shiftMask , xK_n ), spawn $ "variety -n && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
  , ((mod1Mask .|. shiftMask , xK_p ), spawn $ "variety -p && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
  , ((mod1Mask .|. shiftMask , xK_t ), spawn $ "variety -t && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
  , ((mod1Mask .|. shiftMask , xK_u ), spawn $ "wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")

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
  , ((0, xF86XK_MonBrightnessUp),  spawn $ "xbacklight -inc 5")

  -- Decrease brightness
  , ((0, xF86XK_MonBrightnessDown), spawn $ "xbacklight -dec 5")

  , ((0, xF86XK_AudioPlay), spawn $ "playerctl play-pause")
  , ((0, xF86XK_AudioNext), spawn $ "playerctl next")
  , ((0, xF86XK_AudioPrev), spawn $ "playerctl previous")
  , ((0, xF86XK_AudioStop), spawn $ "playerctl stop")


  --------------------------------------------------------------------
  --  XMONAD LAYOUT KEYS

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_Tab), sendMessage NextLayout)

  -- --Focus selected desktop
  -- , ((mod1Mask, xK_Tab), nextWS)

  -- --Focus selected desktop
  -- , ((modMask, xK_Tab), nextWS)

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

  -- Shrink the master area.
  , ((controlMask .|. shiftMask , xK_h), sendMessage Shrink)

  -- Expand the master area.
  , ((controlMask .|. shiftMask , xK_l), sendMessage Expand)

  -- Push window back into tiling.
  , ((controlMask .|. shiftMask , xK_t), withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((controlMask .|. modMask, xK_Left), sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((controlMask .|. modMask, xK_Right), sendMessage (IncMasterN (-1)))

  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)

  --Keyboard layouts
  --qwerty users use this line
   | (i, k) <- zip (XMonad.workspaces conf) [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0]

  --French Azerty users use this line
  -- | (i, k) <- zip (XMonad.workspaces conf) [xK_ampersand, xK_eacute, xK_quotedbl, xK_apostrophe, xK_parenleft, xK_minus, xK_egrave, xK_underscore, xK_ccedilla , xK_agrave]

  --Belgian Azerty users use this line
  -- | (i, k) <- zip (XMonad.workspaces conf) [xK_ampersand, xK_eacute, xK_quotedbl, xK_apostrophe, xK_parenleft, xK_section, xK_egrave, xK_exclam, xK_ccedilla, xK_agrave]

      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)
      , (\i -> W.greedyView i . W.shift i, shiftMask)]]

  ++
  -- ctrl-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- ctrl-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. controlMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


main :: IO ()
main = do

    dbus <- D.connectSession
    -- Request access to the DBus name
    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]


    xmonad . ewmh $
  --Keyboard layouts
  --qwerty users use this line
            myBaseConfig
  --French Azerty users use this line
            --myBaseConfig { keys = azertyKeys <+> keys azertyConfig }
  --Belgian Azerty users use this line
            --myBaseConfig { keys = belgianKeys <+> keys belgianConfig }

                {startupHook = myStartupHook
, layoutHook = smartBorders $ myLayout
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
