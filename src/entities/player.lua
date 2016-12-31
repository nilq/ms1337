do
  local _class_0
  local _base_0 = {
    update = function(self, dt)
      self.act_x = self.act_x - ((self.act_x - self.x) * self.acc * dt)
      self.act_y = self.act_y - ((self.act_y - self.y) * self.acc * dt)
      do
        local _with_0 = game
        local wx, wy, ww, wh = _with_0.camera:getWorld()
        _with_0.camera.x = math.lerp(_with_0.camera.x, self.act_x, dt * 2)
        _with_0.camera.y = math.lerp(_with_0.camera.y, self.act_y, dt * 2)
        return _with_0
      end
    end,
    draw = function(self)
      do
        local _with_0 = love.graphics
        _with_0.setColor(255, 255, 255)
        _with_0.rectangle("fill", self.act_x, self.act_y, 16, 16)
        _with_0.setColor(255, 0, 0)
        _with_0.print(tostring(self.x / game.grid_size) .. ", " .. tostring(self.y / game.grid_size), self.x, self.y)
        return _with_0
      end
    end,
    press = function(self, key)
      do
        local _with_0 = game
        local dx, dy = 0, 0
        local _exp_0 = key
        if "up" == _exp_0 then
          dy = dy - _with_0.grid_size
        elseif "down" == _exp_0 then
          dy = dy + _with_0.grid_size
        elseif "left" == _exp_0 then
          dx = dx - _with_0.grid_size
        elseif "right" == _exp_0 then
          dx = dx + _with_0.grid_size
        end
        if not (_with_0.check_map(dx / _with_0.grid_size, dy / _with_0.grid_size, self.x, self.y)) then
          self.x = self.x + dx
          self.y = self.y + dy
        end
        return _with_0
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y)
      self.x, self.y = x, y
      self.act_x = self.x
      self.act_y = self.y
      self.acc = 10
      self.id = 1
    end,
    __base = _base_0,
    __name = nil
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  return _class_0
end
