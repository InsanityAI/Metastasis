library StandardMode initializer init requires Gamemode, MetaPlayer, RolePicker, Alien, Mutant, Human, Android, Captain, CEO, Commissar, Engineer, Janitor, Medic, Pilot, Researcher, SecurityGuard, WarVeteran

    globals
        private group spawnPoints
        private integer playerCount
    endglobals

    private function getRandomSpawnPoint takes nothing returns unit
        local unit randomSpawnPoint = GroupPickRandomUnit(spawnPoints)
        call GroupRemoveUnit(spawnPoints, randomSpawnPoint)
        return randomSpawnPoint
    endfunction

    private function spawnPersonnelEnum takes nothing returns nothing
        local player thisPlayer = GetEnumPlayer()
        local MetaPlayer metaPlayer = MetaPlayer_Get(thisPlayer)
        local unit spawnPoint = getRandomSpawnPoint()
        local unit hero = CreateUnit(thisPLayer, UnitIds_PERSONNEL, GetUnitX(spawnPoint), GetUnitY(spawnPoint), bj_UNIT_FACING)

        call metaPlayer.setHero(hero)
        
        set spawnPoint = null
        set hero = null
        set thisPlayer = null
    endfunction

    private function spawnPersonnel takes force players returns nothing
        call ForForce(players, function spawnPersonnelEnum)
    endfunction

    struct StandardMode extends Gamemode
        method StartSetup takes nothing returns nothing
            local integer randomStation = GetRandomInt(0, 2)
            set playerCount = CountPlayersInForceBJ(GetPlayersAll())
            call Defunct_Initialize()
            call Niffy_Initialize()
            call KYO_Initialize()
            call Swagger_Initialize()
            call Minertha_Initialize()
            call Errun_Initialize()
            call Syllus_Initialize()

            if playerCount > 6 then
                call Arbitress_Initialize()
                if randomStation == 1 then
                    call Calipea_Initialize()
                endif
                if playerCount > 10 or randomStation == 2 then
                    call Pown_Initialize()
                endif
            endif

            //get station spawnpoints - for each station in game
            //Initialize ships
            // get spaceship spawnpoints - for each spaceship in game
            // put in spawnPoints
            
        endmethod

        method EndSetup takes nothing returns nothing
            call RolePicker_SetDefaultSubRole(SecurityGuard.create())
            call RolePicker_AddSubRole(Researcher.create())
            call RolePicker_AddSubRole(Researcher.create())
            call RolePicker_AddSubRole(SecurityGuard.create())
            call RolePicker_AddSubRole(SecurityGuard.create())
            call RolePicker_AddSubRole(Medic.create())
            call RolePicker_AddSubRole(Captain.create())
            call RolePicker_AddSubRole(Janitor.create())
            call RolePicker_AddSubRole(CEO.create())
            call RolePicker_AddSubRole(Commissar.create())
            call RolePicker_AddSubRole(Engineer.create())
            call RolePicker_AddSubRole(WarVeteran.create())
            call RolePicker_AddSubRole(Pilot.create())

            call RolePicker_SetDefaultMainRole(Human.create())
            if playerCount <= 4 then
                if GetRandomInt(1,2) == 1 then
                    call RolePicker_AddMainRole(Mutant.create())
                else
                    call RolePicker_AddMainRole(Alien.create())
                endif
            else
                call RolePicker_AddMainRole(Mutant.create())
                call RolePicker_AddMainRole(Alien.create())
            endif

            if playerCount >= 7 then
                call RolePicker_AddMainRole(Android.create())
            endif

            call RolePicker_AssignRandomRoles(GetPlayersAll())
                
            // if playerCount <= 0 then 
            //     call DisplayTextToForce(GetPlayersAll(), "|cffffcc00Less than 4 players has been detected. Testing mode enabled. Type -help for a list of commands.|r") 
            //     return 

           //Spawn units
            //Pick roles

            //UnInit calipea if no engineeer
        endmethod

        method StartGame takes nothing returns nothing
        endmethod

        method EndGame takes nothing returns nothing
        endmethod
    endstruct

    private function init takes nothing returns nothing
        set spawnPoints = CreateGroup()
    endfunction
endlibrary