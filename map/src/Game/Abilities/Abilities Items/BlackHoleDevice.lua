if Debug then Debug.beginFile "Game/Abilities/Items/BlackHoleDevice" end
OnInit.map("BlackHoleDevice", function(require)
    ---@return boolean
    function Trig_BlackHoleDevice_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A05N'))) then
            return false
        end
        return true
    end

    function Trig_BlackHoleDevice_Actions()
        udg_TempPoint = GetSpellTargetLoc()
        SetSoundPositionLocBJ(gg_snd_NecropolisUpgrade1, udg_TempPoint, 0)
        PlaySoundBJ(gg_snd_NecropolisUpgrade1)
        CreateNUnitsAtLoc(1, FourCC('h02J'), GetOwningPlayer(GetSpellAbilityUnit()), udg_TempPoint, bj_UNIT_FACING)
        RemoveLocation(udg_TempPoint)
        udg_TempUnit = GetLastCreatedUnit()
        udg_CountUpBarColor = "|cff804000"
        BasicAI_IssueDangerArea(udg_TempPoint, 800.0, 3.1)
        CountUpBar(udg_TempUnit, 60, 0.1666666666667, "BlackHoleExplosion")
        KillUnit(gg_unit_h012_0217)
        DisplayTextToForce(GetPlayersAll(), "|cffFF0000Emergency News!")
        DisplayTextToForce(GetPlayersAll(),
            "|cffFF0000A delayed U.S.I. Weather Forecast reports that a black hole should soon be visible in the sector.")
        DisplayTextToForce(GetPlayersAll(),
            "|cffFF0000The metadata suggests it was broadcasted days ago and reached only now, so it must be accurate.")
    end

    --===========================================================================
    gg_trg_BlackHoleDevice = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_BlackHoleDevice, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_BlackHoleDevice, Condition(Trig_BlackHoleDevice_Conditions))
    TriggerAddAction(gg_trg_BlackHoleDevice, Trig_BlackHoleDevice_Actions)
end)
if Debug then Debug.endFile() end



--Conversion by vJass2Lua v0.A.2.3
