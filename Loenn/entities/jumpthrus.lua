local drawableSpriteStruct = require("structs.drawable_sprite")
local drawing = require("utils.drawing")
local utils = require("utils")
local enums = require("consts.celeste_enums")
local entities = require("entities")

local jumpthru = {}

jumpthru.name = "JungleHelper/InvisibleJumpthruPlatform"
jumpthru.depth = -9000
jumpthru.canResize = {true, false}
jumpthru.fieldInformation = {
    surfaceIndex = {
        options = enums.tileset_sound_ids,
        fieldType = "integer"
    }
}
jumpthru.placements = {
    name = "jumpthru",
    data = {
        width = 8,
        surfaceIndex = -1
    }
}

function jumpthru.sprite(room, entity)
    local texture = "objects/jumpthru/JungleHelper/Invisible"

    local x, y = entity.x or 0, entity.y or 0
    local width = entity.width or 8

    local startX, startY = math.floor(x / 8) + 1, math.floor(y / 8) + 1
    local stopX = startX + math.floor(width / 8) - 1
    local len = stopX - startX

    local sprites = {}

    for i = 0, len do
        local quadX = 8
        local quadY = 8

        if i == 0 then
            quadX = 0
            quadY = room.tilesFg.matrix:get(startX - 1, startY, "0") ~= "0" and 0 or 8

        elseif i == len then
            quadY = room.tilesFg.matrix:get(stopX + 1, startY, "0") ~= "0" and 0 or 8
            quadX = 16
        end

        local sprite = drawableSpriteStruct.fromTexture(texture, entity)

        sprite:setJustification(0, 0)
        sprite:addPosition(i * 8, 0)
        sprite:useRelativeQuad(quadX, quadY, 8, 8)

        table.insert(sprites, sprite)
    end

    return sprites
end

function jumpthru.selection(room, entity)
    return utils.rectangle(entity.x, entity.y, entity.width, 8)
end

-- add custom variation of jumpthru
table.insert(entities.registeredEntities.jumpThru.placements, {
    name = "junglehelper_plank",
    associatedMods = {"JungleHelper"},
    data = {
        width = 8,
        texture = "JungleHelper/Plank"
    }
})

return jumpthru