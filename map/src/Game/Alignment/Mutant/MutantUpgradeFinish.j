function Trig_MutantUpgradeFinish_Func001C takes nothing returns boolean 
    if(not(IsUnitDeadBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func002C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h00U')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func003C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h00V')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func004C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h01I')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func005C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h01L')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func006C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h01K')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func007C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h01O')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func008C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h01V')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func009C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h04G')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func010C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h04W')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func016Func003C takes nothing returns boolean 
    if(not(udg_TempBool == true)) then 
        return false 
    endif 
    if(not(RectContainsUnit(gg_rct_Timeout, udg_TempUnit2) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func016Func006C takes nothing returns boolean 
    if(not(RectContainsLoc(gg_rct_Space, udg_TempPoint2) == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func016Func008C takes nothing returns boolean 
    if(not(RectContainsLoc(gg_rct_Space, udg_TempPoint) == false)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func016Func024A takes nothing returns nothing 
    call SetUnitOwner(GetEnumUnit(), udg_Mutant, true) 
endfunction 

function Trig_MutantUpgradeFinish_Func016C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h04G')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func023C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h04W')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func027Func001C takes nothing returns boolean 
    if(not(udg_Player_IsMutantSpawn[GetForLoopIndexA()] == true)) then 
        return false 
    endif 
    if(not(udg_HiddenAndroid != ConvertedPlayer(GetForLoopIndexA()))) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func028C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h01G')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func029C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h01V')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func030C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h01C')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func031C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h01L')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Func032C takes nothing returns boolean 
    if(not(udg_MutantUpgradingTo == 'h01B')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_MutantUpgradeFinish_Actions takes nothing returns nothing 
    if(Trig_MutantUpgradeFinish_Func001C()) then 
        return 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func002C()) then 
        set udg_Mutant_IsPerfection = true 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func003C()) then 
        set udg_MutantChildInfectee = 'h00W' 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func004C()) then 
        set udg_MutantChildInfectee = 'h01J' 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func005C()) then 
        set udg_MutantChildInfectee = 'h01M' 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func006C()) then 
        set udg_MutantChildInfectee = 'h01N' 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func007C()) then 
        set udg_MutantChildInfectee = 'h01R' 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func008C()) then 
        set udg_MutantChildInfectee = 'h01X' 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func009C()) then 
        set udg_MutantChildInfectee = 'h01T' 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func010C()) then 
        set udg_MutantChildInfectee = 'h01Y' 
        call SetPlayerTechMaxAllowedSwap('h01T', 1, udg_Mutant) 
        call SetPlayerTechMaxAllowedSwap('h01U', 10, udg_Mutant) 
        set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) 
        call CreateNUnitsAtLoc(1, 'h01T', udg_Mutant, udg_TempPoint, bj_UNIT_FACING) 
        call SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Mutant) 
        set bj_forLoopAIndex = 1 
        set bj_forLoopAIndexEnd = 6 
        loop 
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
            call UnitAddItemSwapped(UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], GetForLoopIndexA()), GetLastCreatedUnit()) 
            set bj_forLoopAIndex = bj_forLoopAIndex + 1 
        endloop 
    else 
    endif 
    set udg_TempPoint = GetUnitLoc(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)]) 
    call CreateNUnitsAtLoc(1, udg_MutantUpgradingTo, udg_Mutant, udg_TempPoint, bj_UNIT_FACING) 
    set udg_TempUnit = GetLastCreatedUnit() 
    call SetUnitX(GetLastCreatedUnit(), GetLocationX(udg_TempPoint)) 
    call SetUnitY(GetLastCreatedUnit(), GetLocationY(udg_TempPoint)) 
    if(Trig_MutantUpgradeFinish_Func016C()) then 
        set udg_TempUnit2 = udg_Sector_Space[GetUnitSector(udg_TempUnit)] 
        set udg_TempBool = IsUnitExplorer(udg_TempUnit2) 
        if(Trig_MutantUpgradeFinish_Func016Func003C()) then 
            set udg_TempPoint2 = GetUnitLoc(udg_Sector_Space[GetUnitSector(udg_SS_Landed[GetUnitAN(udg_TempUnit2)])]) 
        else 
            set udg_TempPoint2 = GetUnitLoc(udg_TempUnit2) 
        endif 
        if(Trig_MutantUpgradeFinish_Func016Func006C()) then 
            call RemoveLocation(udg_TempPoint2) 
            set udg_TempPoint2 = GetRandomLocInRect(gg_rct_Space) 
        else 
        endif 
        set udg_TempPoint = PolarProjectionBJ(udg_TempPoint2, 256, GetRandomDirectionDeg()) 
        if(Trig_MutantUpgradeFinish_Func016Func008C()) then 
            call RemoveLocation(udg_TempPoint) 
            set udg_TempPoint = udg_TempPoint2 
        else 
            call RemoveLocation(udg_TempPoint2) 
        endif 
        call SetUnitX(GetLastCreatedUnit(), GetLocationX(udg_TempPoint)) 
        call SetUnitY(GetLastCreatedUnit(), GetLocationY(udg_TempPoint)) 
        call PanCameraToTimedLocForPlayer(udg_Mutant, udg_TempPoint, 0) 
        call RemoveLocation(udg_TempPoint) 
        set udg_TempPoint = GetRectCenter(gg_rct_OverlordRect) 
        set udg_Sector_Space[27] = udg_TempUnit 
        call GroupAddUnitSimple(udg_TempUnit, udg_SpaceObject_CollideGroup) 
        call NewUnitRegister(udg_TempUnit) 
        set udg_SpaceObject_CollideRadius[GetUnitUserData(udg_TempUnit)] = 100.00 
        call TriggerExecute(gg_trg_ST11Init) 
        call SetPlayerTechMaxAllowedSwap('h01T', 1, udg_Mutant) 
        call SetPlayerTechMaxAllowedSwap('h01U', 10, udg_Mutant) 
        set udg_UpgradePointsMutant = 600.00 
        call SetPlayerStateBJ(udg_Mutant, PLAYER_STATE_RESOURCE_LUMBER, 600) 
        set bj_forLoopAIndex = 1 
        set bj_forLoopAIndexEnd = 6 
        loop 
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
            call SetItemPositionLoc(UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], GetForLoopIndexA()), udg_TempPoint) 
            set bj_forLoopAIndex = bj_forLoopAIndex + 1 
        endloop 
        call ForGroupBJ(GetUnitsInRectAll(gg_rct_OverlordRect), function Trig_MutantUpgradeFinish_Func016Func024A) 
    else 
        call SetUnitLifePercentBJ(GetLastCreatedUnit(), udg_MutantUpgrade_Health) 
        set bj_forLoopAIndex = 1 
        set bj_forLoopAIndexEnd = 6 
        loop 
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
            call UnitAddItemSwapped(UnitItemInSlotBJ(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], GetForLoopIndexA()), GetLastCreatedUnit()) 
            set bj_forLoopAIndex = bj_forLoopAIndex + 1 
        endloop 
    endif 
    call SetUnitOwner(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], Player(PLAYER_NEUTRAL_PASSIVE), true) 
    call SizeUnitOverTime(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], 3, 1, 0.01, false) 
    call FadeUnitOverTime(udg_Playerhero[GetConvertedPlayerId(udg_Mutant)], 5, true) 
    call RemoveLocation(udg_TempPoint) 
    set udg_MutantIsUpgrading = false 
    set udg_Playerhero[GetConvertedPlayerId(udg_Mutant)] = GetLastCreatedUnit() 
    if(Trig_MutantUpgradeFinish_Func023C()) then 
        // Let the OG selection to select harbringer ;) 
    else 
        call SelectUnitForPlayerSingle(GetLastCreatedUnit(), udg_Mutant) 
    endif 
    call PlaySoundBJ(gg_snd_FreakyForest4) 
    call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUTIN, 2, "ReplaceableTextures\\CameraMasks\\DiagonalSlash_mask.blp", 100.00, 100.00, 0, 0) 
    call DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2935") 
    set bj_forLoopAIndex = 1 
    set bj_forLoopAIndexEnd = 12 
    loop 
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd 
        if(Trig_MutantUpgradeFinish_Func027Func001C()) then 
            set udg_TempUnitType = udg_MutantChildInfectee 
            set udg_TempUnit = udg_Playerhero[GetForLoopIndexA()] 
            set udg_TempPlayer = ConvertedPlayer(GetForLoopIndexA()) 
            call ExecuteFunc("PendUpgrade") 
        else 
        endif 
        set bj_forLoopAIndex = bj_forLoopAIndex + 1 
    endloop 
    if(Trig_MutantUpgradeFinish_Func028C()) then 
        set udg_TempUnit = GetLastCreatedUnit() 
        call ExecuteFunc("FleshGolemLoop") 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func029C()) then 
        set udg_TempUnit = GetLastCreatedUnit() 
        call ExecuteFunc("DefilerGoo") 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func030C()) then 
        call EnableTrigger(gg_trg_CrabMutant) 
        call CrabTeleport(GetLastCreatedUnit()) 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func031C()) then 
        set udg_Mutant_IsRapidGestation = true 
    else 
    endif 
    if(Trig_MutantUpgradeFinish_Func032C()) then 
        call SetUnitTimeScalePercent(GetLastReplacedUnitBJ(), 160.00) 
    else 
    endif 
    // Trigger - Turn off Infinite Mutant bugfix <gen> 
endfunction 

//=========================================================================== 
function InitTrig_MutantUpgradeFinish takes nothing returns nothing 
    set gg_trg_MutantUpgradeFinish = CreateTrigger() 
    call TriggerAddAction(gg_trg_MutantUpgradeFinish, function Trig_MutantUpgradeFinish_Actions) 
endfunction 

