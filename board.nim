import tables, sq

type 
  Piece* = ref object of RootObj
    color*: Color
  Board* = TableRef[Sq, Piece]
  Pieces* = Board

let EMPTY_BOARD*: Board = newTable[Sq, Piece]()

proc at*(b: Board, sq: Sq): Piece =
  if sq in b: b[sq] else: nil

proc setAt*(b: Board, sq: Sq, p: Piece): Board =
  b[sq] = p
  b

proc at*(b: Board, x: int, y: int): Piece =
  let sq = Sq(x: x, y: y)
  b.at(sq)

proc only*(b: Board, color: Color): Pieces =
  for sq, p in b:
    if p.color == color:
      b[sq] = p
  
proc findPiece*(b: Board, piece: Piece): Sq =
  for sq, p in b.pairs:
    if p == piece:
      return sq
