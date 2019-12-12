import pieces, board, strutils, sq, options, tables

proc newBoard*(str: string): Board = 
  var pieces: seq[(Sq, Piece)]
  for y, line in pairs(str.splitLines):
    for x, c in line.pairs:
      let color = if c.isUpperAscii: White else: Black
      var piece: Piece
      case c.toLowerAscii:
      of 'p': piece = Pawn(color: color)
      of 'n': piece = Knight(color: color)
      of 'b': piece = Pawn(color: color)
      of 'r': piece = Pawn(color: color)
      of 'q': piece = Pawn(color: color)
      of 'k': piece = Pawn(color: color)
      else: discard c
      pieces.add((sq(x, y), piece))
  pieces.toTable

proc toString*(b: Board): string =
  for y in 0..7:
    for x in 0..7:
      let sqContent = b.at(x, y)
      if sqContent.isSome: result.add(sqContent.get.letter)
      else: result.add('.')
    result.add('\n')

proc toString*(moves: seq[Sq]): string =
  for y in 0..7:
    for x in 0..7:
      if sq(x,y) in moves: result.add('X')
      else: result.add('.')
    result.add('\n')

const INITIAL_BOARD_STR = """rnbqkbnr
                             pppppppp
                             ........
                             ........
                             ........
                             ........
                             PPPPPPPP
                             RNBQKBNR""".unindent

let INITIAL_BOARD* = newBoard(INITIAL_BOARD_STR)