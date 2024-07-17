if Debug then Debug.beginFile "Game/Abilities/Alien/ElectromagneticDistruption" end
OnInit.map("ElectromagneticDistruption", function(require)
    ---@return boolean
    function Trig_ElectromagneticDisruption_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A03Q'))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ElectromagneticDisruption_Func008Func001Func003Func003C()
        if (not (udg_TempInt3 ~= 1337)) then
            return false
        end
        if (not (GetRandomInt(1, 1) == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ElectromagneticDisruption_Func008Func001Func003C()
        if (not (udg_TempBool == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_ElectromagneticDisruption_Func008Func001Func005C()
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B001'))) then
            return true
        end
        if ((GetDestructableTypeId(GetEnumDestructable()) == FourCC('B000'))) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_ElectromagneticDisruption_Func008Func001C()
        if (not Trig_ElectromagneticDisruption_Func008Func001Func005C()) then
            return false
        end
        return true
    end

    function Trig_ElectromagneticDisruption_Func008A()
        if (Trig_ElectromagneticDisruption_Func008Func001C()) then
            udg_TempPoint2 = GetDestructableLoc(GetEnumDestructable())
            udg_TempBool = LocInSector(udg_TempPoint2, udg_TempInt)
            if (Trig_ElectromagneticDisruption_Func008Func001Func003C()) then
                udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t1"))
                udg_TempInt3 = LoadInteger(LS(), GetHandleId(udg_TempTrigger), StringHash("clearance"))
                if (Trig_ElectromagneticDisruption_Func008Func001Func003Func003C()) then
                    udg_TempInt2 = (udg_TempInt2 + 1)
                    udg_TempPoint3 = GetDestructableLoc(GetEnumDestructable())
                    SaveInteger(LS(), GetHandleId(udg_TempTrigger), StringHash("clearance"), 1337)
                    udg_TempTrigger = LoadTriggerHandle(LS(), GetHandleId(GetEnumDestructable()), StringHash("t2"))
                    udg_TempDoorHack = true
                    TriggerExecute(udg_TempTrigger)
                    udg_TempDoorHack = false
                    SaveInteger(LS(), GetHandleId(udg_TempTrigger), StringHash("clearance"), 1337)
                    DestructableRestoreLife(
                    LoadDestructableHandle(LS(), GetHandleId(udg_TempTrigger), StringHash("doorpath")), 999999, true)
                    AddSpecialEffectLocBJ(udg_TempPoint3, "Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl")
                    SFXThreadClean()
                    RemoveLocation(udg_TempPoint3)
                else
                end
            else
            end
            RemoveLocation(udg_TempPoint2)
        else
        end
    end

    ---@return boolean
    function Trig_ElectromagneticDisruption_Func010C()
        if (not (GetOwningPlayer(GetSpellAbilityUnit()) == Player(bj_PLAYER_NEUTRAL_EXTRA))) then
            return false
        end
        return true
    end

    function Trig_ElectromagneticDisruption_Actions()
        udg_TempPoint = GetUnitLoc(GetSpellAbilityUnit())
        AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\ManaFlare\\ManaFlareBoltImpact.mdl")
        SFXThreadClean()
        udg_TempInt = GetSector(udg_TempPoint)
        udg_TempInt2 = 0
        EnumDestructablesInRectAll(GetEntireMapRect(), Trig_ElectromagneticDisruption_Func008A)
        RemoveLocation(udg_TempPoint)
        if (Trig_ElectromagneticDisruption_Func010C()) then
            DisplayTextToPlayer(udg_Parasite, 0, 0, "|cffffcc00Locked " + I2S(udg_TempInt2) + " doors.")
        else
            DisplayTextToPlayer(GetOwningPlayer(GetSpellAbilityUnit()), 0, 0,
                "|cffffcc00Locked " + I2S(udg_TempInt2) + " doors.")
        end
        udg_TempUnitType = FourCC('e00O')
        udg_TempPlayer = GetOwningPlayer(GetSpellAbilityUnit())
        udg_TempReal = 60.00
        ExecuteFunc("AlienRequirementRemove")
        ExecuteFunc("AlienRequirementRestore")
    end

    --===========================================================================
    gg_trg_ElectromagneticDisruption = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_ElectromagneticDisruption, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_ElectromagneticDisruption, Condition(Trig_ElectromagneticDisruption_Conditions))
    TriggerAddAction(gg_trg_ElectromagneticDisruption, Trig_ElectromagneticDisruption_Actions)
end)
if Debug then Debug.endFile() end
