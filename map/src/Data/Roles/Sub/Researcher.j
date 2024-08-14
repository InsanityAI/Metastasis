library Researcher requires SubRole 
    struct Researcher extends SubRole 
        private integer doctorFlavor = 0

        private method getDoctorFlavor takes nothing returns integer
            if this.doctorFlavor == 0 then
                set this.doctorFlavor = GetRandomInt(1, 3)
            endif
            return this.doctorFlavor
        endmethod

        private method getDoctorFlavorText takes MainRole mainRole returns string
            local integer roleId = mainRole.getRoleId()
            local integer doctorFlavor = getDoctorFlavor()
            local string flavorText 
            if doctorFlavor == 1 then
                set flavorText = "|cff000080You have a PhD in Biology.|r|n|cff008080You have 200% health regeneration!|r"
                if roleId == ROLE_ALIEN or roleId == ROLE_MUTANT then 
                    set flavorText = flavorText + "|n|cffFF0000This only applies while you are human.|r"
                endif 
            elseif doctorFlavor == 2 then
                set flavorText = "|cff000080You have a PhD in Optics!|r|n|cff008080You have extra sight range!|r"
                if roleId == ROLE_ALIEN or roleId == ROLE_MUTANT then 
                    set flavorText = flavorText + "|n|cffFF0000This only applies while you are human.|r"
                endif 
            else
                set flavorText = "|cff000080You have a PhD in Gravitational Effects.|r|n|cff008080Ships under your control move 10% faster!|r"
            endif

            // call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff000080You have a PhD in Electronics.|r") 
            // call DisplayTimedTextToPlayer(udg_TempPlayer, 0, 0, 30, "|cff008080Sentries and force shields built by you gain 50 health!|r") 
            // set udg_Researcher_PhD[GetConvertedPlayerId(udg_TempPlayer)] = 3 

            return flavorText
        endmethod

        method getInitialText takes MainRole mainRole returns string 
            local integer roleId = mainRole.getRoleId()
            local string initialText
            if roleId == ROLE_ALIEN then 
                set initialText = "|cff008040You were once a researcher working on the stations. You were involved in a top-secret human enhancement project run by the United Security Initiative. You had your ethical qualms, but you shut up because the money was good.|r\n|cffFF0000It seems that your research wasn't ultimately your downfall, however. While on a spacewalk, you remember noticing a minor tear in your suit. The next day you found you not yourself anymore; you had been infected by something. And now you can feel it growing inside of you. And it feels good."
            elseif roleId == ROLE_MUTANT then 
                set initialText = "|cff008040You were once a researcher working on the stations. You were involved in a top-secret human enhancement project run by the United Security Initiative. You had your ethical qualms, but you shut up because the money was good.|r\n|cffFF0000Unfortunately, your work has come back to haunt you. One night you were working late in the lab when you accidently injected a serum you were working on. Nobody else saw this, but the effect was immediate. You know that the serum tampered with your genetic code. You are scared, but you know what you must do to survive.|r"
            elseif roleId == ROLE_ANDROID then 
                set initialText = "|cff800080You are an ICS-class android. The top-secret and dangerous nature of the work in sector 198X2 necessitated your deployment in the region to monitor the progress of sector research, sniff out any spies or traitors, and if necessary kill sector personnel to prevent a security breach. Disguised as a local researcher, you were able to both push research in the proper direction and silence the ethical concerns of your 'colleagues'.|r\n|cffFF0000The recent outbreaks have caught both you and your programmers off guard, however. There is no contingency plan for such an occurence, and your communications link has been somehow severed. Default directives require that you eliminate the threat while protecting, if possible, local personnel." 
            else 
                set initialText = "|cff008040You are a researcher working on the stations. You were involved in a top-secret human enhancement project run by the United Security Initiative. You had your ethical qualms, but you shut up because the money was good.|r\n\n|cff00FF00Now something has gone terribly wrong. Murky security footage suggests that someone accidently injected themselves with a dangerous serum; if they were not instantly killed they may become more powerful and seek revenge.\\rWhile as a scientist you are skeptical of this, the local janitor has been whispering about an alien that patrols the hallways at night. If this man is to be believed, an alien could very well jeopardize the entire sector, and your life.|r" 
            endif 
            return initialText + "|n" + getDoctorFlavorText(mainRole)
        endmethod 

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing 
            local integer doctorFlavor = getDoctorFlavor()
            if this.doctorFlavor == 1 then
                set udg_Researcher_PhD[GetConvertedPlayerId(metaPlayer.actualPlayer)] = 4 
                call SetPlayerTechResearched(metaPlayer.actualPlayer, 'R006', 1) 
            elseif this.doctorFlavor == 2 then
                set udg_Researcher_PhD[GetConvertedPlayerId(metaPlayer.actualPlayer)] = 1 
                call SetPlayerTechResearched(metaPlayer.actualPlayer, 'R008', 1) 
            else
                set udg_Researcher_PhD[GetConvertedPlayerId(metaPlayer.actualPlayer)] = 2 
                call SetPlayerTechResearched(metaPlayer.actualPlayer, 'R007', 1) 
            endif
            call UnitAddItemById(metaPlayer.hero, ItemIds_PHASE_CLOAK) 
            call UnitAddItemById(metaPlayer.hero, ItemIds_MEDPACK)
        endmethod 

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing 
            //Do nothing - item properties 
            //TODO: rewrite suits system + add passives references here
        endmethod 

        method getNamePrepension takes nothing returns string 
            return "Dr." 
        endmethod 

        method hasPredefinedSpawn takes nothing returns boolean 
            return false 
        endmethod 

        method pickPredefinedSpawn takes nothing returns nothing 
            //Do nothing - no predefined spawnpoint 
        endmethod 

        method getPredefinedSpawnX takes nothing returns real 
            return 0.00
        endmethod 

        method getPredefinedSpawnY takes nothing returns real 
            return 0.00
        endmethod 
    endstruct 
endlibrary