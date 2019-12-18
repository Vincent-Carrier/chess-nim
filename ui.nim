import move, player

method promptMove(ui: Ui, state: GameState): Move {.base.} = 
  quit "to override"

