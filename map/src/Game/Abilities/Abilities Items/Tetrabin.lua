if Debug then Debug.beginFile "Game/Abilities/Items/Tetrabin" end
OnInit.trig("Tetrabin", function(require)
    ---@return boolean
    function Trig_Tetrabin_Conditions()
        if (not (GetItemTypeId(GetManipulatedItem()) == FourCC('I01K'))) then
            return false
        end
        if (not (GetTriggerUnit() == udg_Playerhero[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func005C()
        if (not (udg_HiddenAndroid == GetOwningPlayer(GetTriggerUnit()))) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func006Func004C()
        if ((udg_Parasite == GetOwningPlayer(GetTriggerUnit()))) then
            return true
        end
        if ((udg_Player_IsParasiteSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == true)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Tetrabin_Func006C()
        if (not Trig_Tetrabin_Func006Func004C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func007Func004C()
        if ((udg_Mutant == GetOwningPlayer(GetTriggerUnit()))) then
            return true
        end
        if ((udg_Player_IsMutantSpawn[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] == true)) then
            return true
        end
        return false
    end

    ---@return boolean
    function Trig_Tetrabin_Func007C()
        if (not Trig_Tetrabin_Func007Func004C()) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func010C()
        if (not (GetRandomInt(1, 2) ~= 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func012Func001Func001Func002C()
        if not (GetLocalPlayer() == GetOwningPlayer(GetManipulatingUnit())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func001C()
        if not (GetLocalPlayer() == GetOwningPlayer(GetManipulatingUnit())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002Func001Func003Func002C()
        if not (GetLocalPlayer() == GetOwningPlayer(GetManipulatingUnit())) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002Func001Func003C()
        if (not (GetRandomInt(1, 2) == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002Func001C()
        if (not (udg_TempInt == 7)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002C()
        if (not (udg_TempInt == 6)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func012Func001Func001Func003Func001Func001C()
        if (not (udg_TempInt == 5)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func012Func001Func001Func003Func001C()
        if (not (udg_TempInt == 4)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func012Func001Func001Func003C()
        if (not (udg_TempInt == 3)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func012Func001Func001C()
        if (not (udg_TempInt == 2)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func012Func001C()
        if (not (udg_TempInt == 1)) then
            return false
        end
        return true
    end

    ---@return boolean
    function Trig_Tetrabin_Func012C()
        if (not (udg_TempInt == 0)) then
            return false
        end
        return true
    end

    function Trig_Tetrabin_Actions()
        -- Addition: Evils take EP and destroy it
        if (Trig_Tetrabin_Func005C()) then
            RemoveItem(GetManipulatedItem())
            return
        else
        end
        if (Trig_Tetrabin_Func006C()) then
            udg_UpgradePointsAlien = (udg_UpgradePointsAlien + 700.00)
            RemoveItem(GetManipulatedItem())
            return
        else
        end
        if (Trig_Tetrabin_Func007C()) then
            udg_UpgradePointsMutant = (udg_UpgradePointsMutant + 700.00)
            RemoveItem(GetManipulatedItem())
            return
        else
        end
        -- ------
        SetPlayerTechResearchedSwap(FourCC('R00A'),
            (GetPlayerTechCountSimple(FourCC('R00A'), GetOwningPlayer(GetTriggerUnit())) + 1),
            GetOwningPlayer(GetTriggerUnit()))
        if (Trig_Tetrabin_Func010C()) then
            udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] = (udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))] + 1)
        else
        end
        udg_TempInt = udg_Player_TetrabinLevel[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]
        if (Trig_Tetrabin_Func012C()) then
        else
            if (Trig_Tetrabin_Func012Func001C()) then
                CameraSetTargetNoiseForPlayer(GetOwningPlayer(GetTriggerUnit()), 120.00, 1.20)
            else
                if (Trig_Tetrabin_Func012Func001Func001C()) then
                    CameraSetTargetNoiseForPlayer(GetOwningPlayer(GetTriggerUnit()), 240.00, 2.40)
                    if (Trig_Tetrabin_Func012Func001Func001Func002C()) then
                        NewSoundEnvironment("psychotic")
                    else
                    end
                else
                    if (Trig_Tetrabin_Func012Func001Func001Func003C()) then
                        CameraSetTargetNoiseForPlayer(GetOwningPlayer(GetTriggerUnit()), 480.00, 4.80)
                    else
                        if (Trig_Tetrabin_Func012Func001Func001Func003Func001C()) then
                            CameraSetTargetNoiseForPlayer(GetOwningPlayer(GetTriggerUnit()), 920.00, 9.20)
                        else
                            if (Trig_Tetrabin_Func012Func001Func001Func003Func001Func001C()) then
                                if (Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func001C()) then
                                    SetDayNightModels("r.mdx", "r.mdx")
                                else
                                end
                            else
                                if (Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002C()) then
                                    CreateFogModifierRectBJ(true, GetOwningPlayer(GetManipulatingUnit()),
                                        FOG_OF_WAR_MASKED, GetPlayableMapRect())
                                else
                                    if (Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002Func001C()) then
                                        CameraSetTargetNoiseForPlayer(GetOwningPlayer(GetTriggerUnit()), 1500.00, 15.00)
                                        if (Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002Func001Func003C()) then
                                            if (Trig_Tetrabin_Func012Func001Func001Func003Func001Func001Func002Func001Func003Func002C()) then
                                                ExecuteFunc("TETRABINCRASHESTHEGAME")
                                            else
                                            end
                                        else
                                            ExplodeUnitBJ(udg_Playerhero
                                                [GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))])
                                        end
                                    else
                                        ExplodeUnitBJ(udg_Playerhero
                                            [GetConvertedPlayerId(GetOwningPlayer(GetManipulatingUnit()))])
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    --===========================================================================
    gg_trg_Tetrabin = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Tetrabin, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_Tetrabin, Condition(Trig_Tetrabin_Conditions))
    TriggerAddAction(gg_trg_Tetrabin, Trig_Tetrabin_Actions)
end)
if Debug then Debug.endFile() end
