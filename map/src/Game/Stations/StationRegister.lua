if Debug then Debug.beginFile "StationRegister" end
OnInit.map("StationRegister", function(require)
    ---@param ... rect
    function StationRegister(...)
        local rects = table.pack(...)
        ForForce(GetPlayersAll(), function()
            for _, rect in ipairs(rects) do
                FogModifierStart(CreateFogModifierRect(GetEnumPlayer(), FOG_OF_WAR_VISIBLE, rect, true, false))
            end
        end)
    end
end)
if Debug then Debug.endFile() end
