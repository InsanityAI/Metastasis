function CamCommand_Actions takes nothing returns nothing 
    local integer i = 0 

    //What is the default wc3 camera distance? 
    set udg_CameraDistanceTemp = 1650 
    
    //-cam X (e.g. -cam 4) 
    if StringLength(GetEventPlayerChatString()) >= 6 then 
        set udg_CameraDistanceTemp = S2I(SubString(GetEventPlayerChatString(), 5, StringLength(GetEventPlayerChatString()))) 
        if udg_CameraDistanceTemp <= 4 and udg_CameraDistanceTemp >= 1 then 
            set udg_CameraDistanceTemp = (1650 + ((udg_CameraDistanceTemp - 1) * 200)) 
        else 
            set udg_CameraDistanceTemp = 1650 
        endif 
    endif 
    
    //-cam YYYY (e.g. -cam 1821) 
    if StringLength(GetEventPlayerChatString()) >= 8 then 
        set udg_CameraDistanceTemp = S2I(SubString(GetEventPlayerChatString(), 5, StringLength(GetEventPlayerChatString()))) 
    endif 
    
    if(GetLocalPlayer() == GetTriggerPlayer()) then 
        call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, I2R(udg_CameraDistanceTemp), 0.20) 
    endif 
    
    loop 
        exitwhen i > 11 
        if GetTriggerPlayer() == Player(i) then 
            set udg_CameraDistanceAuto[i] = udg_CameraDistanceTemp 
        endif 
        
        set i = i + 1 
    endloop 
    
endfunction 

function InitTrig_CamCommand takes nothing returns nothing 
    local integer i = 0 
    
    set gg_trg_CamCommand = CreateTrigger() 
    
    loop 
        exitwhen i > 11 
        call TriggerRegisterPlayerChatEvent(gg_trg_CamCommand, Player(i), "-cam", false) 
        set i = i + 1 
    endloop 
    
    call TriggerAddAction(gg_trg_CamCommand, function CamCommand_Actions) 
endfunction