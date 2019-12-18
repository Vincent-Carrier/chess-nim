import sq, move_parse, move, strformat, strings

type
  Cli* = ref object of Ui

method promptMove(ui: Ui, state: GameState): Move {.base.} = 
  quit "to override"

method promptMove(ui: Cli, state: GameState): Move =
  let color = if state.activePlayer.color == White: "White" else: "Black"
  echo &"{color}'s turn to play"
  echo state.board
  var str: string
  discard readLine(stdin, str)
  let move = parseMove(str)
  if not move.isNil:
    return move
  else:
    return promptMove(ui, state)
