library Medic requires SubRole
    struct Medic extends SubRole
        method getInitialText takes MainRole mainRole returns string
            local integer roleId = mainRole.getRoleId()
            if roleId == ROLE_ALIEN then 
                return "|cff008040You are the local doctor, physician, orthodontist, and chiropractor. Your job is to make sure that the local personnel remained in good health and were psychologically stable. You are somewhat short on cash but can sell your medical supplies if needed.|r\n|cffFF0000It seems though that the Hippocratic oath was made to be broken. Your side-hobby as a naturalist working to document the developments of the 'sluggly' worms on the local planet came to an abrupt end when something stabbed you in the back. When you woke up you realized that you were, of course, clinically dead. Which was a lot better than what you are about to make everyone else.|r"
            elseif roleId == ROLE_MUTANT then 
                return "|cff008040You are the local doctor, physician, orthodontist, and chiropractor. Your job is to make sure that the local personnel remained in good health and were psychologically stable. You are somewhat short on cash but can sell your medical supplies if needed.|r\n|cffFF0000It seems though that that the Hippocratic oath was made to be broken. While you were testing a new shipment of needles by injecting yourself with a sugar serum, you noticed that you had accidently taken one of the vials that the researchers were working on. If such a foolish and unprofessional mistake were discovered then you would surely have a black stain on your career. After saving so many lives, how can it hurt to kill a few to keep the silence?|r"
            elseif roleId == ROLE_ANDROID then 
                return "|cff800080You are an ICS-class android. The top-secret and dangerous nature of the work in sector 198X2 necessitated your deployment in the region to monitor the progress of sector research, sniff out any spies or traitors, and if necessary kill sector personnel to prevent a security breach. Disguised as a pioneering doctor/surgeon/pharmicist, you were able to make sure that the researchers would not back down from their experiments.|r\n|cffFF0000The recent outbreaks have caught both you and your programmers off guard, however. There is no contingency plan for such an occurence, and your communications link has been somehow severed. Default directives require that you eliminate the threat while protecting, if possible, local personnel."
            else 
                return "|cff008040You are the local doctor, physician, orthodontist, and chiropractor. Your job is to make sure that the local personnel remained in good health and were psychologically stable. You are somewhat short on cash but can sell your medical supplies if needed.|r\n|cff00FF00Personnel have been telling you that they have seen things in the hallways. Not everyone on the station can be insane at once, so maybe this is worth investigating...|r"
            endif 
        endmethod

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing
            call UnitAddItemById(metaPlayer.hero, ItemIds_CRITICAL_CARE_SYSTEM)
            call UnitAddItemById(metaPlayer.hero, ItemIds_MEDPACK)
            call UnitAddItemById(metaPlayer.hero, ItemIds_GIT)
        endmethod

        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing
            //Do nothing - item properties
            //Todo: rewrite suits system and add Heal ability ref here
        endmethod

        method getNamePrepension takes nothing returns string
            return "Medic"
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