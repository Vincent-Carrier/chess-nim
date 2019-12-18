import pieces, board, sq, strutils, tables

proc `$`*(p: Piece): string = $p.letter

proc toString*(b: Board): string =
  for y in 0..7:
    for x in 0..7:
      let sqContent = b.at(x, y)
      if not sqContent.isNil: 
        if sqContent.color == White:
          result.add(sqContent.letter.toUpperAscii)
        else: 
          result.add(sqContent.letter)
      else: 
        result.add('.')
    result.add('\n')

proc `$`*(b: Board): string = b.toString

proc toString*(moves: seq[Sq]): string =
  for y in 0..7:
    for x in 0..7:
      if sq(x,y) in moves: result.add('X')
      else: result.add('.')
    result.add('\n')

proc `$`*(moves: seq[Sq]): string = moves.toString

proc newBoard*(str: string): Board =
  var pieces: seq[(Sq, Piece)]
  for y, line in pairs(str.splitLines):
    for x, c in line.pairs:
      let color = if c.isUpperAscii: White else: Black
      var piece: Piece
      case c.toLowerAscii:
      of 'p': piece = Pawn(color: color)
      of 'n': piece = Knight(color: color)
      of 'b': piece = Bishop(color: color)
      of 'r': piece = Rook(color: color)
      of 'q': piece = Queen(color: color)
      of 'k': piece = King(color: color)
      else: discard
      pieces.add((sq(x, y), piece))
  return pieces.toTable

const INITIAL_BOARD_STR = """rnbqkbnr
                             pppppppp
                             ........
                             ........
                             ........
                             ........
                             PPPPPPPP
                             RNBQKBNR""".unindent

let INITIAL_BOARD* = newBoard(INITIAL_BOARD_STR)


when isMainModule:
  echo "INITIAL_BOARD:\n", INITIAL_BOARD.toString
