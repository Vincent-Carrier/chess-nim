import sq, pieces, board, pegs, strformat, player, strutils

type 
  Move* = ref object of RootObj
  NormalMove* = ref object of Move
    start, destination: Sq
    piece: Piece
  CaptureMove* = ref object of NormalMove
    captured: Piece
  Side* = enum
    Queenside, Kingside
  CastleMove* = ref object of Move
    side: Side

  History* = seq[Move]
  GameState* = object
    board*: Board
    history*: History
    activePlayer*: Player
    opponent*: Player
    inCheck*: bool


method execute(m: Move, state: GameState): GameState {.base.} =
  quit "to override"

method valid(m: Move, state: GameState): bool {.base.} =
  quit "to override"


proc `$`(m: NormalMove): string = 
  let piece = if m.piece is Pawn: "" else: $m.piece.letter.toUpperAscii
  &"{piece}{m.start}-{m.destination}"

method valid(m: NormalMove, state: GameState): bool =
  m.piece.color == state.activePlayer.color and
  m.destination in m.piece.moves(m.start, state.board) and
  Move(m).valid(state)



proc `$`(m: CastleMove): string =
  if m.side == Kingside: "O-O" else: "O-O-O"

let sqRegex = peg"[a-h][1-8]"
let verbosePawnMoveRegex = sequence(sqRegex, peg"\-", sqRegex)
let captureRegex = sequence(peg"x", sqRegex)
let pawnCaptureRegex = sequence(sqRegex, captureRegex)

let pieceRegex = peg"[RNBQK]"
let ambiguousNormalMoveRegex = sequence(pieceRegex, sqRegex)
let ambiguousCaptureRegex = sequence(pieceRegex, captureRegex)

proc parseMove(str: string): Move =
  if str == "O-O-O":
    return CastleMove(side: Queenside)
  if str == "O-O":
    return CastleMove(side: Kingside)
  if str =~ verbosePawnMoveRegex:
    return NormalMove(start: sq(str[0..1]), destination: sq(str[3..4]))
  if str =~ pawnCaptureRegex:
    return CaptureMove(start: sq(str[0..1]), destination: sq(str[3..4]))
  if str =~ ambiguousNormalMoveRegex:
    return NormalMove(destination: sq(str[1..2]))
  if str =~ ambiguousCaptureRegex:
    return CaptureMove(destination: sq(str[1..2]))
  if str =~ sqRegex: return NormalMove(destination: sq(str[0..1]))

proc fillIn(m: Move, state: GameState): Move =
  let b = state.board
  if m is NormalMove or m is CaptureMove:
    if NormalMove(m).start == sq(0, 0):
      discard


when isMainModule:
  echo "O-O-O: ", CastleMove(parseMove("O-O-O"))
  echo "e2-e4: ", NormalMove(parseMove("e2-e4"))
