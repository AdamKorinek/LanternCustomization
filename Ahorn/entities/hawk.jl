module JungleHelperHawk

using ..Ahorn, Maple

@mapdef Entity "JungleHelper/Hawk" Hawk(x::Integer, y::Integer, mainSpeed::Number=100.0, slowerSpeed::Number=80.0, sprite::String="")

const placements = Ahorn.PlacementDict(
    "Hawk (Jungle Helper)" => Ahorn.EntityPlacement(
        Hawk,
        "rectangle",
        Dict{String, Any}(
            "mainSpeed" => 100,
            "slowerSpeed" => 80
        )

    )
)


sprite = "objects/hawk/hold03"

function Ahorn.selection(entity::Hawk)
    x, y = Ahorn.position(entity)

    res = Ahorn.Rectangle[Ahorn.getSpriteRectangle(sprite, x, y)]
    return res
end

function Ahorn.renderSelectedAbs(ctx::Ahorn.Cairo.CairoContext, entity::Hawk)
    px, py = Ahorn.position(entity)
end

function Ahorn.renderAbs(ctx::Ahorn.Cairo.CairoContext, entity::Hawk, room::Maple.Room)
    x, y = Ahorn.position(entity)
    Ahorn.drawSprite(ctx, sprite, x, y)
end

end