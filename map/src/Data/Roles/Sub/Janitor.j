library Janitor requires SubRole
    struct Janitor extends SubRole
        method getInitialText takes MainRole mainRole returns string
            local integer roleId = mainRole.getRoleId()
            if roleId == ROLE_ALIEN then 
                return "|cff008040You are the stalwart and dependable janitor. At least, that's what everybody thinks; in reality you are a drunkard and a petty thief. If anyone found out, you'd be sure to be sacked.|r\n|cffFF0000On one of your midnight cleaning walks, you were attacked by a vicious insectoid beast. It fled after it bit you, and you haven't seen it again. The next day you stupidly told everyone you could about the incident, not realizing that you were becoming a vicious beast as you spoke. Of course, they would never suspect that it's you. The fools will all become your minions soon...|r" 
            elseif roleId == ROLE_MUTANT then 
                return "|cff008040You are the stalwart and dependable janitor. At least, that's what everybody thinks; in reality you are a drunkard and a petty thief. If anyone found out, you'd be sure to be sacked.|r\n|cffFF0000Unfortunately, such petty issues hardly matter now. You foolishly stole one of the researcher's test vials and, in a drunken stupor, injected yourself with it. You have no idea what it did, but you know that if anyone found out you'd be sacked, and possibly executed. Therefore you must kill everyone.|r" 
            elseif roleId == ROLE_ANDROID then 
                return "|cff800080You are an ICS-class android. The top-secret and dangerous nature of the work in sector 198X2 necessitated your deployment in the region to monitor the progress of sector research, sniff out any spies or traitors, and if necessary kill sector personnel to prevent a security breach. Disguised as the lowly local janitor, you were able to keep research labs spotless while surveying experimental results.|r\n|cffFF0000The recent outbreaks have caught both you and your programmers off guard, however. There is no contingency plan for such an occurence, and your communications link has been somehow severed. Default directives require that you eliminate the threat while protecting, if possible, local personnel." 
            else 
                return "|cff008040You are the stalwart and dependable janitor. At least, that's what everybody thinks; in reality you are a drunkard and a petty thief. If anyone found out, you'd be sure to be sacked.|r\n|cff00FF00On one of your midnight cleaning walks, you saw a vicious insectoid beast. You told everyone about it, and it may still be around. In that case, tonight you are donning an armored suit and hunting it down. The scientists have been acting strangely lately. Perhaps they are up to something...|r" 
            endif 
        endmethod

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing
            call UnitAddItemById(metaPlayer.hero, ItemIds_JANITOR_CARD) 
        endmethod

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing
            //Do nothing - item property
            //TODO: rewrite suits and add Rummage ability ref here
        endmethod

        method getNamePrepension takes nothing returns string
            return "Janitor"
        endmethod

        method hasPredefinedSpawn takes nothing returns boolean
            return false
        endmethod

        method pickPredefinedSpawn takes nothing returns nothing
            //Do nothing - no predefined spawn
        endmethod

        method getPredefinedSpawnX takes nothing returns real
            return 0.00
        endmethod

        method getPredefinedSpawnY takes nothing returns real
            return 0.00
        endmethod
    endstruct
endlibrary