library Engineer requires SubRole 
    struct Engineer extends SubRole 
        method getInitialText takes MainRole mainRole returns string 
            local integer roleId = mainRole.getRoleId() 
            if roleId == ROLE_ALIEN then 
                return "|cff008040You were a professional mechanic in employ of the United Security Initiative. You initially jumped at the chance to come aboard a space station, but quickly found even the magic of space travel to be tedious and boring.|r\n|cffFF0000Excitingly, your life is about to take a sharp downhill turn for the worse. As you were repairing a tank on the local planet one morning, your eyes fixed on a humanoid figure approaching you from the distance. It was a badly wounded man, and you rushed out to help him. But when you drew close, he lunged at you and bit you. Shortly after, he collapsed and died. You decided not to report the incident, but that very night you found that you could become an alien monstrosity at will, and that you had a burning desire to kill everything." 
            elseif roleId == ROLE_MUTANT then 
                return "|cff008040You were a professional mechanic in employ of the United Security Initiative. You initially jumped at the chance to come aboard a space station, but quickly found even the magic of space travel to be tedious and boring.|r\n|cffFF0000Excitingly, your life is about to take a sharp downhill turn. While repairing the medical bay and making sure its canisters were in order, you accidently splashed a dark liquid all over yourself. It immediately soaked through your clothes and into your skin. You suspected it was mercury, and probably would have reported for detoxification if not for an intense and irrational fear that suddenly took ahold of you. Everyone was plotting against you; soon you would grow strong and they must all then die.|r" 
            elseif roleId == ROLE_ANDROID then 
                return "|cff800080You are an ICS-class android. The top-secret and dangerous nature of the work in sector 198X2 necessitated your deployment in the region to monitor the progress of sector research, sniff out any spies or traitors, and if necessary kill sector personnel to prevent a security breach. Disguised as a local engineer, you were able to access all computer files and make sure research proceeded smoothly.|r\n|cffFF0000The recent outbreaks have caught both you and your programmers off guard, however. There is no contingency plan for such an occurence, and your communications link has been somehow severed. Default directives require that you eliminate the threat while protecting, if possible, local personnel." 
            else 
                return "|cff008040You are a professional mechanic in employ of the United Security Initiative. You initially jumped at the chance to come aboard a space station, but quickly found even the magic of space travel to be tedious and boring.|r\n|cff00FF00Excitingly, there are rumors of strange alien creatures running amok in the night. A corpse has turned up here and there, and you feel excited- in a very bad way.|r" 
            endif 
        endmethod 

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing 
            call UnitAddItemById(metaPlayer.hero, ItemIds_SERVICE_SUIT) 
            call UnitAddItemById(metaPlayer.hero, ItemIds_WRENCH) 
        endmethod 

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing 
            // Items only   
            //TODO: rewrite suits system then add door hack ref here   
        endmethod 

        method getNamePrepension takes nothing returns string 
            return "Engineer" 
        endmethod 

        method hasPredefinedSpawn takes nothing returns boolean 
            return Calipea_station != 0 //If calipea is spawned in   
        endmethod 

        method pickPredefinedSpawn takes nothing returns nothing 
            set udg_EngineerUsed = true 
            //Do nothing - 1 conditional spawn location   
        endmethod 

        method getPredefinedSpawnX takes nothing returns real 
            return - 6016.00 
        endmethod 

        method getPredefinedSpawnY takes nothing returns real 
            return 11980.00 
        endmethod 
    endstruct 
endlibrary