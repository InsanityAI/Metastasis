if Debug then Debug.beginFile "Game/Spaceships/SSGenDeath" end
OnInit.trig("SSGenDeath", function(require)
    ---@return boolean
    function Trig_SSGenDeath_Conditions()
        if (not (GetDyingUnit() ~= gg_unit_h04E_0259)) then
            return false
        end
        if (not (GetDyingUnit() ~= gg_unit_h04V_0253)) then
            return false
        end
        return true
    end

    function Trig_SSGenDeath_Func016A()
        UnitAddAbilityBJ(FourCC('A02T'), GetEnumUnit())
        UnitRemoveBuffsBJ(bj_REMOVEBUFFS_ALL, GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('A04T'), GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('A04U'), GetEnumUnit())
        MoogleKillUnit(GetEnumUnit(), udg_TempUnit2)
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            RemoveItem(UnitItemInSlotBJ(GetEnumUnit(), GetForLoopIndexA()))
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
    end

    function Trig_SSGenDeath_Func018A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED,
            udg_Spaceship_Rect[GetUnitUserData(udg_TempUnit)])
    end

    function Trig_SSGenDeath_Actions()
        local a = GetDyingUnit() ---@type unit
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_4368")
        udg_TempUnit2 = GetKillingUnitBJ()
        udg_TempUnit = GetDyingUnit()
        PlaySoundBJ(gg_snd_CreepAggroWhat1)
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 5
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            CreateNUnitsAtLoc(1, FourCC('e001'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
            udg_TempPoint = GetRandomLocInRect(udg_Spaceship_Rect[GetUnitUserData(udg_TempUnit)])
            SetUnitAnimation(GetLastCreatedUnit(), "death")
            CreateNUnitsAtLoc(1, FourCC('e002'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, GetRandomDirectionDeg())
            RemoveLocation(udg_TempPoint)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        udg_TempUnit = a
        DestroyTrigger(udg_Spaceship_Death[GetUnitUserData(udg_TempUnit)])
        DestroyTrigger(udg_Spaceship_ControlTrig[GetUnitUserData(udg_TempUnit)])
        DestroyTrigger(udg_Spaceship_EnterTrig[GetUnitUserData(udg_TempUnit)])
        DestroyTrigger(udg_Spaceship_ExitTrig[GetUnitUserData(udg_TempUnit)])
        DestroyTrigger(udg_Spaceship_ControlLossTrig[GetUnitUserData(udg_TempUnit)])
        SetUnitTimeScalePercent(udg_SS_Landed[GetUnitUserData(udg_TempUnit)], 100)
        ForGroupBJ(GetUnitsInRectAll(udg_Spaceship_Rect[GetUnitUserData(udg_TempUnit)]), Trig_SSGenDeath_Func016A)
        udg_TempUnit = a
        ForForce(GetPlayersAll(), Trig_SSGenDeath_Func018A)
        RectOfDoom(udg_Spaceship_Rect[GetUnitAN(udg_TempUnit)])
    end

    --===========================================================================
    gg_trg_SSGenDeath = CreateTrigger()
    TriggerAddCondition(gg_trg_SSGenDeath, Condition(Trig_SSGenDeath_Conditions))
    TriggerAddAction(gg_trg_SSGenDeath, Trig_SSGenDeath_Actions)
end)
if Debug then Debug.endFile() end
