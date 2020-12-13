-- Imports
import XMonad
import Data.Monoid
import System.Exit
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import qualified Codec.Binary.UTF8.String as UTF8

-- For Xmobar
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import System.IO

-- Layouts
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

-- Toggle Fullscreen
import XMonad.Hooks.ManageHelpers
-- import XMonad.Layout.ToggleLayouts

import XMonad.Layout.Spacing
import XMonad.Layout.Gaps

import XMonad.Actions.CycleWS

-- This is for multi media keys
import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
-- Currently based on the ir_black theme.
myNormalBorderColor  = "#7c7c7c"
myFocusedBorderColor = "#f0c674"

-- Color of current window title in xmobar.
xmobarTitleColor = "f0c674"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#CEFFAC"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,   xK_Return), spawn $ XMonad.terminal conf)

    , ((modm,               xK_p     ), spawn "rofi-pass")
    , ((modm,               xK_e     ), spawn "emacsclient -c -a ''")
    , ((modm,               xK_Escape     ), spawn "xkill")
    , ((modm,               xK_b     ), spawn "rofi-surfraw")
    , ((modm,               xK_f     ), sendMessage $ Toggle NBFULL)

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm, xK_q     ), kill)

    -- launch rofi
    , ((modm,               xK_space ), spawn "rofi -show combi")

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), sendMessage NextLayout)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    , ((modm .|. shiftMask, xK_Return), spawn "dolphin")

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_e     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart")

    , ((modm , xK_Print    ), spawn "flameshot gui")

    -- CONTROl + ALT KEYS
    , ((controlMask .|. mod1Mask, xK_e), spawn "emacsclient -c -a ''")
    , ((controlMask .|. mod1Mask, xK_m), spawn "emacsclient -c -a '' --eval '(mu4e)'")
    , ((controlMask .|. mod1Mask, xK_a), spawn "emacsclient -c -a '' --eval '(itechytony/day-view)'")
    , ((controlMask .|. mod1Mask, xK_s), spawn "slack")
    , ((controlMask .|. mod1Mask, xK_t), spawn "teams")
    , ((controlMask .|. mod1Mask, xK_p), spawn "pamac-manager")
    , ((controlMask .|. mod1Mask, xK_f), spawn "firefox")
    , ((controlMask .|. mod1Mask, xK_g), spawn "chromium -no-default-browser-check")
    , ((controlMask .|. mod1Mask, xK_b), spawn "brave")
    , ((controlMask .|. mod1Mask, xK_w), spawn "whatsdesk")
    , ((controlMask .|. mod1Mask, xK_d), spawn "dbeaver")
    , ((controlMask .|. mod1Mask, xK_z), spawn "zoom")
    , ((controlMask .|. mod1Mask, xK_i), spawn "insomnia")
    , ((controlMask .|. mod1Mask, xK_c), spawn "rofi -show calc")
    , ((controlMask .|. mod1Mask, xK_o), spawn "picom-toggle")
    , ((controlMask .|. mod1Mask, xK_v), spawn "pavucontrol")

    --  CONTROL + SHIF KEYS
    , ((controlMask .|. shiftMask, xK_Escape), spawn "xfce4-taskmanager")

    --  ALT + SHIFT KEYS
    , ((mod1Mask .|. shiftMask, xK_t), spawn "variety -t && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
    , ((mod1Mask .|. shiftMask, xK_n), spawn "variety -n && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
    , ((mod1Mask .|. shiftMask, xK_p), spawn "variety -p && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
    , ((mod1Mask .|. shiftMask, xK_f), spawn "variety -f && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
    , ((mod1Mask .|. shiftMask, xK_u), spawn "wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")


    --MULTIMEDIA KEYS
    -- Mute volume
    , ((0, xF86XK_AudioMute), spawn $ "amixer -q set Master toggle")
    -- Decrease volume
    , ((0, xF86XK_AudioLowerVolume), spawn $ "amixer -q set Master 2%-")
    -- Increase volume
    , ((0, xF86XK_AudioRaiseVolume), spawn $ "amixer -q set Master 2%+")
    -- Increase brightness
    , ((0, xF86XK_MonBrightnessUp),  spawn $ "xbacklight -inc 2")
    -- Decrease brightness
    , ((0, xF86XK_MonBrightnessDown), spawn $ "xbacklight -dec 2")
    , ((0, xF86XK_AudioPlay), spawn $ "playerctl play-pause")
    , ((0, xF86XK_AudioNext), spawn $ "playerctl next")
    , ((0, xF86XK_AudioPrev), spawn $ "playerctl previous")
    , ((0, xF86XK_AudioStop), spawn $ "playerctl stop")

    --FUNCTIONS KEY 
    , ((modm, xK_F1), spawn $ "chromium")
    , ((modm, xK_F2), spawn $ "emacsclient -c -a ''")
    , ((modm, xK_F3), spawn $ "slack")
    , ((modm, xK_F4), spawn $ "zoom")
    , ((modm, xK_F5), spawn $ "dbeaver")
    , ((modm, xK_F6), spawn $ "insomnia")
    , ((modm, xK_F7), spawn $ "vlc --video-on-top")
    , ((modm, xK_F8), spawn $ "virtualbox")
    , ((modm, xK_F9), spawn $ "spotify")
    , ((modm, xK_F10), spawn $ "termite")
    -- , ((modm, xK_F11), spawn $ "spotify") for webcam lunchpad
    -- , ((modm, xK_F12), spawn $ "spotify") terminal lunchpad
    , ((modm,               xK_Down),  nextWS)
    , ((modm,               xK_Up),    prevWS)
    , ((modm .|. shiftMask, xK_Down),  shiftToNext)
    , ((modm .|. shiftMask, xK_Up),    shiftToPrev)
    , ((modm,               xK_Right), nextScreen)
    , ((modm,               xK_Left),  prevScreen)
    , ((modm .|. shiftMask, xK_Right), shiftNextScreen)
    , ((modm .|. shiftMask, xK_Left),  shiftPrevScreen)
    , ((modm,               xK_z),     toggleWS)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:
myLayoutHook =
  spacingRaw True (Border 0 15 15 15) True (Border 15 15 15 15) True $
  mkToggle (NBFULL ?? NOBORDERS ?? EOT) $
  avoidStruts $
  gaps [(U,30), (D,30), (R,30), (L,30)] $
  tiled |||
  Mirror tiled |||
  spiral (6/7) |||
  ThreeColMid 1 (3/100) (1/2) |||
  Full
    where
        tiled = Tall nmaster delta tiled_ratio
        nmaster = 1
        delta = 3/100
        tiled_ratio = 1/2

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
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
    , className =? "zoom"                                    --> doShift ( myWorkspaces !! 2 )
    , className =? "Microsoft Teams - Preview"               --> doShift ( myWorkspaces !! 2 )
    , className =? "DBeaver"                                 --> doShift ( myWorkspaces !! 3 )
    , className =? "Insomnia"                                --> doShift ( myWorkspaces !! 4 )
    , className =? "Postman"                                 --> doShift ( myWorkspaces !! 4 )
    , className =? "Stoplight Studio"                        --> doShift ( myWorkspaces !! 5 )
    , className =? "calibre"                                 --> doShift ( myWorkspaces !! 5 )
    -- , [className =? "obs"                                     --> doShift ( myWorkspaces !! 7 )]
    -- , [className =? "vlc"                                     --> doShift ( myWorkspaces !! 7 )]
    , className =? "Thunderbird"                             --> doShift ( myWorkspaces !! 5 )
    , className =? "VirtualBox Manager"                      --> doShift ( myWorkspaces !! 6 )
    , className =? "Nextcloud"                               --> doShift ( myWorkspaces !! 6 )
    , className =? "Spotify"                                 --> doShift ( myWorkspaces !! 8 )
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    spawn "$HOME/.xmonad/scripts/autostart.sh"
    setWMName "LG3D"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
-- main = xmonad defaults
main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaults {
      logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc
          , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
          , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
          , ppSep = "   "
      }
      , manageHook = manageDocks <+> myManageHook
      , startupHook = myStartupHook
      , handleEventHook = docksEventHook <+> fullscreenEventHook
  }
        
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces, 
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = smartBorders $ myLayoutHook ,
        manageHook         = myManageHook,
        handleEventHook = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
