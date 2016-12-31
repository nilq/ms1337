local path = "src/entities/"
local Player = require(path .. "player")
local Block = require(path .. "block")
return {
  Player = Player,
  Block = Block
}
