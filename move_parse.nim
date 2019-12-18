import sq, pegs, move, strformat, strutils, pieces


proc `$`(m: NormalMove): string = 
  let piece = if m.piece is Pawn: "" else: $m.piece.letter.toUpperAscii
  &"{piece}{m.start}-{m.destination}"

proc `$`(m: CastleMove): string =
  if m.side == Kingside: "O-O" else: "O-O-O"

let sqRegex = peg"[a-h][1-8]"
let verbosePawnMoveRegex = sequence(sqRegex, peg"\-", sqRegex)
let captureRegex = sequence(peg"x", sqRegex)
let pawnCaptureRegex = sequence(sqRegex, captureRegex)

let pieceRegex = peg"[RNBQK]"
let ambiguousNormalMoveRegex = sequence(pieceRegex, sqRegex)
let ambiguousCaptureRegex = sequence(pieceRegex, captureRegex)

proc parseMove*(str: string): Move =
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


when isMainModule:
  echo "O-O-O: ", CastleMove(parseMove("O-O-O"))
  echo "e2-e4: ", NormalMove(parseMove("e2-e4"))
