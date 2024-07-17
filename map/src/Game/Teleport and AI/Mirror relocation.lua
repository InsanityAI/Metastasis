if Debug then Debug.beginFile "Game/TeleportAndAI/MirrorRelocation" end
OnInit.map("MirrorRelocation", function(require)
    ---@return boolean
    function Trig_Mirror_relocation_Conditions()
        if (not (RectContainsUnit(gg_rct_Mirror_Arena, GetTriggerUnit()) == true)) then
            return false
        end
        if (not (IsUnitGroupDeadBJ(udg_Mirror_KillExitGroup) == true)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Mirror_relocation_Func007Func001C()
        if (not (GetUnitTypeId(GetEnumUnit()) == FourCC('H03I'))) then
            return false
        end
        return true
    end

    function Trig_Mirror_relocation_Func007A()
        if (Trig_Mirror_relocation_Func007Func001C()) then
            DisplayTextToPlayer(GetOwningPlayer(GetEnumUnit()), 0, 0,
                "|CFF7EBFF1\n\nAlternative Dimension shattered!\n\nOriginal Dimension recovered.")
        else
            SetUnitPositionLoc(GetEnumUnit(), udg_TeleportBombMirrorExitPoint)
        end
    end

    function Trig_Mirror_relocation_Func008A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_Mirror_Arena)
    end

    function Trig_Mirror_relocation_Func009A()
        RemoveItem(GetEnumItem())
    end

    function Trig_Mirror_relocation_Actions()
        udg_Mirror_Enabled = false
        RemoveLocation(udg_TempPoint2)
        udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Mirror_Arena)
        ForGroupBJ(udg_TempUnitGroup, Trig_Mirror_relocation_Func007A)
        ForForce(GetPlayersAll(), Trig_Mirror_relocation_Func008A)
        EnumItemsInRectBJ(gg_rct_Mirror_Arena, Trig_Mirror_relocation_Func009A)
        SetSoundPositionLocBJ(gg_snd_NightElfBuildingDeathSmall1, udg_TeleportBombMirrorExitPoint, 0)
        PlaySoundBJ(gg_snd_NightElfBuildingDeathSmall1)
        CreateNUnitsAtLoc(1, FourCC('e006'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TeleportBombMirrorExitPoint,
            bj_UNIT_FACING)
        DestroyGroup(udg_TempUnitGroup)
        DestroyGroup(udg_Mirror_KillExitGroup)
        DestroyGroup(udg_AI_group)
        DisableTrigger(gg_trg_Mirror_A_I)
        DisableTrigger(gg_trg_Mirror_un_abuse)
        DisableTrigger(GetTriggeringTrigger())
    end

    --===========================================================================
    gg_trg_Mirror_relocation = CreateTrigger()
    DisableTrigger(gg_trg_Mirror_relocation)
    TriggerRegisterAnyUnitEventBJ(gg_trg_Mirror_relocation, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Mirror_relocation, Condition(Trig_Mirror_relocation_Conditions))
    TriggerAddAction(gg_trg_Mirror_relocation, Trig_Mirror_relocation_Actions)
end)
if Debug then Debug.endFile() end
