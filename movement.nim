import sq, board

type Vec* = Sq

proc `+`(sq: Sq, vec: Vec): Sq = Sq(x: sq.x + vec.x, y: sq.y + vec.y)

proc `*`(sq: Sq, n: int): Sq = Sq(x: sq.x * n, y: sq.y * n)

proc rotated(vec: Vec): Vec = Vec(x: -vec.y, y: vec.x)

proc insideBoard(sq: Sq): bool = 0 <= sq.x and sq.x < 8 and
                                 0 <= sq.y and sq.y < 8

proc fourDirections*(vec: Vec): seq[Vec] =
  result.add(vec)
  for i in 1..3:
    result.add(result[i-1].rotated)

proc slide*(depart: Sq, towards: Vec, color: Color, board: Board,
            max: int = 8, canCapture = true): seq[Sq] =
  for i in 1..max:
    let candidate = depart + (towards * i)
    if not candidate.insideBoard:
      return
    let sqContent = board.at(candidate)
    if not sqContent.isNil:
      if sqContent.color != color:
        result.add(candidate)
      return
    else:
      result.add(candidate)


when isMainModule:
  let diagonal = sq(4,4).slide(sq(1,1), White, EMPTY_BOARD)
  echo "diagonal: ", diagonal
  echo "four directions: ", fourDirections(Vec(x: 1, y: 1))

