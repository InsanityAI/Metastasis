if Debug then Debug.beginFile "Game/Stations/Space" end
OnInit.map("Space", function(require)
    require "StationRegister"

    ForForce(GetPlayersAll(), function()
        local spaceVision = CreateFogModifierRect(GetEnumPlayer(), FOG_OF_WAR_VISIBLE, gg_rct_Space, true, false)
        FogModifierStart(spaceVision)
        udg_SpaceVisibility[GetConvertedPlayerId(GetEnumPlayer())] = spaceVision
    end)
end)
if Debug then Debug.endFile() end
