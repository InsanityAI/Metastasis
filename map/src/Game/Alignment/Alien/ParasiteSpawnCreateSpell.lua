if Debug then Debug.beginFile "Game/Allignment/Alien/ParasiteSpawnCreateSpell" end
OnInit.map("ParasiteSpawnCreateSpell", function(require)
    function Trig_ParasiteSpawnCreateSpell_Actions()
        CreateNUnitsAtLoc(1, FourCC('e00M'), udg_TempPlayer, udg_HoldZone, bj_UNIT_FACING)
        CreateNUnitsAtLoc(1, FourCC('e00P'), udg_TempPlayer, udg_HoldZone, bj_UNIT_FACING)
        CreateNUnitsAtLoc(1, FourCC('e015'), udg_TempPlayer, udg_HoldZone, bj_UNIT_FACING)
    end

    --===========================================================================
    gg_trg_ParasiteSpawnCreateSpell = CreateTrigger()
    TriggerAddAction(gg_trg_ParasiteSpawnCreateSpell, Trig_ParasiteSpawnCreateSpell_Actions)
end)
if Debug then Debug.endFile() end
