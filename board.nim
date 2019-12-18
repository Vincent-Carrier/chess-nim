import tables, sq

type 
  Piece* = ref object of RootObj
    color*: Color
  Board* = Table[Sq, Piece]
  Pieces* = Board

let EMPTY_BOARD*: Board = initTable[Sq, Piece]()

proc at*(b: Board, sq: Sq): Piece =
  if sq in b: b[sq] else: nil

proc at*(b: Board, x: int, y: int): Piece =
  let sq = Sq(x: x, y: y)
  b.at(sq)

proc only*(b: Board, color: Color): Pieces =
  var list: seq[(Sq, Piece)]
  for sq, p in b:
    if p.color == color:
      list.add((sq, p))
  list.toTable
  
