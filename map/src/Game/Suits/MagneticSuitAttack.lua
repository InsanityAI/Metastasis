if Debug then Debug.beginFile "Game/Suits/MagneticSuitAttack" end
OnInit.trig("MagneticSuitAttack", function(require)
    ---@return boolean
    function Trig_MagneticSuitAttack_Conditions()
        if GetUnitTypeId(GetAttacker()) == FourCC('h04K') then
            return true
        end
        return false
    end

    ---@param r real
    ---@param a unit
    function SlivText(r, a)
        local b = GetUnitLoc(a) ---@type location
        local w = CreateTextTagLocBJ(I2S(R2I(r)), b, 90.00, 6.00, 100, 0.00, 0.00, 0) ---@type texttag
        AddSpecialEffect("Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl",
            GetUnitX(GetAttacker()) + 70 * Cos((GetUnitFacing(GetAttacker()) - 6) * bj_DEGTORAD),
            GetUnitY(GetAttacker()) + 70 * Sin((GetUnitFacing(GetAttacker()) - 6) * bj_DEGTORAD))
        PlaySoundAtPointBJ(gg_snd_AxeMissileLaunch1, 100, b, 0)
        SetTextTagVelocityBJ(w, 86.00, 90)
        SetTextTagPermanentBJ(w, false)
        SetTextTagFadepoint(w, 0.0)
        SetTextTagLifespanBJ(w, 2.00)
        SetTextTagVisibility(w, false)
        if IsLocationVisibleToPlayer(b, GetLocalPlayer()) then
            SetTextTagVisibility(w, true)
        end
        RemoveLocation(b)
    end

    function Trig_MagneticSuitAttack_Actions()
        local slivAttacks ---@type integer
        local magneticSlivedGroup ---@type group

        --If ally alien
        if (IsPlayerAlien(GetOwningPlayer(GetAttacker())) and IsPlayerAlien(GetOwningPlayer(GetTriggerUnit()))) and not (udg_AllowAlienTK) and not (IsPlayerMainInfected(GetOwningPlayer(GetAttacker()))) then
            return
        end

        --If ally mutant
        if (IsPlayerMutant(GetOwningPlayer(GetAttacker())) and IsPlayerMutant(GetOwningPlayer(GetTriggerUnit()))) and not (udg_AllowMutantTK) and not (IsPlayerMainInfected(GetOwningPlayer(GetAttacker()))) then
            return
        end

        --If already attacked before, use that handle, else create group and cache him
        if HaveSavedHandle(LS(), GetHandleId(GetAttacker()), StringHash("Suit_SlivGroup")) then
            magneticSlivedGroup = LoadGroupHandle(LS(), GetHandleId(GetAttacker()), StringHash("Suit_SlivGroup"))
            if magneticSlivedGroup == nil then
                magneticSlivedGroup = CreateGroup()
                SaveGroupHandle(LS(), GetHandleId(GetAttacker()), StringHash("Suit_SlivGroup"), magneticSlivedGroup)
            end
        else
            magneticSlivedGroup = CreateGroup()
            SaveGroupHandle(LS(), GetHandleId(GetAttacker()), StringHash("Suit_SlivGroup"), magneticSlivedGroup)
        end

        --If target already has slivs, use the cache to get how many hits he has already taken
        if HaveSavedInteger(LS(), GetHandleId(magneticSlivedGroup), GetHandleId(GetTriggerUnit())) then
            slivAttacks = LoadInteger(LS(), GetHandleId(magneticSlivedGroup), GetHandleId(GetTriggerUnit()))
        else
            slivAttacks = 0
        end

        --Weird check, this is a debug spagghetti, as it should never be checked, so whatever.
        if IsUnitInGroup(GetTriggerUnit(), magneticSlivedGroup) == false then
            slivAttacks = 0
            GroupAddUnit(magneticSlivedGroup, GetTriggerUnit())
        end

        --/DEBUG//TODO REMOVE!
        --/call DisplayTextToForce(GetPlayersAll(), "Before attacking - Slivs")
        --/call DisplayTextToForce(GetPlayersAll(), I2S(slivAttacks))

        --If max sliv attacks
        if slivAttacks > 11 then
            --Show sliv number text over the unit
            SlivText((I2R(slivAttacks)) * 25.0, GetTriggerUnit())

            --Special Effect (to show unit has maxed out on slivs)
            AddSpecialEffect("Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl", GetUnitX(GetTriggerUnit()),
                GetUnitY(GetTriggerUnit()))
            SFXThreadClean()
        else
            --Show sliv number text over the unit
            SlivText((I2R(slivAttacks) + 1) * 25.0, GetTriggerUnit())

            --Increment slivAttacks by one.
            SaveInteger(LS(), GetHandleId(magneticSlivedGroup), GetHandleId(GetTriggerUnit()), slivAttacks + 1)
        end

        --If you want to debug the 300 dmg bug, you should:
        --1. put a PRINT(slivAttacks) so as to check if it exceeds 11
        --2. go to muh detonate trigger and check it out.
        --3. Last resort is checking how it goes by removing suit and re-putting it.
    end

    --===========================================================================
    gg_trg_MagneticSuitAttack = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_MagneticSuitAttack, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_MagneticSuitAttack, Condition(Trig_MagneticSuitAttack_Conditions))
    TriggerAddAction(gg_trg_MagneticSuitAttack, Trig_MagneticSuitAttack_Actions)
end)
if Debug then Debug.endFile() end
