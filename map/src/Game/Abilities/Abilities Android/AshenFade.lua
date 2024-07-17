if Debug then Debug.beginFile "Game/Abilities/Android/AshenFade" end
OnInit.trig("AshenFade", function(require)
    ---@return boolean
    function Trig_AshenFade_Func002Func001C()
        if (not (IsUnitAliveBJ(GetEnumUnit()) == true)) then
            return false
        end
        return true
    end

    function Trig_AshenFade_Func002A()
        if (Trig_AshenFade_Func002Func001C()) then
            -- Damage it for 1 dmg
            UnitDamageTarget(GetEnumUnit(), GetEnumUnit(), 1, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL,
                WEAPON_TYPE_WHOKNOWS)
        else
        end
    end

    function Trig_AshenFade_Actions()
        ForGroupBJ(udg_AshenMarineGroup, Trig_AshenFade_Func002A)
    end

    --===========================================================================
    gg_trg_AshenFade = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_AshenFade, udg_AshenMarineFadeTimer)
    TriggerAddAction(gg_trg_AshenFade, Trig_AshenFade_Actions)
end)
if Debug then Debug.endFile() end
