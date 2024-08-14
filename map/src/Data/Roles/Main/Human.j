library Human requires MainRole
    struct Human extends MainRole
        method getRoleId takes nothing returns integer
            return ROLE_HUMAN
        endmethod

        method getInitialText takes nothing returns string
            return "|cff808000YOU ARE HUMAN|r"
        endmethod

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing
            call SetPlayerState(metaPlayer.actualPlayer, PLAYER_STATE_RESOURCE_FOOD_CAP, 100) 
        endmethod

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing
        endmethod
    endstruct
endlibrary