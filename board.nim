import tables, sq

type Piece* = ref object of RootObj
  color*: Color

type Board* = Table[Sq, Piece]

let EMPTY_BOARD*: Board = initTable[Sq, Piece]()

proc at*(b: Board, sq: Sq): Piece =
  if sq in b: b[sq] else: nil

proc at*(b: Board, x: int, y: int): Piece =
  let sq = Sq(x: x, y: y)
  b.at(sq)


