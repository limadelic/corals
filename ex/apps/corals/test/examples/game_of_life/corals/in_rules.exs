defmodule GoL.In do

  import Corals
  import Enum, only: [map: 2, find: 2]
  import List, only: [flatten: 1]
  import String, only: [pad_trailing: 2]

  define __MODULE__, %{
    require: [GoL.Glyphs],
    rules: [
      [
        when: is?(%{cells: glyph} when is_atom glyph),
        cells: fn %{cells: glyph, _glyphs: glyphs} -> glyphs[glyph] end
      ],
      [
        when: is?(%{size: _}),
        cells: fn %{cells: cells, size: [width, _]} -> cells |> map(&(pad_trailing &1, width)) end,
        when: is?(%{cells: cells, size: [_, height]} when length(cells) < height),
        cells: fn %{cells: cells, size: [width, height]} ->
          cells ++ (for _ <- 1..height - length(cells), do: pad_trailing "", width)
        end,
      ],
      [
        when: not?(size: _),
        size: fn %{cells: [head | _] = cells} -> [String.length(head), length(cells)] end,
      ],
      [
        cells: fn %{cells: cells} -> cells |> map(&to_charlist/1) |> flatten end,
        _char: fn %{cells: cells} -> find cells, &(&1 not in ' ') end,
        cells: fn %{cells: cells} -> cells |> map(fn x when x in ' ' -> 0; _ -> 1 end) end
      ]
    ]
  }

end