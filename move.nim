import sq, pieces, board, sequtils

type 
  Move* = ref object of RootObj
  NormalMove* = ref object of Move
    start*, destination*: Sq
    piece*: Piece
  CaptureMove* = ref object of NormalMove
    captured*: Piece
  Side* = enum
    Queenside, Kingside
  CastleMove* = ref object of Move
    side*: Side

  Ui* = ref object of RootObj
  Player* = ref object
    color*: Color
    ui*: Ui

  History* = seq[Move]
  GameState* = object
    board*: Board
    history*: History
    activePlayer*: Player
    opponent*: Player
    inCheck*: bool
  GameStateRef = ref GameState

proc isCheck*(color: Color, b: Board): bool =
  let kingSq = b.findPiece(King(color: color))
  kingSq.threatened(color, b)

# Complete the move info that cannot be inferred from the parsed string alone
proc fillIn(m: Move, state: GameState): Move =
  let b = state.board
  if m is NormalMove or m is CaptureMove:
    if NormalMove(m).start == sq(0, 0):
      discard

method execute(m: Move, state: GameState): Board {.base.} =
  quit "to override"

method undo(m: Move, state: GameState): Board {.base.} =
  quit "to override"

proc exec(m: Move, state: GameState): GameState =
  let move = m.fillIn(state)
  let newBoard = move.execute(state)
  GameState(
    board: newBoard,
    activePlayer: state.opponent,
    opponent: state.activePlayer,
    history: state.history.concat(@[move]),
    inCheck: state.opponent.color.isCheck(newBoard)
  )

method valid(m: Move, state: GameState): bool {.base.} =
  let newState = m.exec(state)
  let isCheck = newState.activePlayer.color.isCheck(newState.board)
  not isCheck

method valid(m: NormalMove, state: GameState): bool =
  m.piece.color == state.activePlayer.color and
    m.destination in m.piece.moves(m.start, state.board) and
    Move(m).valid(state)

method execute(m: NormalMove, state: GameState): Board =
  quit "Not implemented"

method valid(m: CaptureMove, state: GameState): bool =
  let b = state.board
  let captured = b.at(m.destination)
  m.piece.color == state.activePlayer.color and
    m.destination in m.piece.moves(m.start, b) and
    not captured.isNil and 
    b.at(m.destination).color == state.opponent.color and
    Move(m).valid(state)

proc hasMoved(originalSq: Sq, state: GameState) =
  quit "Not implemented"

method valid(m: CastleMove, state: GameState): bool =
  quit "Not implemented"
  
