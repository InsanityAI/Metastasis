if Debug then Debug.beginFile "Initialization/Sound" end
OnInit.final("Sound", function(require)
    function Trig_Sound_Func005A()
        SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER, 0)
    end

    -- Plays that one sound at the beginning and locks alliance settings.
    PlaySoundBJ(gg_snd_TempleOfTheDamnedWhat)
    SetMapFlag(MAP_LOCK_ALLIANCE_CHANGES, true)
    ForForce(GetPlayersAll(), Trig_Sound_Func005A)
end)
if Debug then Debug.endFile() end
