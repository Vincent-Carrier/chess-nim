import sq, strings, move, cli

type Game = ref object
  state: GameState


proc newGame(): Game =
  Game(
    state: GameState(
      board: INITIAL_BOARD,
      activePlayer: Player(color: White, ui: Cli()),
      opponent: Player(color: White, ui: Cli()),
    )
  )

proc start(g: Game) =
  let ui = g.activePlayer.ui
  while true:
    let move = ui.promptMove(g.state)
    if not move.valid: 
      ui.displayMoveError
      continue
    g.state = move.execute(g.state)


when isMainModule:
  let game = newGame()
  game.start()
