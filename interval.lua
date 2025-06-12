function Interval(min, max)
    local interval = {}
    interval.min = min
    interval.max = max
    interval.size = function () return interval.max - interval.min end
    interval.contains = function (x) return interval.min <= x and x <= interval.max end
    interval.surrounds = function(x) return interval.min < x and x < interval.max end 
    return interval
end

EMPTY = Interval(INFINITY, -INFINITY)
UNIVERSE = Interval(-INFINITY, INFINITY)