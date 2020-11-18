defmodule ListTest do
  use ExUnit.Case, async: true

  import Corals.Resolver

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
    
    assert resolve(rules, opts).the_beatles == [
      %{name: "John", last_name: "Lennon", full_name: "John Lennon"},
      %{name: "Paul", last_name: "McCartney", full_name: "Paul McCartney"},
      %{name: "George", last_name: "Harrison", full_name: "George Harrison"},
      %{name: "Ringo", last_name: "Starr", full_name: "Ringo Starr"},
    ]
  end

end
