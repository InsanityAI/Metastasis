if Debug then Debug.beginFile "System/ChatSys/ChatGroupBroadcast" end
OnInit.map("ChatGroupBroadcast", function(require)
    ---@return boolean
    function Trig_ChatGroupBroadcast_Conditions()
        if (not (SubStringBJ(GetEventPlayerChatString(), 1, 1) == ";")) then
            return false
        end
        if (not (IsPlayerInForce(GetTriggerPlayer(), udg_DeadGroup) ~= true)) then
            return false
        end
        return true
    end

    function Trig_ChatGroupBroadcast_Func007Func001A()
        if (IsPlayerInForce(GetEnumPlayer(), udg_DeadGroup) == true) then
            ForceRemovePlayerSimple(GetEnumPlayer(), udg_TempPlayerGroup)
        end
    end

    --Some light sheds the shadows of the overwhelming spagghettis...
    --If only a BHD could consume this code kappa
    ---@param spaceObjectIndex integer
    function CreateSlugglyAssassin(spaceObjectIndex)
        udg_TempPoint = Location(udg_SpaceObject_SlugglyAssassinX[udg_TempInt],
            udg_SpaceObject_SlugglyAssassinY[udg_TempInt])
        CreateNUnitsAtLoc(1, FourCC('n008'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING)
        AddSpecialEffectLocBJ(udg_TempPoint, "Objects\\Spawnmodels\\NightElf\\NEDeathSmall\\NEDeathSmall.mdl")
        SFXThreadClean()
        udg_TempUnit = GetLastCreatedUnit()
        ExecuteFunc("SlugglyAssassinAIForTempUnit")
        RemoveLocation(udg_TempPoint)
    end

    function Trig_ChatGroupBroadcast_Actions()
        ExecuteFunc("ClearArguments")
        ExecuteFunc("ParseEnteredString")
        udg_arguments[1] = SubStringBJ(udg_arguments[1], 3, 99)
        udg_TempString = udg_arguments[1]
        udg_TempPlayerGroup = LoadForceHandle(LS(), GetHandleId(udg_ChatGroupStore), StringHash(udg_TempString))
        bj_forLoopAIndex = 3
        bj_forLoopAIndexEnd = 100
        while bj_forLoopAIndex <= bj_forLoopAIndexEnd do
            udg_arguments[2] = (udg_arguments[2] + (" " + udg_arguments[GetForLoopIndexA()]))
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
        if (IsPlayerInForce(GetTriggerPlayer(), udg_TempPlayerGroup) == true) then
            ForForce(udg_TempPlayerGroup, Trig_ChatGroupBroadcast_Func007Func001A)
            DisplayTextToForce(udg_TempPlayerGroup,
                ("|cff808040" + (("[" + (udg_arguments[1] + ("]|r" + PlayerColor_GetPlayerTextColor(GetTriggerPlayer()) + GetPlayerName(GetTriggerPlayer())))) + ("|r: " + udg_arguments[2]))))
            DisplayTextToForce(udg_DeadGroup,
                ("|cff808040" + (("[" + (udg_arguments[1] + ("]|r" + PlayerColor_GetPlayerTextColor(GetTriggerPlayer()) + GetPlayerName(GetTriggerPlayer())))) + ("|r: " + udg_arguments[2]))))
        end

        --Gosh, no secrets here.
        --5.83095189 OSK_REACTIVATE()
        if StringHash(";" + udg_arguments[1] + " " + SubStringBJ(udg_arguments[2], 1, 15) + ")") == -1272370587 then
            --This line seems to be the one which shows the UFO code
            --call DisplayTextToPlayer(GetLocalPlayer(),0,0, SubStringBJ(udg_arguments[2],16,19) + "-" + I2S(udg_Secret_ControlCode))

            --RandomEvent[2] is the UFO event.
            if udg_RandomEvent_On[2] == true and I2S(udg_Secret_ControlCode) == SubStringBJ(udg_arguments[2], 16, 19) then
                --There was a timer limit here. It doesn't exist anymore.

                PlaySoundBJ(gg_snd_GameError)
                udg_Secret_ControlCode = 9999999999
                DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "|cff808000Protocol accepted. Test device now active.")
                CreateItem(FourCC('I01F'), 11606.7, -3125)
                CreateDestructable(FourCC('XTmp'), 11606.7, -3125, 270.0, 1, 1)
                AddSpecialEffect("war3mapImported\\AncientExplode.mdl", 11606.7, -3125)

                SFXThreadClean()

                --==================================================================================
                --===Creates sluggly assassin(s?) below, with spaceObject_SlugglyAssassinX&Y[1~5]===
                --==================================================================================
                udg_TempInt = 1
                udg_TempInt2 = 5
                while udg_TempInt <= udg_TempInt2 do
                    CreateSlugglyAssassin(udg_TempInt)

                    udg_TempInt = udg_TempInt + 1
                end

                CreateSlugglyAssassin(8)
                CreateSlugglyAssassin(22)



                --Old fel version, which are literally the above 2(!) fucking lines
                --set udg_TempInt=8
                --set udg_TempInt2=22
                --loop
                --exitwhen udg_TempInt > udg_TempInt2

                --set udg_TempPoint = Location(udg_SpaceObject_SlugglyAssassinX[udg_TempInt],udg_SpaceObject_SlugglyAssassinY[udg_TempInt])
                --call CreateNUnitsAtLoc( 1, FourCC('n008'), Player(PLAYER_NEUTRAL_PASSIVE), udg_TempPoint, bj_UNIT_FACING )
                --call AddSpecialEffectLocBJ( udg_TempPoint, "Objects\\Spawnmodels\\NightElf\\NEDeathSmall\\NEDeathSmall.mdl" )
                --call SFXThreadClean()
                --set udg_TempUnit=GetLastCreatedUnit()
                --call ExecuteFunc("SlugglyAssassinAIForTempUnit")
                --call RemoveLocation( udg_TempPoint )

                --set udg_TempInt = udg_TempInt + 14
                --endloop
            else
                DisplayTextToPlayer(GetTriggerPlayer(), 0, 0,
                    "|cff808000Error. Incorrect priming code- please consult Noth station mainframe.")
            end
            return
        end
    end

    --===========================================================================
    local i                   = 0 ---@type integer
    gg_trg_ChatGroupBroadcast = CreateTrigger()
    while i <= 11 do
        TriggerRegisterPlayerChatEvent(gg_trg_ChatGroupBroadcast, Player(i), ";", false)
        i = i + 1
    end
    TriggerAddCondition(gg_trg_ChatGroupBroadcast, Condition(Trig_ChatGroupBroadcast_Conditions))
    TriggerAddAction(gg_trg_ChatGroupBroadcast, Trig_ChatGroupBroadcast_Actions)
end)
if Debug then Debug.endFile() end
