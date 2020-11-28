//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
  /*Icon*/    /*Command*/         /*Update Interval*/    /*Update Signal*/
  /* {"", "music",                2,                    2}, */
  /* {"", "upt",                  60,                   2}, */
  /* {"", "cpu2",                 2,                    1}, */
  /* {"", "disk /home",           60,                   1}, */
  /* { "", "weather",              300,                  2}, */
  { "📦 ", "pacupdate",        36000,                 1},
  { "", "bandwidth",            2,                    1},
  { "🖥 ", "cpu2",                 10,                   1},
  { "🧠 ", "memory",               6,                    1},
  { "🌡", "cpu",                  10,                   1},
  { "", "volume2",              1,                    0},
  { "🔆 ", "brightness",           1,                    1},
  { "", "battery",              5,                    12},
  { "🗓 ", "clock",      1,                    0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = ' ';
