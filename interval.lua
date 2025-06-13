function Interval(min, max)
    local interval = {}
    interval.min = min
    interval.max = max
    interval.size = function () return interval.max - interval.min end
    interval.contains = function (x) return interval.min <= x and x <= interval.max end
    interval.surrounds = function(x) return interval.min < x and x < interval.max end 
    interval.clamp = function (x) return math.max(math.min(x, interval.max),interval.min) end
    return interval
end

EMPTY = Interval(math.huge, -math.huge)
UNIVERSE = Interval(-math.huge, math.huge)