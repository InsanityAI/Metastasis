library MainRole 
    interface MainRole 
        method getRoleId takes nothing returns integer
        method getInitialText takes nothing returns string
        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing
        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing
    endinterface 
endlibrary