if Debug then Debug.beginFile "Game/ApocalypseSys/USIBattleFleet" end
OnInit.trig("USIBattleFleet", function(require)
    require "ArrayDat"
    function Trig_USIBattleFleet_Actions()
        local k       = CreateTimer() ---@type timer
        local f ---@type timerdialog
        local r ---@type location
        udg_TempPoint = GetRandomLocInRect(gg_rct_Space)
        if (IsUnitAliveBJ(gg_unit_h003_0018) == true) then
            if udg_TESTING == false then
                PingMinimapLocForForce(GetPlayersAll(), udg_TempPoint, 120.00)
            else
                PingMinimapLocForForce(GetPlayersAll(), udg_TempPoint, 5.00)
            end
        end
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3035")
        if udg_TESTING == false then
            StartTimerBJ(k, false, 120.00)
        else
            StartTimerBJ(k, false, 5.00)
        end
        f = CreateTimerDialogBJ(k, "TRIGSTR_3036")
        r = udg_TempPoint
        if udg_TESTING == false then
            PolledWait(120.00)
        else
            PolledWait(5.00)
        end
        DestroyTimerDialog(f)
        DestroyTimer(k)

        udg_TempPoint = r
        DisplayTextToForce(GetPlayersAll(), "TRIGSTR_3022")
        PlaySoundBJ(gg_snd_PursuitTheme)

        --DummyExplosion VFX
        CreateNUnitsAtLoc(1, FourCC('e01K'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)

        --Hapyir
        CreateNUnitsAtLoc(1, FourCC('h042'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
        udg_TempUnit = GetLastCreatedUnit()
        GroupAddUnitSimple(udg_TempUnit, udg_SpaceObject_CollideGroup)
        NewUnitRegister(udg_TempUnit)
        udg_SpaceObject_CollideRadius[GetUnitUserData(udg_TempUnit)] = 300.00
        GroupAddUnit(udg_SpaceAI_USIFleet, udg_TempUnit)
        --call ExecuteFunc("HostileSpaceAIForTempUnit")

        --Erstwhile
        CreateNUnitsAtLoc(1, FourCC('h041'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
        udg_TempUnit = GetLastCreatedUnit()
        GroupAddUnitSimple(udg_TempUnit, udg_SpaceObject_CollideGroup)
        NewUnitRegister(udg_TempUnit)
        udg_SpaceObject_CollideRadius[GetUnitUserData(udg_TempUnit)] = 200.00
        GroupAddUnit(udg_SpaceAI_USIFleet, udg_TempUnit)
        --call ExecuteFunc("HostileSpaceAIForTempUnit")

        --Cameroon
        CreateNUnitsAtLoc(1, FourCC('h040'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
        udg_TempUnit = GetLastCreatedUnit()
        GroupAddUnitSimple(udg_TempUnit, udg_SpaceObject_CollideGroup)
        NewUnitRegister(udg_TempUnit)
        udg_SpaceObject_CollideRadius[GetUnitUserData(udg_TempUnit)] = 200.00
        GroupAddUnit(udg_SpaceAI_USIFleet, udg_TempUnit)
        --call ExecuteFunc("HostileSpaceAIForTempUnit")

        --Loop to create 5 raptors
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 6
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            CreateNUnitsAtLoc(1, FourCC('h043'), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg_TempPoint, bj_UNIT_FACING)
            udg_TempUnit = GetLastCreatedUnit()
            GroupAddUnit(udg_SpaceAI_USIFleet, udg_TempUnit)
            --call ExecuteFunc("HostileSpaceAIForTempUnit")
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end

        --Make Pirate passive (can't blame fel, wouldn't be easy to make pirate fight players nor does it make sense to help the fleet either)
        SetUnitOwner(gg_unit_h02B_0116, Player(PLAYER_NEUTRAL_PASSIVE), true)

        --Memory Leak cleaning
        RemoveLocation(udg_TempPoint)
    end

    --===========================================================================
    gg_trg_USIBattleFleet = CreateTrigger()
    TriggerAddAction(gg_trg_USIBattleFleet, Trig_USIBattleFleet_Actions)
end)
if Debug then Debug.endFile() end
