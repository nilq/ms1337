export gamera = require "kit/lib/gamera"

math.randomseed os.time!

export game = {
  game_objects: {}
  ----------------------------------
  -- level loading *hash-map*
  ----------------------------------
  map_stuff: {
    "player": {r: 255, g: 0,   b: 0}
    "block":  {r: 0,   g: 0,   b: 0}
  }
  ----------------------------------
  -- grid parameters
  ----------------------------------
  grid_size: 16
  ----------------------------------
  -- levels
  ----------------------------------
  level: 1
  levels: {
    [1]: "whatsyourask"
  }
  level_map: {}
}

game.load = ->
  with game
    .game_objects = {}
    .camera = gamera.new 0, 0, love.graphics.getWidth!, love.graphics.getHeight!
    .camera\setWindow 0, 0, love.graphics.getWidth!, love.graphics.getHeight!
    .camera\setScale 3

    .load_level "assets/levels/#{.levels[.level]}.png"

game.update = (dt) ->
  with game
    for g in *.game_objects
      continue if g == nil
      g\update dt if g.update

game.draw = ->
  with game
    .camera\draw ->
      .draw_world!

game.draw_world = ->
  with game
    for g in *.game_objects
      continue if g == nil
      g\draw! if g.draw

game.load_level = (path) ->
  with game
    image = love.image.newImageData path

    for x = 1, image\getWidth!
      row = {}
      for y = 1, image\getHeight!

        rx, ry = x - 1, y - 1
        r, g, b = image\getPixel rx, ry

        ref = {
          id: -1
        }

        for k, v in pairs .map_stuff
          if r == v.r and g == v.g and b == v.b
            ref = .make_entity k, .grid_size * rx, .grid_size * ry

        row[y] = ref

      .level_map[x] = row

game.check_map = (x, y, ox, oy) ->
  with game
    return .level_map[(ox / .grid_size) + x][(oy / .grid_size) + y].id == 1

game.make_entity = (id, x, y) ->
  import Player, Block from require "src/entities"

  switch id
    when "player"
      player = Player x, y
      ----------------------------------
      -- do things with player here ...
      ----------------------------------
      game.player = player
      table.insert game.game_objects, player

      return player

    when "block"
      block = Block x, y
      table.insert game.game_objects, block

      return block

love.keypressed = (key) ->
  with game
    for g in *.game_objects
      continue if g == nil
      g\press key if g.press

game
