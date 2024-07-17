if Debug then Debug.beginFile "Game/TeleportAndAI/TheWarpRelocation" end
OnInit.map("TheWarpRelocation", function(require)
    function Trig_The_Warp_relocation_Func005A()
        RemoveUnit(GetEnumUnit())
    end

    ---@return boolean
    function Trig_The_Warp_relocation_Func009Func001C()
        if (not (GetUnitTypeId(GetEnumUnit()) == FourCC('H03I'))) then
            return false
        end
        return true
    end

    function Trig_The_Warp_relocation_Func009A()
        if (Trig_The_Warp_relocation_Func009Func001C()) then
        else
            SetUnitPositionLoc(GetEnumUnit(), udg_TempPoint2)
            DisplayTextToPlayer(GetOwningPlayer(GetEnumUnit()), 0, 0, "Relocation Succesful.")
        end
    end

    function Trig_The_Warp_relocation_Func013A()
        RemoveItem(GetEnumItem())
    end

    function Trig_The_Warp_relocation_Func014A()
        CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_Warp)
    end

    function Trig_The_Warp_relocation_Actions()
        PauseTimerBJ(true, udg_WarpTimer)
        udg_TempPoint2 = GetRectCenter(gg_rct_BombTeleport)
        udg_TempUnitGroup = GetUnitsInRectOfPlayer(gg_rct_Warp, Player(PLAYER_NEUTRAL_AGGRESSIVE))
        ForGroupBJ(udg_TempUnitGroup, Trig_The_Warp_relocation_Func005A)
        DestroyGroup(udg_TempUnitGroup)
        -- csa\c\a
        udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Warp)
        ForGroupBJ(udg_TempUnitGroup, Trig_The_Warp_relocation_Func009A)
        DestroyTimerDialogBJ(udg_Warp_Timer_Window)
        udg_TPareafail = 0
        DestroyGroup(udg_TempUnitGroup)
        EnumItemsInRectBJ(gg_rct_Warp, Trig_The_Warp_relocation_Func013A)
        ForForce(GetPlayersAll(), Trig_The_Warp_relocation_Func014A)
        AddSpecialEffectLocBJ(GetRectCenter(gg_rct_BombTeleport),
            "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        DestroyGroup(udg_TempUnitGroup)
        RemoveLocation(udg_TempPoint2)
        DisableTrigger(gg_trg_Warp_Artificial_Intelligence)
        DisableTrigger(gg_trg_The_Warp_ongoing)
        DisableTrigger(gg_trg_The_Warp_ongoing_spawn)
    end

    --===========================================================================
    gg_trg_The_Warp_relocation = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_The_Warp_relocation, udg_WarpTimer)
    TriggerAddAction(gg_trg_The_Warp_relocation, Trig_The_Warp_relocation_Actions)
end)
if Debug then Debug.endFile() end
