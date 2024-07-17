if Debug then Debug.beginFile "Initialization/DeathSysClick" end
OnInit.map("DeathSysClick", function(require)
    function Trig_DeathSysClick_Func003Func002Func003A()
        DialogDisplayBJ(false, udg_DeathVoteDialog, GetEnumPlayer())
    end

    ---@return boolean
    function Trig_DeathSysClick_Func003Func002C()
        if (not (udg_InstantBootMode_Votes >= (CountPlayersInForceBJ(GetPlayersAll()) / 2))) then
            return false
        end
        return true
    end

    function Trig_DeathSysClick_Func003Func003Func004Func003A()
        DialogDisplayBJ(false, udg_DeathVoteDialog, GetEnumPlayer())
    end

    ---@return boolean
    function Trig_DeathSysClick_Func003Func003Func004C()
        if (not (udg_InstantBootMode_Votes >= (CountPlayersInForceBJ(GetPlayersAll()) / 2))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_DeathSysClick_Func003Func003C()
        if (not (GetClickedButtonBJ() == udg_DeathVoteDialog_Buttons[2])) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_DeathSysClick_Func003C()
        if (not (GetClickedButtonBJ() == udg_DeathVoteDialog_Buttons[1])) then
            return false
        end
        return true
    end

    function Trig_DeathSysClick_Actions()
        -- Voting. Since Spectator mode is default, the voting really only ends if enough votes accumulate for Instant Boot mode.
        if (Trig_DeathSysClick_Func003C()) then
            DisplayTextToForce(GetPlayersAll(),
                (GetPlayerName(GetTriggerPlayer()) + " |cffFF8000has voted for spectator mode!|r"))
            if (Trig_DeathSysClick_Func003Func002C()) then
                DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2358")
                udg_DeathType = 1
                ForForce(GetPlayersAll(), Trig_DeathSysClick_Func003Func002Func003A)
            else
            end
        else
            if (Trig_DeathSysClick_Func003Func003C()) then
                udg_InstantBootMode_Votes = (udg_InstantBootMode_Votes + 1)
                DisplayTextToForce(GetPlayersAll(),
                    (GetPlayerName(GetTriggerPlayer()) + " |cffFF8000has voted for instant-boot mode!|r"))
                if (Trig_DeathSysClick_Func003Func003Func004C()) then
                    DisplayTextToForce(GetPlayersAll(), "TRIGSTR_2355")
                    udg_DeathType = 2
                    ForForce(GetPlayersAll(), Trig_DeathSysClick_Func003Func003Func004Func003A)
                else
                end
            else
                DialogDisplayBJ(true, udg_DeathVoteDialog, GetTriggerPlayer())
            end
        end
    end

    --===========================================================================
    gg_trg_DeathSysClick = CreateTrigger()
    TriggerRegisterDialogEventBJ(gg_trg_DeathSysClick, udg_DeathVoteDialog)
    TriggerAddAction(gg_trg_DeathSysClick, Trig_DeathSysClick_Actions)
end)
if Debug then Debug.endFile() end
