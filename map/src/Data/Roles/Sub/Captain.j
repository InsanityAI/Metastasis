library Captain requires SubRole 
    struct Captain extends SubRole 
        method getInitialText takes MainRole mainRole returns string 
            local integer roleId = mainRole.getRoleId() 
            if roleId == ROLE_ALIEN then 
                return "|cff008040As the proud and well-paid captain of the local battlecruiser, your life was luxurious and successful. You were relegated to guard duty on a sector that was relatively secure. It seemed like you could have this cushy job for life.|r\n|cffFF0000That promise was cut short when you retired to your quarters one night. As the automatic door slid open, a small and black creature flung itself at your throat. By the time you were able to get it off, it was gone. But its effect was permanent; the next day you were no longer a captain, but another creature entirely." 
            elseif roleId == ROLE_MUTANT then 
                return "|cff008040As the proud and well-paid captain of the local battlecruiser, your life was luxurious and successful. You were relegated to guard duty on a sector that was relatively secure. It seemed like you could have this cushy job for life.|r\n|cffFF0000It seems though that while this sector was secure, it was far from safe. As an upstanding member of the sector's community, you volunteered to be a guinea pig in the experiments of the local science. While all the other test subjects were unaffected, you appear to have radically changed. Now you fear for your ship and your life; everybody who knows or could find out what you've become must be eliminated.|r" 
            elseif roleId == ROLE_ANDROID then 
                return "|cff800080You are an ICS-class android. The top-secret and dangerous nature of the work in sector 198X2 necessitated your deployment in the region to monitor the progress of sector research, sniff out any spies or traitors, and if necessary kill sector personnel to prevent a security breach. Disguised as a celebrated and retired captain, you had the respect and dignity required to sway local opinion and enter local research.|r\n|cffFF0000The recent outbreaks have caught both you and your programmers off guard, however. There is no contingency plan for such an occurence, and your communications link has been somehow severed. Default directives require that you eliminate the threat while protecting, if possible, local personnel." 
            else 
                return "|cff008040As the proud and well-paid captain of the local battlecruiser, your life is luxurious and successful. You are relegated to guard duty on a sector that was relatively secure. It seems like you could have this cushy job for life.|r\n|cff00FF00That is, unless what's been whispered is true. If there is an alien form present on one of the stations, it may compromise the safety of the crew. And this would reflect badly upon your job performance. Of course, seeing how there's also a rumor that there's a mutant freak running around, this is likely to be just hearsay. Or worse, both stories might be true." 
            endif 
        endmethod 

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing 
            call UnitAddItemById(metaPlayer.hero, ItemIds_CAPTAIN_CARD) 
        endmethod 

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing 
            //Do nothing - item only   
        endmethod 

        method getNamePrepension takes nothing returns string 
            return "Captain" 
        endmethod 

        method hasPredefinedSpawn takes nothing returns boolean 
            return true 
        endmethod 

        method pickPredefinedSpawn takes nothing returns nothing 
            //Do nothing - Only 1 spawnpoint   
        endmethod 

        method getPredefinedSpawnX takes nothing returns real 
            return - 14714.00
        endmethod 
        
        method getPredefinedSpawnY takes nothing returns real 
            return - 13302.00
        endmethod 
    endstruct 
endlibrary