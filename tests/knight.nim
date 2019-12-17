import ../pieces, ../strings, ../sq, strutils

when isMainModule:
  let actualMoves = Knight(color: White).moves(sq(4,4), INITIAL_BOARD)
  let expectedMovesString = """........
                               ........
                               ...X.X..
                               ..X...X.
                               ........
                               ..X...X.
                               ........
                               ........
                               """.unindent

  echo "Expected:\n", expectedMovesString
  echo "Actual:\n", actualMoves.toString
  doAssert actualMoves.toString == expectedMovesString
