if Debug then Debug.beginFile "Game/RandomEvents/News" end
OnInit.map("News", function(require)
    ---@return boolean
    function Trig_News_Func002C()
        if (not (udg_NewsString[udg_TempInt3] == "")) then
            return false
        end
        return true
    end

    function Trig_News_Actions()
        udg_TempInt3 = GetRandomInt(1, 12)
        if (Trig_News_Func002C()) then
            TriggerExecute(gg_trg_News)
            return
        else
        end
        DisplayTextToForce(GetPlayersAll(), ("|cff00FF00KIRZ95 News: |r" + udg_NewsString[udg_TempInt3]))
        udg_NewsString[udg_TempInt3] = ""
        StartTimerBJ(udg_RandomEvent, false, GetRandomReal(10.00, 300.00))
    end

    --===========================================================================
    gg_trg_News = CreateTrigger()
    DisableTrigger(gg_trg_News)
    TriggerAddAction(gg_trg_News, Trig_News_Actions)
end)
if Debug then Debug.endFile() end
