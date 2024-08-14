library AlienSpawn requires MainRole
    struct AlienSpawn extends MainRole
        method getRoleId takes nothing returns integer
            return ROLE_ALIEN_SPAWN
        endmethod

        method getInitialText takes nothing returns string
            return null
        endmethod

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing
            call SetPlayerState(metaPlayer.actualPlayer, PLAYER_STATE_RESOURCE_FOOD_CAP, 100) 
        endmethod

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing
        endmethod
    endstruct
endlibrary