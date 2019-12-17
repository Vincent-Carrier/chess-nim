import hashes

type Sq* = object
  x*, y*: int

proc sq*(x, y: int): Sq = Sq(x: x, y: y)

proc hash*(sq: Sq): Hash =
  Hash(sq.x + (sq.y * 992))

type Color* = enum White, Black

proc opposite*(self: Color): Color =
  if self == White: Black else: White

proc forward*(self: Color): int =
  if self == White: -1 else: 1

proc pawnRow*(self: Color): int =
  if self == White: 6 else: 1

proc homeRow*(self: Color): int =
  if self == White: 7 else: 0


when isMainModule:
  debugEcho "hash: ", sq(4,4).hash
  debugEcho "hash: ", sq(0,0).hash
  debugEcho "hash: ", sq(2,6).hash
