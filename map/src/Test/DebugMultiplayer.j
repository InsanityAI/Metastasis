//TESH.scrollpos=13
//TESH.alwaysfold=0
globals
    integer playersToggled = 0
    integer playersActive = 0
endglobals

function Trig_DebugMultiplayer_Conditions takes nothing returns boolean
    return true
endfunction

function SetActivePlayers takes nothing returns nothing
    if GetPlayerSlotState(GetEnumPlayer()) == PLAYER_SLOT_STATE_PLAYING and udg_Player_Left[GetConvertedPlayerId(GetEnumPlayer())] == false then
        set playersActive = playersActive + 1
    endif
endfunction

function Trig_DebugMultiplayer_Actions takes nothing returns nothing

    //If not toggled before (it toggles only once for obvious reasons)
    if udg_PlayerDebugMultiplayerToggled[GetPlayerId(GetTriggerPlayer())] == false then
        set udg_PlayerDebugMultiplayerToggled[GetPlayerId(GetTriggerPlayer())] = true//So it won't enter here again
                
        //Increase players toggled by one
        set playersToggled = playersToggled + 1
        
        
        //Enumerate/Count how many players there are ((sets playersActive))
        set playersActive = 0
        call ForForce(GetPlayersAll(), function SetActivePlayers)
        
        call DisplayTextToForce(GetPlayersAll(), I2S(playersToggled) + "/" + I2S(playersActive) + " have voted for Debugging mode.")
        
        //If all players wrote -debug, activate it.
        if (playersToggled == playersActive) then
            set udg_TESTING = true
            
            call DisplayTextToForce(GetPlayersAll(), "Debugging Mode A C T I V A T E D" )
        endif
    endif
    
endfunction

//===========================================================================
function InitTrig_DebugMultiplayer takes nothing returns nothing
    local integer i=0
    set gg_trg_DebugMultiplayer = CreateTrigger()
    
    loop
    exitwhen i>11
        call TriggerRegisterPlayerChatEvent( gg_trg_DebugMultiplayer, Player(i), "-debug", false )
        set i=i+1
    endloop
    
    call TriggerAddCondition( gg_trg_DebugMultiplayer, Condition( function Trig_DebugMultiplayer_Conditions ) )
    call TriggerAddAction( gg_trg_DebugMultiplayer, function Trig_DebugMultiplayer_Actions )
endfunction