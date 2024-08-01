library BHD requires Timeout, CSAPI, StringUtil 
    globals 
        public boolean isCommand = false 
    endglobals 

    //Some light sheds the shadows of the overwhelming spagghettis...   
    //If only a BHD could consume this code kappa   
    private function CreateSlugglyAssassin takes integer spaceObjectIndex returns nothing 
        set udg_TempPoint = Location(udg_SpaceObject_SlugglyAssassinX[spaceObjectIndex], udg_SpaceObject_SlugglyAssassinY[spaceObjectIndex]) 
        call CreateNUnitsAtLoc(1, 'n008', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING) 
        call AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\NightElf\\NEDeathSmall\\NEDeathSmall.mdl") 
        call SFXThreadClean() 
        set udg_TempUnit = GetLastCreatedUnit() 
        call ExecuteFunc("SlugglyAssassinAIForTempUnit") 
        call RemoveLocation(udg_TempPoint) 
    endfunction 

    public function CheckAndSpawn takes player initiator, string message returns nothing 
        if SubString(message, 0, 1) != ";" then 
            set isCommand = false 
            return 
        endif 
        set isCommand = true 
        call StringUtil_ParseStringWithArgc(message, 2) 
        //Gosh, no secrets here.   
        //5.83095189 OSK_REACTIVATE()   
        if StringHash(";" + SubString(StringUtil_argv[0], 1, StringLength(StringUtil_argv[0])) + " " + SubStringBJ(StringUtil_argv[1], 1, 15) + ")") == -1272370587 then 
            if IsPlayerInForce(initiator, udg_DeadGroup) then 
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cFFFF0000Error: Cannot activate this while dead!") 
                return 
            endif 

            //RandomEvent[2] is the UFO event.   
            if udg_RandomEvent_On[2] == true and I2S(udg_Secret_ControlCode) == SubStringBJ(StringUtil_argv[1], 16, 19) then 
                call PlaySoundBJ(gg_snd_GameError) 
                set udg_Secret_ControlCode = 9999999999 
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cff808000Protocol accepted. Test device now active.") 
                call CreateItem('I01F', 11606.7, -3125) 
                call CreateDestructable('XTmp', 11606.7, -3125, 270.0, 1, 1) 
                call AddSpecialEffect("war3mapImported\\AncientExplode.mdl", 11606.7, -3125) 
                call SFXThreadClean() 
            
                //==================================================================================   
                //===Creates sluggly assassin(s?) below, with spaceObject_SlugglyAssassinX&Y[1~5]===   
                //==================================================================================   
                set udg_TempInt = 1 
                loop 
                    exitwhen udg_TempInt > 5 
                    call CreateSlugglyAssassin(udg_TempInt) 
                    set udg_TempInt = udg_TempInt + 1 
                endloop 
            
                call CreateSlugglyAssassin(8) 
                call CreateSlugglyAssassin(22) 
            else 
                call CSAPI_sendSystemMessageToPlayer(initiator, "|cff808000Error. Incorrect priming code- please consult Noth station mainframe.") 
            endif 
            return 
        endif 
    endfunction 
endlibrary