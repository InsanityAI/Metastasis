if Debug then Debug.beginFile "Game/PlayerRolePicking/RolesInit" end
OnInit.map("RolesInit", function(require)
    udg_PlayerRoleTrigger[1] = gg_trg_Researcher
    udg_PlayerRoleTrigger[2] = gg_trg_Researcher
    udg_PlayerRoleTrigger[3] = gg_trg_SecurityGuard
    udg_PlayerRoleTrigger[4] = gg_trg_Medic
    udg_PlayerRoleTrigger[5] = gg_trg_Captain
    udg_PlayerRoleTrigger[6] = gg_trg_Janitor
    udg_PlayerRoleTrigger[7] = gg_trg_CEO
    udg_PlayerRoleTrigger[8] = gg_trg_Commissar
    udg_PlayerRoleTrigger[9] = gg_trg_Engineer
    udg_PlayerRoleTrigger[10] = gg_trg_WarVeteran
    udg_PlayerRoleTrigger[11] = gg_trg_Pilot
    udg_PlayerRoleTrigger[12] = gg_trg_SecurityGuard
    udg_RoleAbility[1] = FourCC('A00X')
    udg_RoleAbility[2] = FourCC('A00X')
    udg_RoleAbility[3] = FourCC('A037')
    udg_RoleAbility[4] = FourCC('A02C')
    udg_RoleAbility[5] = FourCC('A011')
    udg_RoleAbility[6] = FourCC('A04B')
    udg_RoleAbility[7] = FourCC('A011')
    udg_RoleAbility[8] = FourCC('A011')
    udg_RoleAbility[9] = FourCC('A053')
    udg_RoleAbility[10] = FourCC('A00V')
    udg_RoleAbility[11] = FourCC('A038')
    udg_RoleAbility[12] = FourCC('A037')
    udg_Dr_RoleAbility[1] = FourCC('A00X')
    udg_Dr_RoleAbility[2] = FourCC('A035')
    udg_Dr_RoleAbility[3] = FourCC('A034')
    udg_Dr_RoleAbility[4] = FourCC('A036')
end)
if Debug then Debug.endFile() end
