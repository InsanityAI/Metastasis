if Debug then Debug.beginFile "Game/Abilities/Suits/Physics" end
OnInit.map("Physics", function(require)
    ---@return boolean
    function Trig_Physics_Conditions()
        if (not (GetSpellAbilityId() == FourCC('A029'))) then
            return false
        end
        return true
    end

    function DestroyContainmentPens()
        if (GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('B000') and GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('B002') and GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('B004') and GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('B001')) and GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('Y216') and GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('Y240') and GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('Y230') and GetDestructableTypeId(GetEnumDestructable()) ~= FourCC('Y206') then
            KillDestructable(GetEnumDestructable())
        end
    end

    function Trig_Physics_Actions()
        local b        = GetSpellTargetUnit() ---@type unit

        udg_TempPoint  = GetUnitLoc(GetSpellAbilityUnit())
        udg_TempPoint2 = GetUnitLoc(GetSpellTargetUnit())

        ------------------------------------------
        udg_TempReal   = GetUnitX(GetSpellTargetUnit())
        udg_TempReal2  = GetUnitY(GetSpellTargetUnit())
        SetUnitX(GetSpellAbilityUnit(), udg_TempReal)
        SetUnitY(GetSpellAbilityUnit(), udg_TempReal2)

        udg_TempReal = GetLocationX(udg_TempPoint)
        udg_TempReal2 = GetLocationY(udg_TempPoint)
        SetUnitX(GetSpellTargetUnit(), udg_TempReal)
        SetUnitY(GetSpellTargetUnit(), udg_TempReal2)
        -------------------------------------------


        if TerrainLineCheck(udg_TempPoint, udg_TempPoint2, 30) == true then
            --call SetUnitPositionLoc( GetSpellTargetUnit(), udg_TempPoint )
            --call SetUnitPositionLoc( GetSpellAbilityUnit(), udg_TempPoint2 )
            AddSpecialEffectLocBJ(udg_TempPoint, "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
            SFXThreadClean()
            AddSpecialEffectLocBJ(udg_TempPoint2, "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl")
            SFXThreadClean()

            --Add invulnerability for 3.2 seconds, which is just enough to not get fbomb-cheesed.y
            UnitAddAbilityForPeriod(b, FourCC('Avul'), 3.2)

            --Destroys containment pens, so you can't trap someone with the power of annoying abuse.
            EnumDestructablesInCircleBJ(256, udg_TempPoint, DestroyContainmentPens)

            --Clean memory leaks.
            RemoveLocation(udg_TempPoint)
            RemoveLocation(udg_TempPoint2)
        end
    end

    --===========================================================================
    gg_trg_Physics = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Physics, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Physics, Condition(Trig_Physics_Conditions))
    TriggerAddAction(gg_trg_Physics, Trig_Physics_Actions)
end)
if Debug then Debug.endFile() end
