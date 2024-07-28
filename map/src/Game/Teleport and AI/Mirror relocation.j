function Trig_Mirror_relocation_Conditions takes nothing returns boolean 
    if(not(RectContainsUnit(gg_rct_Mirror_Arena, GetTriggerUnit()) == true)) then 
        return false 
    endif 
    if(not(IsUnitGroupDeadBJ(udg_Mirror_KillExitGroup) == true)) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Mirror_relocation_Func007Func001C takes nothing returns boolean 
    if(not(GetUnitTypeId(GetEnumUnit()) == 'H03I')) then 
        return false 
    endif 
    return true 
endfunction 

function Trig_Mirror_relocation_Func007A takes nothing returns nothing 
    if(Trig_Mirror_relocation_Func007Func001C()) then 
        call DisplayTextToPlayer(GetOwningPlayer(GetEnumUnit()), 0, 0, "|CFF7EBFF1|nAlternative Dimension shattered!|n|nOriginal Dimension recovered.")
    else 
        call SetUnitPositionLoc(GetEnumUnit(), udg_TeleportBombMirrorExitPoint) 
    endif 
endfunction 

function Trig_Mirror_relocation_Func008A takes nothing returns nothing 
    call CreateFogModifierRectBJ(true, GetEnumPlayer(), FOG_OF_WAR_MASKED, gg_rct_Mirror_Arena) 
endfunction 

function Trig_Mirror_relocation_Func009A takes nothing returns nothing 
    call RemoveItem(GetEnumItem()) 
endfunction 

function Trig_Mirror_relocation_Actions takes nothing returns nothing 
    set udg_Mirror_Enabled = false 
    call RemoveLocation(udg_TempPoint2) 
    set udg_TempUnitGroup = GetUnitsInRectAll(gg_rct_Mirror_Arena) 
    call ForGroupBJ(udg_TempUnitGroup, function Trig_Mirror_relocation_Func007A) 
    call ForForce(GetPlayersAll(), function Trig_Mirror_relocation_Func008A) 
    call EnumItemsInRectBJ(gg_rct_Mirror_Arena, function Trig_Mirror_relocation_Func009A) 
    call SetSoundPositionLocBJ(gg_snd_NightElfBuildingDeathSmall1, udg_TeleportBombMirrorExitPoint, 0) 
    call PlaySoundBJ(gg_snd_NightElfBuildingDeathSmall1) 
    call CreateNUnitsAtLoc(1, 'e006', Player(PLAYER_NEUTRAL_PASSIVE), udg_TeleportBombMirrorExitPoint, bj_UNIT_FACING) 
    call DestroyGroup(udg_TempUnitGroup) 
    call DestroyGroup(udg_Mirror_KillExitGroup) 
    call DestroyGroup(udg_AI_group) 
    call DisableTrigger(gg_trg_Mirror_A_I) 
    call DisableTrigger(gg_trg_Mirror_un_abuse) 
    call DisableTrigger(GetTriggeringTrigger()) 
endfunction 

//=========================================================================== 
function InitTrig_Mirror_relocation takes nothing returns nothing 
    set gg_trg_Mirror_relocation = CreateTrigger() 
    call DisableTrigger(gg_trg_Mirror_relocation) 
    call TriggerRegisterAnyUnitEventBJ(gg_trg_Mirror_relocation, EVENT_PLAYER_UNIT_DEATH) 
    call TriggerAddCondition(gg_trg_Mirror_relocation, Condition(function Trig_Mirror_relocation_Conditions)) 
    call TriggerAddAction(gg_trg_Mirror_relocation, function Trig_Mirror_relocation_Actions) 
endfunction 

