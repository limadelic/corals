defmodule ListTest do
  use ExUnit.Case, async: true

  import Corals.{Resolver}

  @the_beatles [
    %{name: "John", last_name: "Lennon"},
    %{name: "Paul", last_name: "McCartney"},
    %{name: "George", last_name: "Harrison"},
    %{name: "Ringo", last_name: "Starr"},
  ]

  test "list" do
    rules = [
      the_beatles: [
        full_name: fn %{name: name, last_name: last_name} -> "#{name} #{last_name}" end
      ]
    ]
    opts = %{the_beatles: @the_beatles}

    assert resolve(opts, rules).the_beatles |> Enum.map(&(&1.full_name)) ==
      ["John Lennon", "Paul McCartney", "George Harrison", "Ringo Starr"]
  end

  test "respect" do
    rules = [
      the_beatles: [
        name: "Winnie",
        last_name: "Pooh"
      ]
    ]
    user_opts = %{the_beatles: @the_beatles}

    assert resolve(%{}, rules, user_opts).the_beatles == @the_beatles
  end

  test "dissie" do
    rules = [
      the_beatles: [
        name!: fn
          %{name: "Ringo"} -> "Ringie"
          %{name: "George"} -> "Georgie"
          %{name: name} -> "#{name}ie"
        end
      ]
    ]
    user_opts = %{the_beatles: @the_beatles}

    assert resolve(%{}, rules, user_opts).the_beatles |> Enum.map(&(&1.name)) ==
      ["Johnie", "Paulie", "Georgie", "Ringie"]
  end

  @dominoes for x <- 0..9, y <- x..9, do: [x,y]

  test "using lists as values" do

    rules = [
      [
        dominoes: @dominoes,
        players: [
          %{name: :player},
          %{name: :right},
          %{name: :front},
          %{name: :left},
        ]
      ],
      [
        players: [
          dominoes: fn _, %{dominoes: dominoes} ->
            Enum.take dominoes, 10
          end
        ]
      ]
    ]

    assert Enum.all?(resolve(%{}, rules).players, &(length(&1.dominoes) == 10)) == true
  end

end
