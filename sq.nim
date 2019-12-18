import hashes

type Sq* = object
  x*, y*: int

proc sq*(x, y: int): Sq = Sq(x: x, y: y)

proc sq*(str: string): Sq = 
  Sq(x: str[0].ord - 97, y: 56 - str[1].ord)

proc `$`*(sq: Sq): string =
  chr(sq.x + 97) & $(8 - sq.y)

proc hash*(sq: Sq): Hash =
  Hash(sq.x + (sq.y * 31))


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
  echo "sq(a4) - (0, 4): ", sq("a4") 
  echo "sq(h8) - (7, 0): ", sq("h8") 
  echo "sq(e4) - (4, 4): ", sq("e4") 

