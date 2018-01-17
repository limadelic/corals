define game_of_life: {
  rules: [
    { when: 0, dead?: true },
    { when: 1, alive?: true },
    {
      given: { size: -> { Math.sqrt count } },
      x: -> { self / size },
      y: -> { self % size }
    },
    {
      given: {
        delta: -> (x, y) { (x - y) ** 2 },
        distance: -> (other) { [delta(x, other.x), delta(y, other.y)].max },
        is_neighbor?: -> (other) { distance(other) == 1 }
      },
      neighbors: -> { count is_neighbor? },
    },
    {
      given: {
        in_solitude?: -> { neighbors < 2 },
        overpopulated?: -> { neighbors > 3 },
        could_spawn?: -> { neighbors == 3 }
      },
      dead?: -> { alive? && (in_solitude? || overpopulated?) },
      alive?: -> { dead? && could_spawn? }
    }
  ]
}