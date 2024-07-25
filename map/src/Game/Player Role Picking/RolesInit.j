function Trig_RolesInit_Actions takes nothing returns nothing 
    call DestroyTrigger(GetTriggeringTrigger()) 
    set udg_PlayerRoleTrigger[1] = gg_trg_Researcher 
    set udg_PlayerRoleTrigger[2] = gg_trg_Researcher 
    set udg_PlayerRoleTrigger[3] = gg_trg_SecurityGuard 
    set udg_PlayerRoleTrigger[4] = gg_trg_Medic 
    set udg_PlayerRoleTrigger[5] = gg_trg_Captain 
    set udg_PlayerRoleTrigger[6] = gg_trg_Janitor 
    set udg_PlayerRoleTrigger[7] = gg_trg_CEO 
    set udg_PlayerRoleTrigger[8] = gg_trg_Commissar 
    set udg_PlayerRoleTrigger[9] = gg_trg_Engineer 
    set udg_PlayerRoleTrigger[10] = gg_trg_WarVeteran 
    set udg_PlayerRoleTrigger[11] = gg_trg_Pilot 
    set udg_PlayerRoleTrigger[12] = gg_trg_SecurityGuard 
    set udg_RoleAbility[1] = 'A00X' 
    set udg_RoleAbility[2] = 'A00X' 
    set udg_RoleAbility[3] = 'A037' 
    set udg_RoleAbility[4] = 'A02C' 
    set udg_RoleAbility[5] = 'A011' 
    set udg_RoleAbility[6] = 'A04B' 
    set udg_RoleAbility[7] = 'A011' 
    set udg_RoleAbility[8] = 'A011' 
    set udg_RoleAbility[9] = 'A053' 
    set udg_RoleAbility[10] = 'A00V' 
    set udg_RoleAbility[11] = 'A038' 
    set udg_RoleAbility[12] = 'A037' 
    set udg_Dr_RoleAbility[1] = 'A00X' 
    set udg_Dr_RoleAbility[2] = 'A035' 
    set udg_Dr_RoleAbility[3] = 'A034' 
    set udg_Dr_RoleAbility[4] = 'A036' 
endfunction 

//=========================================================================== 
function InitTrig_RolesInit takes nothing returns nothing 
    set gg_trg_RolesInit = CreateTrigger() 
    call TriggerAddAction(gg_trg_RolesInit, function Trig_RolesInit_Actions) 
endfunction 

