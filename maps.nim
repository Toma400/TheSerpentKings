import std/private/osdirs
import strutils
import tables
import parsetoml
import utils
import nico

type
  Tile = object
    id:       string
    image:    string
    traverse: float

proc `$`* (t: Tile): string =
  result = "Tile: " & t.id & " | Traverse speed: " & $t.traverse

proc listMaps* (): seq[string] =
  for v in walkDirRec("maps"):
    if endsWith(v, ".tmx"):
      add(result, v.multireplace([(r"maps\", ""), (".tmx", "")]))

proc listTiles* (): seq[Tile] =
  for v in walkDirRec("tiles"):
    if endsWith(v, ".toml"):
      var t = parseFile(v)
      add(result, Tile(id:       v.multireplace([(r"tiles\", ""), (".toml", ""), (r"\", ":")]),
                       image:    t["image"].getStr(),
                       traverse: t["traverse_speed"].getFloat()))

# registers Nico tiles and creates table with ID - number representation
proc registerTiles* (tiles_list: seq[Tile], tile_size: int): OrderedTable[string, (int, Tile)] =
  var tile_index = 0
  for tile in tiles_list:
    loadSpritesheet(tile_index, r"assets\" & tile.image, tile_size, tile_size)
    result[tile.id] = (tile_index, tile)
    tile_index += 1