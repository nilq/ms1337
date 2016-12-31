class
  new: (@x, @y) =>
    @act_x = @x
    @act_y = @y

    @acc = 10
    @id  = 1

  update: (dt) =>
    @act_x -= (@act_x - @x) * @acc * dt
    @act_y -= (@act_y - @y) * @acc * dt

    with game
      wx, wy, ww, wh = .camera\getWorld!

      .camera.x = math.lerp .camera.x, @act_x, dt * 2
      .camera.y = math.lerp .camera.y, @act_y, dt * 2

  draw: =>
    with love.graphics
      .setColor 255, 255, 255
      .rectangle "fill", @act_x, @act_y, 16, 16

  press: (key) =>
    with game
      dx, dy = 0, 0
      switch key
        when "up"
          dy -= .grid_size
        when "down"
          dy += .grid_size
        when "left"
          dx -= .grid_size
        when "right"
          dx += .grid_size

      unless .check_map dx / .grid_size, dy / .grid_size, @x, @y
        @x += dx
        @y += dy
