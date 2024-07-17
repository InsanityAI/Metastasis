if Debug then Debug.beginFile "Game/Stations/ST6/ST6Console" end
OnInit.trig("ST6Console", function(require)
    function Trig_ST6Console_Actions()
        DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0,
            "|cffFF8040Activation code |r" .. I2S(udg_Secret_ControlCode) .. "|cffFF8040. Please proceed with caution.|r")
    end

    --===========================================================================
    gg_trg_ST6Console = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_ST6Console, gg_rct_ST6Console)
    TriggerAddAction(gg_trg_ST6Console, Trig_ST6Console_Actions)
end)
if Debug then Debug.endFile() end
