library SecurityGuard requires SubRole
    struct SecurityGuard extends SubRole
        method getInitialText takes MainRole mainRole returns string
            local integer roleId = mainRole.getRoleId()
            if roleId == ROLE_ALIEN then 
                return "|cff008040You were once a a security guard employed to protect the researchers. Officially, your job was to hold pirates at bay; but this always seemed suspicious to you.|r\n|cffFF0000Your fears were confirmed when one night you were attacked by a horrible, tentacled monstrosity while piloting an explorer craft. It smothered your viewport and soon broke into your ship. You remember nothing beyond that point; but you awoke the next day and felt different. Suddenly, you felt...nonhuman."
            elseif roleId == ROLE_MUTANT then 
                return "|cff008040You were once a a security guard employed to protect the researchers. Officially, your job was to hold pirates at bay; but this always seemed suspicious to you.|r\n|cffFF0000It seems though that the scientists you were guarding were ultimately malevolent. One night, as you were locking down the research labs, one of them threw himself against you and started stabbing you with a needle. You quickly shot and killed this man out of instinct, and threw his corpse out of the airlock. By reading his journal log, you found out that he knew what the serum would do to you; turn you into a monster. And surely the others will look for you soon. You must kill them before they kill you."
            elseif roleId == ROLE_ANDROID then 
                return "|cff800080You are an ICS-class android. The top-secret and dangerous nature of the work in sector 198X2 necessitated your deployment in the region to monitor the progress of sector research, sniff out any spies or traitors, and if necessary kill sector personnel to prevent a security breach. Disguised as a security guard, you had an excuse to be in many places at once without anyone questioning whether you were really working.|r\n|cffFF0000The recent outbreaks have caught both you and your programmers off guard, however. There is no contingency plan for such an occurence, and your communications link has been somehow severed. Default directives require that you eliminate the threat while protecting, if possible, local personnel."
            else 
                return "|cff008040You are a security guard employed to protect the researchers. Officially, your job was to hold pirates at bay; but this always seemed suspicious to you.|r\n|cff00FF00It appears that something has gone terribly wrong. The local janitor, who you know and trust, said he saw an alien monstrosity lurking the hallways at night. If this thing kills anyone, you are sure to be sacked- if you're not dead first.|r"
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
            call SetPlayerTechResearched(metaPlayer.actualPlayer, 'R000', 1) 
        endmethod

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing
            //Do nothing - item properties
        endmethod

        method getNamePrepension takes nothing returns string
            return "Private"
        endmethod

        method hasPredefinedSpawn takes nothing returns boolean
            return false
        endmethod

        method pickPredefinedSpawn takes nothing returns nothing
            //Do nothing - no predefined spawnpoints
        endmethod

        method getPredefinedSpawnX takes nothing returns real
            return 0.00
        endmethod

        method getPredefinedSpawnY takes nothing returns real
            return 0.00
        endmethod
    endstruct
endlibrary