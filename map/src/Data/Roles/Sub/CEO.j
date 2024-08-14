library CEO requires SubRole, RoboButler
    struct CEO extends SubRole
        private RoboButler butler = 0

        method getInitialText takes MainRole mainRole returns string
            local integer roleId = mainRole.getRoleId() 
            if roleId == ROLE_ALIEN then 
                return "|cff008040You were a high paid CEO of a mining company, visiting one of your company's holdings in this sector. Flush with cash, you thought this would also be a vacation opportunity for you.|r\n|cffFF0000One night, you remember having a terrible dream. Something was smothering you in your sleep and spewing its guts into your mouth. You woke up the next morning, relieved to find it a dream, until you noticed your mouth tasted rancid. Over the next hour, your personality faded out and was gradually replaced by that of a cold and calculating murderous monster.|r" 
            elseif roleId == ROLE_MUTANT then 
                return "|cff008040You were a high paid CEO of a mining company, visiting one of your company's holdings in this sector. Flush with cash, you thought this would also be a vacation opportunity for you.|r\n|cffFF0000Although normally, a vacation doesn't involve becoming a hideous monster. While inspecting your company's holdings on a dark night, a scientist ran into you. You felt a sharp jab on your arm. You were about to walk on when the scientist began screaming. Feeling a rising sense of paranoia and panic, you ran off into the night. The researcher didn't recognize you, and he probably left the sector out of fear by now. But now, you are changing into something hideous..."
            elseif roleId == ROLE_ANDROID then 
                return "|cff800080You are an ICS-class android. The top-secret and dangerous nature of the work in sector 198X2 necessitated your deployment in the region to monitor the progress of sector research, sniff out any spies or traitors, and if necessary kill sector personnel to prevent a security breach. Disguised as an affluent CEO, you were able to both influence local players and bribe the researches into pushing research into the right direction.|r\n|cffFF0000The recent outbreaks have caught both you and your programmers off guard, however. There is no contingency plan for such an occurence, and your communications link has been somehow severed. Default directives require that you eliminate the threat while protecting, if possible, local personnel."
            else 
                return "|cff008040You were a high paid CEO of a mining company, visiting one of your company's holdings in this sector. Flush with cash, you thought this would also be a vacation opportunity for you.|r\n|cff00FF00There seems to be some sort of trouble, however. Something about aliens and mutants, you don't care. Just make sure that someone gets to the bottom of it fast so you can get to your martinis.|r"
            endif 
        endmethod

        method applyRoleProperties takes MetaPlayer metaPlayer returns nothing
            if this.butler == 0 then
                set this.butler = RoboButler_Bind(metaPlayer.hero)
            else
                call this.butler.show(true)
            endif
        endmethod

        //RoboButler is by default set to delete itself on owner death
        method removeRoleProperties takes MetaPlayer metaPlayer returns nothing
            call this.butler.show(false)
        endmethod

        method getNamePrepension takes nothing returns string
            return "CEO"
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