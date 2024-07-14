//TESH.scrollpos=0
//TESH.alwaysfold=0
function CamAuto_Actions takes nothing returns nothing
    local integer i = 0
    
    loop
        exitwhen i > 11
        if (GetLocalPlayer() == Player(i)) then
            if udg_CameraDistanceAuto[i] != 1650 then
                call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, I2R(udg_CameraDistanceAuto[i]), 0.00)
            endif
        endif
        
        set i = i + 1
    endloop
endfunction

function InitTrig_CamAuto takes nothing returns nothing
    set gg_trg_CamAuto = CreateTrigger()
    call DisableTrigger(gg_trg_CamAuto)
    
    call TriggerRegisterTimerEvent(gg_trg_CamAuto, 1.00, true)
    call TriggerAddAction(gg_trg_CamAuto, function CamAuto_Actions)
endfunction