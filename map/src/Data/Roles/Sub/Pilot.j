library Pilot requires SubRole
    struct Pilot extends SubRole
        method getInitialText takes MainRole mainRole returns string
            local integer roleId = mainRole.getRoleId()
            if roleId == ROLE_ALIEN then 
                return "|cff008040As a dashing, brave, and handsome fighter pilot you are the top of your class and excel at piloting your custom Albadar. You were only going to stop into this backwater sector for refuelling before heading back out into the front lines.|r\n|cffFF0000Sadly your unreal piloting skills didn't help you when you were tackled by an alien beast on your ship. After a brief struggle you woke up to find yourself on the floor. What you saw in the mirror wasn't even human...|r"
            elseif roleId == ROLE_MUTANT then 
                return "|cff008040As a dashing, brave, and handsome fighter pilot you are the top of your class and excel at piloting your custom Albadar. You were only going to stop into this backwater sector for refuelling before heading back out into the front lines.|r\n|cffFF0000Regrettably your bad stimpack addiction caused you to steal what you thought were adrenaline vials from the local researchers. Only after a general alarm amongst the researchers broke out did you begin to care. And only after you knew what you were becoming did you begin to hate.|r"
            elseif roleId == ROLE_ANDROID then 
                return "|cff800080You are an ICS-class android. The top-secret and dangerous nature of the work in sector 198X2 necessitated your deployment in the region to monitor the progress of sector research, sniff out any spies or traitors, and if necessary kill sector personnel to prevent a security breach. Disguised as a dashing fighter pilot, you were able to come and go without questions.|r\n|cffFF0000The recent outbreaks have caught both you and your programmers off guard, however. There is no contingency plan for such an occurence, and your communications link has been somehow severed. Default directives require that you eliminate the threat while protecting, if possible, local personnel."
            else 
                return "|cff008040As a dashing, brave, and handsome fighter pilot you are the top of your class and excel at piloting your custom Albadar. You were only going to stop into this backwater sector for refuelling before heading back out into the front lines.|r\n|cff00FF00Now you can't leave because some panicked scientists put out a sector lockdown. You don't want to be investigated when government ships finally arrive, so you have a feeling you should help the locals solve whatever so you can avoid stimpack rehabilitation and a nasty demotion.|r"
            endif 
        endmethod

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing
            local integer rng = GetRandomInt(1, 4)
            if rng == 1 then 
                call UnitAddItemById(metaPlayer.hero, 'I008') 
            elseif rng == 2 then 
                call UnitAddItemById(metaPlayer.hero, 'I001') 
            elseif rng == 3 then 
                call UnitAddItemById(metaPlayer.hero, 'I000') 
            else 
                call UnitAddItemById(metaPlayer.hero, 'I007') 
            endif
        endmethod

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing
            //Do nothing - Item properties
            //TODO: rewrite suits system and add Ace passive ref here
        endmethod

        method getNamePrepension takes nothing returns string
            return "Ace"
        endmethod

        method hasPredefinedSpawn takes nothing returns boolean
            return true
        endmethod

        method pickPredefinedSpawn takes nothing returns nothing
            //Do nothing - only 1 predefined spawnpoint
        endmethod

        method getPredefinedSpawnX takes nothing returns real
            return -2252.00
        endmethod

        method getPredefinedSpawnY takes nothing returns real
            return 14431.00
        endmethod
    endstruct
endlibrary