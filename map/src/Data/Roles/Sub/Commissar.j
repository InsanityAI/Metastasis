library Commissar requires SubRole 
    struct Commissar extends SubRole 
        method getInitialText takes MainRole mainRole returns string 
            local integer roleId = mainRole.getRoleId() 
            if roleId == ROLE_ALIEN then 
                return "|cff008040You were a high-ranking commissar on a routine inspection of this sector's stations. You thoroughly enjoyed how the crew sucked up to you and decided to stay the night. The next day, you would give the sector a nice rating and move on.|r\n|cffFF0000Sadly for your bright career as an officer, you suffered a sudden and unexpected heart attack in the middle of the night. Moments later, to your complete surprise, your heart began pumping again. You looked up and saw a horrible creature sitting on your bed. You tried to scream, but something stopped you. The creature bounded off into the night. Jumping out of your bed, you picked up the phone to call security, but suddenly found that you no longer wanted to. The creature had taken over your mind, and now you are slave to its alien will.|r" 
            elseif roleId == ROLE_MUTANT then 
                return "|cff008040You were a high-ranking commissar on a routine inspection of this sector's stations. You thoroughly enjoyed how the crew sucked up to you and decided to stay the night. The next day, you would give the sector a nice rating and move on.|r\n|cffFF0000One of the crew, drunken and enraged that you had demoted him, assaulted you in the middle of the night. You shot him, but noticed that his weapon was unusual; a hypodermic needle and a vial of serum. Not wanting to bother with the usual incident reports, you dumped his body in the airlock and went about your business. As you lay in bed that night, too shocked to leave, you suddenly began to reconsider the fitness of the station's personnel. Maybe it would be time to execute a few of them, specifically the ones that might know anything about the attack...|r" 
            elseif roleId == ROLE_ANDROID then 
                return "|cff800080You are an ICS-class android. The top-secret and dangerous nature of the work in sector 198X2 necessitated your deployment in the region to monitor the progress of sector research, sniff out any spies or traitors, and if necessary kill sector personnel to prevent a security breach. Disguised as a strict commissar, you were able to instill a reign of terror that kept everyone doing exactly what you wanted them to do.|r\n|cffFF0000The recent outbreaks have caught both you and your programmers off guard, however. There is no contingency plan for such an occurence, and your communications link has been somehow severed. Default directives require that you eliminate the threat while protecting, if possible, local personnel." 
            else 
                return "|cff008040You are a high-ranking commissar on a routine inspection of this sector's stations. You thoroughly enjoyed how the crew sucked up to you and decided to stay the night. The next day, you would give the sector a nice rating and move on.|r\n|cff00FF00Unfortunately, something has happened on the station. There are whispers of monsters in the night, and you fully intend to quiet these rumors and restore discipline to the station. You may have to stay a while longer...|r" 
            endif 
        endmethod 

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing 
            call UnitAddItemById(metaPlayer.hero, ItemIds_GUN) 
        endmethod 

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing 
            //Do nothing - item only 
        endmethod 

        method getNamePrepension takes nothing returns string 
            return "Commissar" 
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