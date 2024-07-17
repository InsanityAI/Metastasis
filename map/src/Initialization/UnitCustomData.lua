if Debug then Debug.beginFile "Initialization/UnitCustomData" end
OnInit.map("UnitCustomData", function(require)
    LIBRARY_unitData = true
    local SCOPE_PREFIX = "unitData_" ---@type string requires LS

    ---@param a unit
    ---@return real
    function GetUnitMass(a)
        local r = LoadReal(LS(), GetUnitTypeId(a), StringHash("CustomData_Mass")) ---@type real
        if r == 0 then
            return 100.0
        else
            return r
        end
    end

    ---@param unitid integer
    ---@param mass real
    function SaveMass(unitid, mass)
        SaveReal(LS(), unitid, StringHash("CustomData_Mass"), mass)
    end

    --===========================================================================
    --Units with a mass of 100 are not represented here.
    SaveMass(FourCC('h02X'), 2000.0) --Alien coccoon
    SaveMass(FourCC('h02U'), 330.0)  --Penguin android
    SaveMass(FourCC('h02F'), 330.0)  --Surbeit Chassis
    SaveMass(FourCC('h00B'), 130.0)  --Defense drone
    SaveMass(FourCC('h02S'), 4000.0) --Grounded albadar
    SaveMass(FourCC('h02I'), 3500.0) --Grounded hunter
    SaveMass(FourCC('h02K'), 2500.0) --Grounded obda
    SaveMass(FourCC('h001'), 3000.0) --Grounded raptor
    SaveMass(FourCC('h03K'), 3000.0) --Grounded sheepyship
    SaveMass(FourCC('h00H'), 80.0)   --Unsuited personnel
    SaveMass(FourCC('h00K'), 95.0)   --Chainsaw suit
    SaveMass(FourCC('h00E'), 130.0)  --Flamethrower suit
    SaveMass(FourCC('h02G'), 110.0)  --Guard suit
    SaveMass(FourCC('h00M'), 130.0)  --Illusory suit apparently...?
    SaveMass(FourCC('h00F'), 90.0)   --Photon suit
    SaveMass(FourCC('h00C'), 120.0)  --Rocket suit
    SaveMass(FourCC('h027'), 80.0)   --Scientist suit
    SaveMass(FourCC('h033'), 110.0)  --Masquerader
    SaveMass(FourCC('h02M'), 110)    --T1 alien
    SaveMass(FourCC('h03E'), 150.0)  --T2 power alien
    SaveMass(FourCC('h03G'), 275.0)  --T3 basilisk
    SaveMass(FourCC('h03A'), 120.0)  --T3 combustion
    SaveMass(FourCC('h037'), 275.0)  --T3 electricity
    SaveMass(FourCC('h03P'), 175.0)  --T3 regeneration
    SaveMass(FourCC('h03V'), 180.0)  --T3 webspinner
    SaveMass(FourCC('h03Q'), 80.0)   --Regeneration core
    SaveMass(FourCC('h03F'), 130.0)  --T2 Power alien spawn
    SaveMass(FourCC('h03H'), 200.0)  --Basilisk spawn
    SaveMass(FourCC('h03B'), 120.0)  --Combustion spawn
    SaveMass(FourCC('h039'), 275.0)  --Electricity spawn
    SaveMass(FourCC('h03R'), 165.0)  --T3 regeneration spawn
    SaveMass(FourCC('h03W'), 180.0)  --Webspinner spawn
    SaveMass(FourCC('h03S'), 80.0)   --Alien spawn core
    SaveMass(FourCC('h01U'), 50.0)   --Carrier sack
    SaveMass(FourCC('h01T'), 160.0)  --Harbinger
    SaveMass(FourCC('h01K'), 180.0)  --Complete infection mutant
    SaveMass(FourCC('h01V'), 250.0)  --Defiler mutant
    SaveMass(FourCC('h01G'), 1000.0) --Flesh golem mutant
    SaveMass(FourCC('h01C'), 80.0)   --Gargoyle mutant
    SaveMass(FourCC('h01I'), 120.0)  --Human development mutant
    SaveMass(FourCC('h01H'), 260.0)  --Minotaur mutant
    SaveMass(FourCC('h00U'), 125.0)  --Perfection mutant
    SaveMass(FourCC('h01L'), 115.0)  --Rapid gestation mutant
    SaveMass(FourCC('h01D'), 175.0)  --Stalker mutant
    SaveMass(FourCC('h01E'), 400.0)  --Strength mutant
    SaveMass(FourCC('h01O'), 120.0)  --Sustained development mutant (scorpion)
    SaveMass(FourCC('h01N'), 115.0)  --Complete infection spawn
    SaveMass(FourCC('h01X'), 175.0)  --Defiler spawn
    SaveMass(FourCC('h01Y'), 175.0)  --Overlord spawn
    SaveMass(FourCC('h01M'), 115.0)  --Rapid gestation spawn
    SaveMass(FourCC('h01P'), 30.0)   --Spiderling
    SaveMass(FourCC('h01S'), 30.0)   --Swarm beetle
    SaveMass(FourCC('h022'), 165.0)  --Overlord tentacle unit
    SaveMass(FourCC('h01W'), 20.0)   --Defiler worm
    SaveMass(FourCC('h01Q'), 4000.0) --Overlord mutant
    SaveMass(FourCC('h04Q'), 80.0)   --Cage

    --Consoles
    SaveMass(FourCC('h000'), 999999999.0)
    SaveMass(FourCC('h00Y'), 999999999.0)
    SaveMass(FourCC('h04B'), 999999999.0)
    SaveMass(FourCC('h006'), 999999999.0)
    SaveMass(FourCC('h048'), 999999999.0)
    SaveMass(FourCC('h00A'), 999999999.0)
    SaveMass(FourCC('h02A'), 999999999.0)
    SaveMass(FourCC('h004'), 999999999.0)
end)
if Debug then Debug.endFile() end
