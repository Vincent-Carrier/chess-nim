import ../pieces, ../strings, ../sq, strutils

when isMainModule:
  let actualMoves = Queen(color: White).moves(sq(4,4), INITIAL_BOARD)
  let expectedMovesString = """........
                               .X..X..X
                               ..X.X.X.
                               ...XXX..
                               XXXX.XXX
                               ...XXX..
                               ........
                               ........
                               """.unindent

  echo "Expected:\n", expectedMovesString
  echo "Actual:\n", actualMoves.toString
  doAssert actualMoves.toString == expectedMovesString
