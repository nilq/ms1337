class
  new: (@x, @y) =>
    @act_x = @x
    @act_y = @y

    @acc = 10
    @id  = 1

  update: (dt) =>
    @act_x -= (@act_x - @x) * @acc * dt
    @act_y -= (@act_y - @y) * @acc * dt

  draw: =>
    with love.graphics
      .setColor 255, 255, 255
      .rectangle "fill", @act_x + 16, @act_y + 16, 16, 16
