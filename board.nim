import tables, sq, options

type Piece* = ref object of RootObj
  color*: Color

type Board* = Table[Sq, Piece]

proc at*(b: Board, sq: Sq): Option[Piece] =
  if b.hasKey(sq): some(b[sq]) else: none(Piece)

proc at*(b: Board, x: int, y: int): Option[Piece] =
  let sq = Sq(x: x, y: y)
  b.at(sq)
