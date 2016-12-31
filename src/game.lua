gamera = require("kit/lib/gamera")
math.randomseed(os.time())
game = {
  game_objects = { },
  map_stuff = {
    ["player"] = {
      r = 255,
      g = 0,
      b = 0
    },
    ["block"] = {
      r = 0,
      g = 0,
      b = 0
    }
  },
  grid_size = 16,
  level = 1,
  levels = {
    [1] = "whatsyourask"
  },
  level_map = { }
}
game.load = function()
  do
    game.game_objects = { }
    game.camera = gamera.new(0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    game.camera:setWindow(0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    game.camera:setScale(3)
    game.load_level("assets/levels/" .. tostring(game.levels[game.level]) .. ".png")
    return game
  end
end
game.update = function(dt)
  do
    local _list_0 = game.game_objects
    for _index_0 = 1, #_list_0 do
      local _continue_0 = false
      repeat
        local g = _list_0[_index_0]
        if g == nil then
          _continue_0 = true
          break
        end
        if g.update then
          g:update(dt)
        end
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    return game
  end
end
game.draw = function()
  do
    game.camera:draw(function()
      return game.draw_world()
    end)
    return game
  end
end
game.draw_world = function()
  do
    local _list_0 = game.game_objects
    for _index_0 = 1, #_list_0 do
      local _continue_0 = false
      repeat
        local g = _list_0[_index_0]
        if g == nil then
          _continue_0 = true
          break
        end
        if g.draw then
          g:draw()
        end
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    return game
  end
end
game.load_level = function(path)
  do
    local image = love.image.newImageData(path)
    for x = 1, image:getWidth() do
      local row = { }
      for y = 1, image:getHeight() do
        local rx, ry = x - 1, y - 1
        local r, g, b = image:getPixel(rx, ry)
        local ref = {
          id = -1
        }
        for k, v in pairs(game.map_stuff) do
          if r == v.r and g == v.g and b == v.b then
            ref = game.make_entity(k, game.grid_size * rx, game.grid_size * ry)
          end
        end
        row[y] = ref
      end
      game.level_map[x] = row
    end
    return game
  end
end
game.check_map = function(x, y, ox, oy)
  do
    return game.level_map[(ox / game.grid_size) + x][(oy / game.grid_size) + y].id == 1
  end
end
game.make_entity = function(id, x, y)
  local Player, Block
  do
    local _obj_0 = require("src/entities")
    Player, Block = _obj_0.Player, _obj_0.Block
  end
  local _exp_0 = id
  if "player" == _exp_0 then
    local player = Player(x, y)
    game.player = player
    table.insert(game.game_objects, player)
    return player
  elseif "block" == _exp_0 then
    local block = Block(x, y)
    table.insert(game.game_objects, block)
    return block
  end
end
love.keypressed = function(key)
  do
    local _list_0 = game.game_objects
    for _index_0 = 1, #_list_0 do
      local _continue_0 = false
      repeat
        local g = _list_0[_index_0]
        if g == nil then
          _continue_0 = true
          break
        end
        if g.press then
          g:press(key)
        end
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
    return game
  end
end
return game
