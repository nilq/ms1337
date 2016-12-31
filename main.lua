math.sign = function(n)
  if n < 0 then
    return -1
  end
  if n > 0 then
    return 1
  end
  return 0
end
math.lerp = function(a, b, t)
  return (1 - t) * a + t * b
end
math.clamp = function(a, b, v)
  if v < a then
    return a
  end
  if v > b then
    return b
  end
  return v
end
return require("kit")
