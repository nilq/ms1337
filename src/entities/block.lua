do
  local _class_0
  local _base_0 = {
    update = function(self, dt)
      self.act_x = self.act_x - ((self.act_x - self.x) * self.acc * dt)
      self.act_y = self.act_y - ((self.act_y - self.y) * self.acc * dt)
    end,
    draw = function(self)
      do
        local _with_0 = love.graphics
        _with_0.setColor(255, 255, 255)
        _with_0.rectangle("fill", self.act_x, self.act_y, 16, 16)
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
