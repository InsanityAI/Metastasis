library WarVeteran requires SubRole
    struct WarVeteran extends SubRole
        method getInitialText takes MainRole mainRole returns string
            local integer roleId = mainRole.getRoleId()
            if roleId == ROLE_ALIEN then 
                return "|cff008040After Initiative forces emerged victorious from their war with the Coalition, you were suddenly left without a job. The government offered you a meagre retirement package or to serve as an arms expert training the local security guards in this sector. You chose the latter and wound up here.|r\n|cffFF0000Even a man of your military prowess is fallible, however. While docked at the U.S.I. Arbitress, you noticed a strange haze creeping through the station. As the only person onboard the station at the time, you thought there must be something wrong with the oxygen-supply system. Moments later the haze jumped at you and you suffocated. When you awoke, sprawled on the floor, you felt like a new man. A deadly, murderous new man." 
            elseif roleId == ROLE_MUTANT then 
                return "|cff008040After Initiative forces emerged victorious from their war with the Coalition, you were suddenly left without a job. The government offered you a meagre retirement package or to serve as an arms expert training the local security guards in this sector. You chose the latter and wound up here.|r\n|cffFF0000Even a man of your military prowess is fallible, however. After a round of arms training with the guards left you somewhat bruised, you decided to self-administer medication. Unfortunately, one of the researchers had accidently replaced some of the medical bay's hypodermic needles with a special serum. After injecting one of these and suffering a night of tormented agony, you knew what had been done to you and who had to pay.|r"
            elseif roleId == ROLE_ANDROID then 
                return "|cff800080You are an ICS-class android. The top-secret and dangerous nature of the work in sector 198X2 necessitated your deployment in the region to monitor the progress of sector research, sniff out any spies or traitors, and if necessary kill sector personnel to prevent a security breach. Disguised as a decorated war veteran, you were able to do things without questioning.|r\n|cffFF0000The recent outbreaks have caught both you and your programmers off guard, however. There is no contingency plan for such an occurence, and your communications link has been somehow severed. Default directives require that you eliminate the threat while protecting, if possible, local personnel."
            else 
                return "|cff008040After Initiative forces emerged victorious from their war with the Coalition, you were suddenly left without a job. The government offered you a meagre retirement package or to serve as an arms expert training the local security guards in this sector. You chose the latter and wound up here.|r\n|cff00FF00Recently you have heard rumors of murderous entities on the station. Perhaps now would be the time to dust off your arms and return to war.|r"
            endif 
        endmethod

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing
            call UnitAddItemById(metaPlayer.hero, ItemIds_LEGGINGS) 
        endmethod

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing
            //Do nothing - item properties
        endmethod

        method getNamePrepension takes nothing returns string
            return "Corporal"
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