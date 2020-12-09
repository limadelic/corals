defmodule GoL.Glyphs do

  import Corals

  define __MODULE__, %{
    rules: [

      _glyphs: %{

        glider: [
          " ▊ ",
          "  ▊",
          "▊▊▊",
        ],

        diamond: [
          "      ▊▊▊▊      ",
          "                ",
          "    ▊▊▊▊▊▊▊▊    ",
          "                ",
          "  ▊▊▊▊▊▊▊▊▊▊▊▊  ",
          "                ",
          "    ▊▊▊▊▊▊▊▊    ",
          "                ",
          "      ▊▊▊▊      ",
        ],

        gosper_gun: [
          "                                      ",
          "                         ▊            ",
          "                       ▊ ▊            ",
          "             ▊▊      ▊▊            ▊▊ ",
          "            ▊   ▊    ▊▊            ▊▊ ",
          " ▊▊        ▊     ▊   ▊▊               ",
          " ▊▊        ▊   ▊ ▊▊    ▊ ▊            ",
          "           ▊     ▊       ▊            ",
          "            ▊   ▊                     ",
          "             ▊▊                       ",
          "                                      ",
        ]
      }
    ]
  }

end