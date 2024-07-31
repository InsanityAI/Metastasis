library CamCommand initializer init requires Commands, ChatSystem, StringUtil
    globals 
        private integer DEFAULT_CAMERA_DISTANCE = 1650 
    endglobals 

    struct CamCommand extends Command 
        public static method create takes nothing returns thistype 
            return thistype.allocate("cam", 2) 
        endmethod 

        public method execute takes player initiator, integer argc returns nothing 
            local integer cameraDistance = S2I(StringUtil_argv[1]) 
            local boolean isShortCommand = StringLength(StringUtil_argv[1]) == 1
            local integer i = 0 
    
            if isShortCommand then
                if cameraDistance <= 4 and cameraDistance >= 1 then 
                    set cameraDistance = (1650 + ((cameraDistance - 1) * 200)) 
                else 
                    set cameraDistance = 1650 
                endif 
            endif

            if(GetLocalPlayer() == initiator) then 
                call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, I2R(cameraDistance), 0.20) 
            endif 
    
            loop 
                exitwhen i > 11 
                if initiator == Player(i) then 
                    set udg_CameraDistanceAuto[i] = cameraDistance 
                endif 
        
                set i = i + 1 
            endloop 

            call ChatSystem_sendSystemMessageToPlayer(initiator, "Camera has been adjusted to " + I2S(cameraDistance) + ".")
        endmethod 
    endstruct 

    private function init takes nothing returns nothing 
        call CamCommand.create() 
    endfunction 
endlibrary 

