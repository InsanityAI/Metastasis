library Android requires MainRole
    struct Android extends MainRole
        method getRoleId takes nothing returns integer
            return ROLE_ANDROID
        endmethod

        method getInitialText takes nothing returns string
            return "|cffFF8000YOU ARE THE ANDROID|r"
        endmethod

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing
            call SetPlayerState(metaPlayer.actualPlayer, PLAYER_STATE_RESOURCE_FOOD_CAP, 100) 
        endmethod

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing
        endmethod
    endstruct
endlibrary