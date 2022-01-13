Utilities = {}

function Utilities:getUnitDirection(start, target)
    local direction = {}
    direction.x = target.x - start.x
    direction.y = target.y - start.y

    local magnitude = math.sqrt(math.pow(direction.x, 2) + math.pow(direction.y, 2))

    direction.x = direction.x / magnitude
    direction.y = direction.y / magnitude

    return direction
end

function Utilities:getDistance(start, target)
    return {x = math.abs(start.x - target.x), y = math.abs(start.y - target.y)}
end

function Utilities:deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[Utilities:deepcopy(orig_key, copies)] = Utilities:deepcopy(orig_value, copies)
            end
            setmetatable(copy, Utilities:deepcopy(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function Utilities:pointInRectangle(point, rectangle)
    if rectangle.left <= point.x and point.x <= rectangle.right and rectangle.top <= point.y and point.y <= rectangle.bottom then
        return true
    end
    return false
end

return Utilities