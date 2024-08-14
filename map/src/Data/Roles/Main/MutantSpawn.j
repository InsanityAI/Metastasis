library MutantSpawn requires MainRole
    struct MutantSpawn extends MainRole
        method getRoleId takes nothing returns integer
            return ROLE_MUTANT_SPAWN
        endmethod

        method getInitialText takes nothing returns string
            return null
        endmethod

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing
        endmethod

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing
        endmethod
    endstruct
endlibrary