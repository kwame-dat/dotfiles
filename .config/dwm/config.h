/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 15;        /* gaps between windows */
static const unsigned int snap      = 15;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]              = {"JetBrains Mono Medium:size=10",
                                        "JoyPixels:size=10:antialias=true:autohint=true",
                                        "FontAwesome:size=10:antialias=true:autohint=true",
                                        };
static const char dmenufont[]           = "JetBrains Mono Medium:size=10";
static const char col_gray1[]           = "#1a1a1a";
static const char col_gray2[]           = "#1a1a1a"; /* border color unfocused windows */
static const char col_gray3[]           = "#96b5B4";
static const char col_gray4[]           = "#d7d7d7";
static const char col_blue[]            = "#9765F4"; /* border color focused windows and tags */
static const char col_red[]             = "#8f3d3d"; /* tag background color */
static const char col_yellow[]          = "#b38c00"; /* border color */
static const unsigned int baralpha    = 0xff;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3]        = {
    /*               fg         bg         border   */
    [SchemeNorm] = { col_gray4, col_gray1, col_gray2 },
    [SchemeSel]  = { col_gray4, col_red, col_blue },
};
static const unsigned int alphas[][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static const char *tags[] = { "🌍", "", "🗨️", "🎦", "", "", "🎬️", "🎮", "🎧" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 *  use tags mask to point an application to a specific workspace
	 */
	/* class                           instance    title      tags         mask              monitor */
    { "qutebrowser",                 NULL,       NULL,      1,           0,                -1 },
    { "Google-chrome",               NULL,       NULL,      1,           0,                -1 },
    { "Chromium",                    NULL,       NULL,      1,           0,                -1 },
    { "Firefox",                     NULL,       NULL,      1,           0,                -1 },
    { "Brave-browser",               NULL,       NULL,      1,           0,                -1 },
    { "calibre",                     NULL,       NULL,      1,           0,                -1 },
    { "Emacs",                       NULL,       NULL,      2,           0,                -1 },
    { "jetbrains-phpstorm",          NULL,       NULL,      2,           0,                -1 },
    { "whatsdesk",                   NULL,       NULL,      1 << 2,      0,                -1 },
    { "Signal",                      NULL,       NULL,      1 << 2,      0,                -1 },
    { "Slack",                       NULL,       NULL,      1 << 2,      0,                -1 },
    { "Microsoft Teams - Preview",   NULL,       NULL,      1 << 3,      0,                -1 },
    { "zoom",                        NULL,       NULL,      1 << 3,      0,                -1 },
    { "Dbeaver",                     NULL,       NULL,      1 << 4,      0,                -1 },
    { "Insomnia",                    NULL,       NULL,      1 << 4,      0,                -1 },
    { "Postman",                     NULL,       NULL,      1 << 4,      0,                -1 },
    { "Nextcloud",                   NULL,       NULL,      1 << 8,      0,                -1 },
    { "Spotify",                     NULL,       NULL,      1 << 8,      0,                -1 },
};


/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

#include "horizgrid.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "|M|",      centeredmaster },
	{ "###",      horizgrid },
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#define CMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]    = { "dmenu_run", "-p", "Run: ", NULL };
static const char *filecmd[]  = { "thunar", NULL };
static const char *calendar[]  = { "gsimplecal", NULL };
static const char *bashtop[]  = { "xfce4-taskmanager", NULL };

#include "selfrestart.c"
#include "shiftview.c"

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = filecmd } },
	{ MODKEY|ShiftMask,             XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = -1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_Right,  focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_Left,   focusstack,     {.i = -1 } },	
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
	{ MODKEY,                       XK_grave,  view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,            			      XK_q,      killclient,     {0} },

  /* Layout manipulation */
  { MODKEY,               XK_Tab,        cyclelayout,    {.i = -1 } },
  { MODKEY|ShiftMask,     XK_Tab,        cyclelayout,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_f,      togglefullscr,  {0} },
	{ MODKEY,             XK_f,      togglefullscr,  {0} },

  /* Switching between monitors */
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },

    TAGKEYS(                  XK_1,          0)
    TAGKEYS(                  XK_2,          1)
    TAGKEYS(                  XK_3,          2)
    TAGKEYS(                  XK_4,          3)
    TAGKEYS(                  XK_5,          4)
    TAGKEYS(                  XK_6,          5)
    TAGKEYS(                  XK_7,          6)
    TAGKEYS(                  XK_8,          7)
    TAGKEYS(                  XK_9,          8)
    { MODKEY,			            XK_0,		       view,		{.ui = ~0 } },
    { MODKEY|ShiftMask,		    XK_0,		       tag,		  {.ui = ~0 } },
    { MODKEY|ShiftMask,       XK_r,          quit,            {1} }, 
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        spawn,          {.v = bashtop } },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = filecmd } },
	{ ClkStatusText,        0,              Button3,        spawn,          {.v = calendar } },	
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
