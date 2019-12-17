import sq, movement, board, sequtils

method moves*(p: Piece, sq: Sq, b: Board): seq[Sq] {.base.} =
  quit "to override"

method letter*(p: Piece): char {.base.} =
  quit "to override"


type Pawn* = ref object of Piece

method letter*(p: Pawn): char = 'p'

method moves*(p: Pawn, sq: Sq, b: Board): seq[Sq] =
  let dist = if sq.y == p.color.pawnRow: 2 else: 1
  let forward = Vec(x: 0, y: p.color.forward)
  let forwardMoves = sq.slide(forward, p.color, b, dist, false)
  result.add(forwardMoves)
  let diagonals = @[Vec(x: 1, y: p.color.forward),
                    Vec(x: -1, y: p.color.forward)]
  for vec in diagonals:
    result.add(sq.slide(vec, p.color, b, 1))


type Knight* = ref object of Piece

method letter*(p: Knight): char = 'n'

let L_SHAPE = fourDirections(Vec(x: 1, y: 2))
let INVERTED_L_SHAPE = fourDirections(Vec(x: 2, y: 1))
let L_SHAPES = concat(L_SHAPE, INVERTED_L_SHAPE)

method moves*(p: Knight, sq: Sq, b: Board): seq[Sq] =
  for vec in L_SHAPES:
    result.add(sq.slide(vec, p.color, b, 1))


type Bishop* = ref object of Piece

method letter*(p: Bishop): char = 'b'

let DIAGONALS = fourDirections(Vec(x: 1, y: 1))

method moves*(p: Bishop, sq: Sq, b: Board): seq[Sq] =
  for vec in DIAGONALS:
    result.add(sq.slide(vec, p.color, b))
    echo result


type Rook* = ref object of Piece

method letter*(p: Rook): char = 'r'

let STRAIGHT_LINES = fourDirections(Vec(x: 0, y: 1))

method moves*(p: Rook, sq: Sq, b: Board): seq[Sq] =
  for vec in STRAIGHT_LINES:
    result.add(sq.slide(vec, p.color, b))


type Queen* = ref object of Piece

method letter*(p: Queen): char = 'q'

let ALL_DIRECTIONS = concat(DIAGONALS, STRAIGHT_LINES)

method moves*(p: Queen, sq: Sq, b: Board): seq[Sq] =
  for vec in ALL_DIRECTIONS:
    result.add(sq.slide(vec, p.color, b))


type King* = ref object of Piece

method letter*(p: King): char = 'k'

method moves*(p: King, sq: Sq, b: Board): seq[Sq] =
  for vec in ALL_DIRECTIONS:
    result.add(sq.slide(vec, p.color, b, 1))
