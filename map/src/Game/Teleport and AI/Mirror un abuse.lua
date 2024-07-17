if Debug then Debug.beginFile "Game/TeleportAndAI/MirrorUnAbuse" end
OnInit.map("MirrorUnAbuse", function(require)
    ---@return boolean
    function Trig_Mirror_un_abuse_Func006Func001C()
        if (not (GetUnitTypeId(GetEnumUnit()) == FourCC('H03I'))) then
            return false
        end
        return true
    end

    function Trig_Mirror_un_abuse_Func006A()
        if (Trig_Mirror_un_abuse_Func006Func001C()) then
            DisplayTextToPlayer(GetOwningPlayer(GetEnumUnit()), 0, 0,
                "|CFF7EBFF1\nAlternative Dimension shifted away!\n\nOriginal Dimension recovered.")
        else
            SetUnitPositionLoc(GetEnumUnit(), udg_TeleportBombMirrorExitPoint)
        end
    end

    function Trig_Mirror_un_abuse_Func007A()
        KillUnit(GetEnumUnit())
    end

    function Trig_Mirror_un_abuse_Func008A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_Mirror_Arena)
    end

    function Trig_Mirror_un_abuse_Func009A()
        RemoveItem(GetEnumItem())
    end

    function Trig_Mirror_un_abuse_Actions()
        PauseTimerBJ(true, udg_Mirror_Timer)
        udg_Mirror_Enabled = false
        udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Mirror_Arena)
        GroupRemoveGroup(GetUnitsInRectOfPlayer(gg_rct_Mirror_Arena, Player(PLAYER_NEUTRAL_PASSIVE)), udg_TempUnitGroup)
        ForGroupBJ(udg_TempUnitGroup, Trig_Mirror_un_abuse_Func006A)
        ForGroupBJ(udg_Mirror_Hostilegroup, Trig_Mirror_un_abuse_Func007A)
        ForForce(GetPlayersAll(), Trig_Mirror_un_abuse_Func008A)
        EnumItemsInRectBJ(gg_rct_Mirror_Arena, Trig_Mirror_un_abuse_Func009A)
        SetSoundPositionLocBJ(gg_snd_NightElfBuildingDeathSmall1, udg_TeleportBombMirrorExitPoint, 0)
        PlaySoundBJ(gg_snd_NightElfBuildingDeathSmall1)
        CreateNUnitsAtLoc(1, FourCC('e006'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TeleportBombMirrorExitPoint,
            bj_UNIT_FACING)
        DestroyGroup(udg_TempUnitGroup)
        DestroyGroup(udg_Mirror_KillExitGroup)
        DestroyGroup(udg_AI_group)
        DisableTrigger(gg_trg_Mirror_relocation)
        DisableTrigger(gg_trg_Mirror_A_I)
        DisableTrigger(GetTriggeringTrigger())
    end

    --===========================================================================
    gg_trg_Mirror_un_abuse = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_Mirror_un_abuse, udg_Mirror_Timer)
    TriggerAddAction(gg_trg_Mirror_un_abuse, Trig_Mirror_un_abuse_Actions)
end)
if Debug then Debug.endFile() end
