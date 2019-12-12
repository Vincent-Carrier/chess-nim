import hashes

type Sq* = object
  x*: int
  y*: int

proc sq*(x: int, y: int): Sq = Sq(x: x, y: y)

proc hash*(sq: Sq): Hash =
  result = !$(sq.x !& sq.y)

type Color* = enum White, Black

proc opposite*(self: Color): Color = 
  if self == White: Black else: White

proc forward*(self: Color): int = 
  if self == White: -1 else: 1

proc pawnRow*(self: Color): int = 
  if self == White: 6 else: 1

proc homeRow*(self: Color): int = 
  if self == White: 7 else: 0