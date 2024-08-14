library SubRole
    interface SubRole
        method getInitialText takes MainRole mainRole returns string
        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing
        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing
        method getNamePrepension takes nothing returns string
        method hasPredefinedSpawn takes nothing returns boolean
        method pickPredefinedSpawn takes nothing returns nothing
        method getPredefinedSpawnX takes nothing returns real
        method getPredefinedSpawnY takes nothing returns real
    endinterface
endlibrary