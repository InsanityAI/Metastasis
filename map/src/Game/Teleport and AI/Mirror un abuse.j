function Trig_Mirror_un_abuse_Func006Func001C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetEnumUnit()) == 'H03I')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Mirror_un_abuse_Func006A takes nothing returns nothing 
    if(Trig_Mirror_un_abuse_Func006Func001C()) then 
        call DisplayTextToPlayer(GetOwningPlayer(GetEnumUnit()), 0, 0, "|CFF7EBFF1|nAlternative Dimension shifted away !|n|nOriginal Dimension recovered.")
    else 
        call SetUnitPositionLoc(GetEnumUnit(), udg_TeleportBombMirrorExitPoint) 
    endif 
endfunction 

function Trig_Mirror_un_abuse_Func007A takes nothing returns nothing 
    call KillUnit(GetEnumUnit()) 
endfunction 

function Trig_Mirror_un_abuse_Func008A takes nothing returns nothing 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_Mirror_Arena) 
endfunction 

function Trig_Mirror_un_abuse_Func009A takes nothing returns nothing 
    call RemoveItem(GetEnumItem()) 
endfunction 

function Trig_Mirror_un_abuse_Actions takes nothing returns nothing 
    call PauseTimerBJ(true, udg_Mirror_Timer) 
    set udg_Mirror_Enabled = false 
    set udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Mirror_Arena) 
    call GroupRemoveGroup(GetUnitsInRectOfPlayer(gg_rct_Mirror_Arena, Player(PLAYER_NEUTRAL_PASSIVE)), udg_TempUnitGroup) 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_Mirror_un_abuse_Func006A) 
    call ForGroupBJ(udg_Mirror_Hostilegroup, function Trig_Mirror_un_abuse_Func007A) 
    call ForForce(GetPlayersAll(), function Trig_Mirror_un_abuse_Func008A) 
    call EnumItemsInRectBJ(gg_rct_Mirror_Arena, function Trig_Mirror_un_abuse_Func009A) 
    call SetSoundPositionLocBJ(gg_snd_NightElfBuildingDeathSmall1, udg_TeleportBombMirrorExitPoint, 0) 
    call PlaySoundBJ(gg_snd_NightElfBuildingDeathSmall1) 
    call CreateNUnitsAtLoc(1, 'e006', Player(PLAYER_NEUTRAL_PASSIVE), udg_TeleportBombMirrorExitPoint, bj_UNIT_FACING) 
    call DestroyGroup(udg_TempUnitGroup) 
    call DestroyGroup(udg_Mirror_KillExitGroup) 
    call DestroyGroup(udg_AI_group) 
    call DisableTrigger(gg_trg_Mirror_relocation) 
    call DisableTrigger(gg_trg_Mirror_A_I) 
    call DisableTrigger(GetTriggeringTrigger()) 
endfunction 

//=========================================================================== 
function InitTrig_Mirror_un_abuse takes nothing returns nothing 
    set gg_trg_Mirror_un_abuse = CreateTrigger() 
    call TriggerRegisterTimerExpireEventBJ(gg_trg_Mirror_un_abuse, udg_Mirror_Timer) 
    call TriggerAddAction(gg_trg_Mirror_un_abuse, function Trig_Mirror_un_abuse_Actions) 
endfunction 

