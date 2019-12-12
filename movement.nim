import sq, board, sequtils, options

type Vec* = Sq

proc `+`(sq: Sq, vec: Vec): Sq = Sq(x: sq.x + vec.x, y: sq.y + sq.x)

proc `*`(sq: Sq, n: int): Sq = Sq(x: sq.x * n, y: sq.y * n)

proc rotated(vec: Vec): Vec = Vec(x: -vec.y, y: vec.x)

proc insideBoard(sq: Sq): bool = 0 <= sq.x and sq.x < 8 and
                                 0 <= sq.y and sq.y < 8

proc fourDirections*(vec: Vec): seq[Vec] =
  result[0] = vec
  for i, _ in result:
    if i > 0: result[i] = result[i-1].rotated

proc slide*(sq: Sq, towards: Vec, color: Color, board: Board,
           max: int = 8, canCapture = true): seq[Sq] =
  for i in 1..max:
    let candidate = sq + (towards * i)
    if not sq.insideBoard:
      return result
    let sqContent = board.at(candidate)
    if sqContent.isSome:
      if sqContent.get.color != board.at(sq).get.color:
        result.add(candidate)
      return result
    else:
      result.add(candidate)


