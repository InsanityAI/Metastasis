if Debug then Debug.beginFile "Game/RandomEvents/CommissarPromotion" end
OnInit.map("CommissarPromotion", function(require)
    ---@return boolean
    function Trig_CommissarPromotion_Func003Func001C()
        if (not (udg_PlayerRole[GetConvertedPlayerId(GetEnumPlayer())] == 8)) then
            return false
        end
        return true
    end

    function Trig_CommissarPromotion_Func003A()
        if (Trig_CommissarPromotion_Func003Func001C()) then
            udg_TempBool = true
            udg_TempPlayer = GetEnumPlayer()
        else
        end
    end

    ---@return boolean
    function Trig_CommissarPromotion_Func004Func009C()
        if ((IsUnitAliveBJ(udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)]) == false)) then
            return true
        end
        if ((udg_TempBool == false)) then
            return true
        end
        if ((udg_TempPlayer == udg_Mutant)) then
            return true
        end
        if ((udg_TempPlayer == udg_Parasite)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_CommissarPromotion_Func004C()
        if (not Trig_CommissarPromotion_Func004Func009C()) then
            return false
        end
        return true
    end

    function Trig_CommissarPromotion_Actions()
        local name ---@type string
        udg_RandomEvent_On[1] = true
        udg_TempBool = false
        ForForce(GetPlayersAll(), Trig_CommissarPromotion_Func003A)
        if (Trig_CommissarPromotion_Func004C()) then
            StartTimerBJ(udg_RandomEvent, false, 1.00)
        else
            StartTimerBJ(udg_RandomEvent, false, GetRandomReal(180.00, 900.00))
            DisplayTextToForce(GetPlayersAll(),
                (GetPlayerName(udg_TempPlayer) + " |cff00FF40has received a promotion!|r"))
            DisplayTextToPlayer(udg_TempPlayer, 0, 0,
                "|cffffcc00You have recieved the Operative suit. Thank you for your dedication to the United Security Initiative and the future of humanity.|r")
            udg_TempString = SubStringBJ(GetPlayerName(udg_TempPlayer),
                (StringLength(udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)]) + 1), 99)
            udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] = "Rebarch "
            name = udg_NamePrepension[GetConvertedPlayerId(udg_TempPlayer)] + udg_TempString
            SetPlayerName(udg_TempPlayer, name)
            StateGrid_SetPlayerName(udg_TempPlayer, name)
            UnitAddItemByIdSwapped(FourCC('I00X'), udg_Playerhero[GetConvertedPlayerId(udg_TempPlayer)])
        end
    end

    --===========================================================================
    gg_trg_CommissarPromotion = CreateTrigger()
    DisableTrigger(gg_trg_CommissarPromotion)
    TriggerAddAction(gg_trg_CommissarPromotion, Trig_CommissarPromotion_Actions)
end)
if Debug then Debug.endFile() end
