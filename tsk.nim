import nico
import maps

#[ === THE SERPENT KINGS ===
 idea: minimal strategy game, set in Baedoor universe
       and with economy focus
 scope:
    - 3 civilisations (Dyalnesi, 2nd human tribe, snakes)
]#
const
  auth  = "Toma400"
  gname = "The Serpent Kings"
  tile_size = 32

var
  map_list      = listMaps()
  tile_list     = listTiles()
  tile_registry = registerTiles(tile_list, tile_size)

proc gameStart() = discard
proc gameUpdate(dt: float32) = discard
proc gameDraw() =
  setSpritesheet(0) # use the tileset spritesheet
  setMap(0) # use the map we created
  mapDraw(0,0, 10,10, 0,0)

echo map_list
echo tile_list
echo tile_registry

newMap(0, 10, 10, tile_size, tile_size)
setMap(0) # tell nico to use map 0 we just created
for y in 0..<10:
  for x in 0..<10:
    mset(x, y, 0)

init(org=auth, app=gname)
nico.createWindow(title=gname, w=128, h=128, scale=4, fullscreen=false)
run(gameStart, gameUpdate, gameDraw)