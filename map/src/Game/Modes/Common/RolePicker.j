library RolePicker initializer init requires Table, MetaPlayer, MainRole, SubRole
    globals
        private MainRole defaultMainRole //if main role counts are exhaused, default to this
        private SubRole defaultSubRole //if sub role counts are exhaused, default to this
        private Table mainRoles //array of MainRole
        private Table subRoles //array of SubRole
    endglobals

    public function SetDefaultMainRole takes MainRole mainRole returns nothing
        set defaultMainRole = mainRole
    endfunction

    public function SetDefaultSubRole takes SubRole subRole returns nothing
        set defaultSubRole = subRole
    endfunction

    public function AddMainRole takes MainRole mainRole returns nothing
        set mainRoles[mainRoles.measureFork()] = mainRole
    endfunction

    public function AddSubRole takes SubRole subRole returns nothing
        set subRoles[subRoles.measureFork()] = subRole
    endfunction

    public function PopRandomMainRole takes nothing returns MainRole
        local Table roles = mainRoleCounts.getKeys()
        local MainRole selectedRole
        local integer i = roles[0]
        if i == 0 then
            return defaultMainRole
        else
            if i == 1 then
                set selectedRole = roles[1]
            else
                set selectedRole = roles[GetRandomInt(1, i)]
            endif

            call mainRoleCounts.remove(selectedRole)
            return selectedRole
        endif
    endfunction

    public function PopRandomSubRole takes nothing returns SubRole
        local Table roles = subRoleCounts.getKeys()
        local SubRole selectedRole
        local integer i = roles[0]
        if i == 0 then
            return defaultSubRole
        else
            if i == 1 then
                set selectedRole = roles[1]
            else
                set selectedRole = roles[GetRandomInt(1, i)]
            endif

            call subRoleCounts.remove(selectedRole)
            return selectedRole
        endif
    endfunction

    public function AssignRandomRole takes player thisPlayer returns nothing
        local MetaPlayer metaPlayer = MetaPlayer_Get(thisPlayer)
        call metaPlayer.setMainRole(PopRandomMainRole())
        call metaPlayer.setSubRole(PopRandomSubRole())
    endfunction

    private function AssignRandomRole_Enum takes nothing returns nothing        
        call AssignRandomRole(GetEnumPlayer())
    endfunction

    public function AssignRandomRoles takes force players returns nothing
        call ForForce(players, function AssignRandomRole_Enum)
    endfunction

    private function init takes nothing returns nothing
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
endlibrary