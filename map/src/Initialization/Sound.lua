if Debug then Debug.beginFile "Initialization/Sound" end
OnInit.map("Sound", function(require)
    function Trig_Sound_Func005A()
        SetPlayerStateBJ(GetEnumPlayer(), PLAYER_STATE_RESOURCE_LUMBER, 0)
    end

    function Trig_Sound_Actions()
        -- Plays that one sound at the beginning and locks alliance settings.
        PlaySoundBJ(gg_snd_TempleOfTheDamnedWhat)
        SetMapFlag(MAP_LOCK_ALLIANCE_CHANGES, true)
        ForForce(GetPlayersAll(), Trig_Sound_Func005A)
        DestroyTrigger(GetTriggeringTrigger())
    end

    --===========================================================================
    gg_trg_Sound = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_Sound, 0.00)
    TriggerAddAction(gg_trg_Sound, Trig_Sound_Actions)
end)
if Debug then Debug.endFile() end
