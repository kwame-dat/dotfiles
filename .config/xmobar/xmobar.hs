Config {
   -- appearance
     font             = "xft:Ubuntu Mono:size=10:antialias=true:hinting=true,xft:Ubuntu Mono:size=10:antialias=true"
   , additionalFonts  = ["xft:FontAwesome5Free:style=Solid:size=8:antialias=true"
                        , "xft:FontAwesome5Free:size=8:antialias=true"
                        , "xft:FontAwesome5Brands:size=8:antialias=false"
                        , "xft:FontAwesome5Free:style=Solid:size=8:antialias=true"]
   , bgColor          = "#1d1f21"
   , alpha            = 255                            -- 0 is transparent, 255 is opaque. 255 -> xmobar bgcolor, xmonad.hs xmobarPP bgcolor on
   , fgColor          = "#f9f9f2"
   , position         = TopSize C 100 25
   , border           = BottomB                       -- TopB, TopBM, BottomB, BottomBM, FullB, FullBM or NoBorder (default). TopBM=TopBorderMargin
   , borderColor      = "#1d1f21"
   , borderWidth      = 3

   -- layout
   , sepChar          =  "%"   -- delineator between plugin names and straight text
   , alignSep         = "}{"  -- separator between left-right alignment
   , lowerOnStart     = True    -- send to bottom of window stack on start
   , hideOnStart      = False   -- start with window unmapped (hidden)
   , allDesktops      = True    -- show on all desktops
   , overrideRedirect = True    -- If you're running xmobar in a tiling window manager, you might need to set this option to False so that it behaves as a docked application. In my conf works with True.
   , pickBroadest     = False   -- choose widest display (multi-monitor)
   , persistent       = True    -- enable/disable hiding (True = disabled)
   , commands =
        -- music monitor
        [Run MPD            [ "--template", "<fn=1>\xf58f</fn> <fc=#f92672><title></fc> - <fc=#66d9ef><artist></fc> |<flags>| <fc=#A6E22E> <remaining> </fc><statei>"
                             , "--" , "-P", "<fn=1>\xf04b</fn>"
                             , "-Z" ,       "<fn=1>\xf04c</fn>"
                             , "-S" ,       "<fn=1>\xf04d</fn>"
                             ] 10
        -- network activity monitor (dynamic interface resolution)
        , Run DynNetwork     [ "--template" , "<fc=#f9f9f2><fn=1>\xf019</fn></fc> <rx> <fc=#f9f9f2><fn=1>\xf093</fn></fc> <tx>"
                             , "--Low"      , "50000"       -- units: B/s
                             , "--High"     , "1000000"       -- units: B/s
                             , "--low"      , "#f9f9f2"
                             , "--normal"   , "#f9f9f2"
                             , "--high"     , "#A6E22E"
                             , "-S"         ,  "True"
                             ] 10
        --memory usage monitor
        , Run Memory         [ "--template" ,"<fn=1>\xf538</fn> Mem:<usedratio>%"
                             , "--Low"      , "19"        -- units: %
                             , "--High"     , "65"        -- units: %
                             , "--low"      , "#A6E22E"
                             , "--normal"   , "#f9f9f2"
                             , "--high"     , "#e03a3a"
                             ] 10

        -- Ram used number and percent
        , Run Cpu [
            "-t",
            "<fn=1>\xf108</fn> Cpu:<total>%",
            "-H",
            "50",
            "--high",
            "red"
            ] 20

       , Run Volume "default" "Master"
           [ "-t", "<status>", "--"
           , "--on", "<fc=#859900><fn=1>\xf028</fn> <volume>%</fc>"
           , "--onc", "#859900"
           , "--off", "<fc=#dc322f><fn=1>\xf026</fn> MUTE</fc>"
           , "--offc", "#dc322f"
           ] 1

          -- battery monitor
        , Run Battery
          [ "-t", "<acstatus>"
          , "-L", "20"
          , "-H", "85"
          , "-l", "#ff0000"
          , "-n", "#fd971f"
          , "-h", "#3ae03a"
          , "--" -- battery specific options
            -- discharging status
          , "-o","<left>% (<timeleft>) <watts>W"
            -- AC "on" status
          , "-O","<fn=1>\xf1e6</fn> <left>%"
            -- charged status
          , "-i","<fc=#3ae03a><fn=1>\xf0e7</fn></fc>"
          , "--off-icon-pattern", "<fn=1>\xf1e6</fn>"
          , "--on-icon-pattern", "<fn=1>\xf1e6</fn>"
          , "-H"   , "16"
          , "-L"   , "10"
          , "-p", "#3ae03a" -- positive power (battery charging)
          , "-h", "#e03a3a" -- power higher than the -H threshold
          , "-m", "#fd971f" -- power lower than the -H threshold
          , "-l", "#a6e22e" -- power lower than the -L threshold
          ] 10
          -- time and date indicator
        , Run Date           "<fn=1>\xf073</fn> %a<fc=#f9f9f2> %H:%M</fc> " "date" 10
        , Run Kbd            [("gb(mac)", "<fn=1>\xf11c</fn><fc=#f9f9f2> Gb</fc>")]
        , Run StdinReader   -- xmonad workspace : layout : title

        ]
   , template         = " %StdinReader% } { <action=`networkmanager_dmenu`>%dynnetwork%</action>  %cpu%  %memory%  %volume%  %kbd%  %battery%  %date%"
   }
