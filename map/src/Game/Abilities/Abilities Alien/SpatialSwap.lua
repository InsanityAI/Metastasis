if Debug then Debug.beginFile "Game/Abilities/Alien/SpatialSwap" end
OnInit.trig("SpatialSwap", function(require)
    ---@return boolean
    function Trig_SpatialSwap_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A03I'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_SpatialSwap_Func003Func002Func001Func001C()
        local a = GetUnitTypeId(GetEnumUnit()) ---@type integer
        if ((GetOwningPlayer(GetEnumUnit()) == Player(PLAYER_NEUTRAL_PASSIVE))) then
            return true
        end
        if GetUnitPointValue(GetEnumUnit()) == 37 then
            return true
        end
        if a == FourCC('h02A') or a == FourCC('h004') or a == FourCC('h00A') or a == FourCC('h006') or a == FourCC('h00Y') or a == FourCC('h000') then
            return true
        end
        if ((GetUnitAbilityLevelSwapped(FourCC('Avul'), GetEnumUnit()) ~= 0)) then
            return true
        end
        if ((IsUnitPausedBJ(GetEnumUnit()) == true)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_SpatialSwap_Func003Func002Func001C()
        if Trig_SpatialSwap_Func003Func002Func001Func001C() then
            return true
        end
        return false
    end

    function Trig_SpatialSwap_Func003Func002A()
        if (Trig_SpatialSwap_Func003Func002Func001C()) then
            GroupRemoveUnitSimple(GetEnumUnit(), udg_TempUnitGroup)
        else
            UnitAddAbilityBJ(FourCC('Avul'), GetEnumUnit())
            PauseUnitBJ(true, GetEnumUnit())
        end
    end

    function Trig_SpatialSwap_Func003Func016A()
        PauseUnitBJ(false, GetEnumUnit())
        UnitRemoveAbilityBJ(FourCC('Avul'), GetEnumUnit())
        udg_TempPoint3 = GetUnitLoc(GetEnumUnit())
        AddSpecialEffectLocBJ(udg_TempPoint3, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl")
        SFXThreadClean()
        RemoveLocation(udg_TempPoint3)
        SetUnitPositionLoc(GetEnumUnit(), udg_TempPoint)
        PanCameraToLocForPlayer(GetOwningPlayer(GetEnumUnit()), udg_TempPoint)
    end

    function SpatialSwap_Sort()
        if udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))] ~= GetEnumUnit() then
            GroupRemoveUnit(udg_TempUnitGroup, GetEnumUnit())
        end
        if IsUnitAliveBJ(GetEnumUnit()) ~= true then
            GroupRemoveUnit(udg_TempUnitGroup, GetEnumUnit())
        end
    end

    function Trig_SpatialSwap_Actions()
        local a ---@type location
        local b ---@type location
        local c ---@type group
        local d ---@type effect
        local e ---@type effect
        local sp       = GetSpellAbilityUnit() ---@type unit
        udg_TempPoint  = GetUnitLoc(sp)
        udg_TempPoint2 = GetSpellTargetLoc()

        if RectContainsLoc(gg_rct_Space, udg_TempPoint2) ~= true and RectContainsLoc(gg_rct_Timeout, udg_TempPoint2) ~= true then
            udg_TempUnitGroup = GetUnitsInRangeOfLocAll(200.00, udg_TempPoint2)
            ForGroup(udg_TempUnitGroup, SpatialSwap_Sort)
            ForGroupBJ(udg_TempUnitGroup, Trig_SpatialSwap_Func003Func002A)
            if CountUnitsInGroup(udg_TempUnitGroup) == 0 or RectContainsLoc(gg_rct_Timeout, udg_TempPoint2) or RectContainsLoc(gg_rct_Timeout, udg_TempPoint) then
                DisplayTextToPlayer(udg_Parasite, 0, 0, "|cffffcc00No players netted!|r")
                DestroyGroup(udg_TempUnitGroup)
                RemoveLocation(udg_TempPoint)
                RemoveLocation(udg_TempPoint2)
                return
            end
            PauseUnitBJ(true, sp)
            UnitAddAbilityBJ(FourCC('Avul'), sp)
            d = AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl")
            e = AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl")
            a = udg_TempPoint
            b = udg_TempPoint2
            c = udg_TempUnitGroup
            PolledWait(3.00)
            PauseUnitBJ(false, sp)
            UnitRemoveAbilityBJ(FourCC('Avul'), sp)
            udg_TempPoint = a
            udg_TempPoint2 = b
            udg_TempUnitGroup = c
            ForGroupBJ(udg_TempUnitGroup, Trig_SpatialSwap_Func003Func016A)
            DestroyEffectBJ(d)
            DestroyEffectBJ(e)
            udg_TempPoint3 = GetUnitLoc(sp)
            PanCameraToTimedLocForPlayer(GetOwningPlayer(sp), udg_TempPoint2, 0)
            SetUnitPositionLoc(sp, udg_TempPoint2)
            AddSpecialEffectLocBJ(udg_TempPoint3, "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl")
            SFXThreadClean()
            RemoveLocation(udg_TempPoint3)

            DestroyGroup(udg_TempUnitGroup)
        else
        end
        RemoveLocation(a)
        RemoveLocation(b)
    end

    --===========================================================================
    gg_trg_SpatialSwap = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_SpatialSwap, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_SpatialSwap, Condition(Trig_SpatialSwap_Conditions))
    TriggerAddAction(gg_trg_SpatialSwap, Trig_SpatialSwap_Actions)
end)
if Debug then Debug.endFile() end
