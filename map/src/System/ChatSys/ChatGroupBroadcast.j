//TESH.scrollpos=54
//TESH.alwaysfold=0
function Trig_ChatGroupBroadcast_Conditions takes nothing returns boolean
    if ( not ( SubStringBJ(GetEventPlayerChatString(), 1, 1) == ";" ) ) then
        return false
    endif
    if ( not ( IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) != true ) ) then
        return false
    endif
    return true
endfunction

function Trig_ChatGroupBroadcast_Func007Func001A takes nothing returns nothing
    if ( IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == true ) then
        call ForceRemovePlayerSimple( GetEnumPlayer(), udg_TempPlayerGroup )
    endif
endfunction

//Some light sheds the shadows of the overwhelming spagghettis...
//If only a BHD could consume this code kappa
function CreateSlugglyAssassin takes integer spaceObjectIndex returns nothing
    
    set udg_TempPoint = Location(udg_SpaceObject_SlugglyAssassinX[udg_TempInt],udg_SpaceObject_SlugglyAssassinY[udg_TempInt])
    call CreateNUnitsAtLoc( 1, 'n008', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
    call AddSpecialEffectLocBJ( udg_TempPoint, "Objects\\Spawnmodels\\NightElf\\NEDeathSmall\\NEDeathSmall.mdl" )
    call SFXThreadClean()
    set udg_TempUnit=GetLastCreatedUnit()
    call ExecuteFunc("SlugglyAssassinAIForTempUnit")
    call RemoveLocation( udg_TempPoint )
    
endfunction

function Trig_ChatGroupBroadcast_Actions takes nothing returns nothing
    call ExecuteFunc( "ClearArguments" )
    call ExecuteFunc( "ParseEnteredString" )
    set udg_arguments[1] = SubStringBJ(udg_arguments[1], 3, 99)
    set udg_TempString = udg_arguments[1]
    set udg_TempPlayerGroup=LoadForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(udg_TempString))
    set bj_forLoopAIndex = 3
    set bj_forLoopAIndexEnd = 100
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_arguments[2] = ( udg_arguments[2] + ( " " + udg_arguments[GetForLoopIndexA()] ) )
        set bj_forLoopAIndex = bj_forLoopAIndex + 1
    endloop
    if ( IsPlayerInForce(GetTriggerPlayer(), udg_TempPlayerGroup) == true ) then
        call ForForce( udg_TempPlayerGroup, function Trig_ChatGroupBroadcast_Func007Func001A )
        call DisplayTextToForce( udg_TempPlayerGroup, ( "|cff808040" + ( ( "[" + ( udg_arguments[1] + ( "]|r" + PlayerColor_GetByPlayer(GetTriggerPlayer()).color + GetPlayerName(GetTriggerPlayer()) ) ) ) + ( "|r: " + udg_arguments[2] ) ) ) )
        call DisplayTextToForce( udg_DeadGroup, ( "|cff808040" + ( ( "[" + ( udg_arguments[1] + ( "]|r" + PlayerColor_GetByPlayer(GetTriggerPlayer()).color  + GetPlayerName(GetTriggerPlayer()) ) ) ) + ( "|r: " + udg_arguments[2] ) ) ) )
    endif
    
    //Gosh, no secrets here.
    //5.83095189 OSK_REACTIVATE()
    if StringHash(";" + udg_arguments[1] + " " + SubStringBJ(udg_arguments[2],1,15)+")") == -1272370587 then
    
        //This line seems to be the one which shows the UFO code
        //call DisplayTextToPlayer(GetLocalPlayer(),0,0, SubStringBJ(udg_arguments[2],16,19) + "-" + I2S(udg_Secret_ControlCode))
        
        //RandomEvent[2] is the UFO event.
        if udg_RandomEvent_On[2] == true and I2S(udg_Secret_ControlCode)==SubStringBJ(udg_arguments[2],16,19) then

            //There was a timer limit here. It doesn't exist anymore.
        
            call PlaySoundBJ(gg_snd_GameError)
            set udg_Secret_ControlCode=9999999999
            call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cff808000Protocol accepted. Test device now active.")
            call CreateItem('I01F',11606.7,-3125)
            call CreateDestructable('XTmp',11606.7,-3125,270.0,1,1)
            call AddSpecialEffect("war3mapImported\\AncientExplode.mdl",11606.7,-3125)
        
            call SFXThreadClean()
        
            //==================================================================================
            //===Creates sluggly assassin(s?) below, with spaceObject_SlugglyAssassinX&Y[1~5]===
            //==================================================================================
            set udg_TempInt=1
            set udg_TempInt2=5
            loop
                exitwhen udg_TempInt > udg_TempInt2
            
                    call CreateSlugglyAssassin(udg_TempInt)
                    
                set udg_TempInt = udg_TempInt + 1
            endloop
        
            call CreateSlugglyAssassin(8)
            call CreateSlugglyAssassin(22)        
            
            

            //Old fel version, which are literally the above 2(!) fucking lines
            //set udg_TempInt=8
            //set udg_TempInt2=22
            //loop
                //exitwhen udg_TempInt > udg_TempInt2
            
                    //set udg_TempPoint = Location(udg_SpaceObject_SlugglyAssassinX[udg_TempInt],udg_SpaceObject_SlugglyAssassinY[udg_TempInt])
                    //call CreateNUnitsAtLoc( 1, 'n008', Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
                    //call AddSpecialEffectLocBJ( udg_TempPoint, "Objects\\Spawnmodels\\NightElf\\NEDeathSmall\\NEDeathSmall.mdl" )
                    //call SFXThreadClean()
                    //set udg_TempUnit=GetLastCreatedUnit()
                    //call ExecuteFunc("SlugglyAssassinAIForTempUnit")
                    //call RemoveLocation( udg_TempPoint )
                
                //set udg_TempInt = udg_TempInt + 14
            //endloop
            
        else
            call DisplayTextToPlayer(GetTriggerPlayer(),0,0,"|cff808000Error. Incorrect priming code- please consult Noth station mainframe.")    
        endif
        return
    endif
endfunction

//===========================================================================
function InitTrig_ChatGroupBroadcast takes nothing returns nothing
local integer i=0
    set gg_trg_ChatGroupBroadcast = CreateTrigger(  )
    loop
        exitwhen i > 11
            call TriggerRegisterPlayerChatEvent( gg_trg_ChatGroupBroadcast, Player(i), ";", false )
        set i=i+1
    endloop
    call TriggerAddCondition( gg_trg_ChatGroupBroadcast, Condition( function Trig_ChatGroupBroadcast_Conditions ) )
    call TriggerAddAction( gg_trg_ChatGroupBroadcast, function Trig_ChatGroupBroadcast_Actions )
endfunction

