//TESH.scrollpos=0 
//TESH.alwaysfold=0 
library unitData requires LS 

    function GetUnitMass takes unit a returns real 
        local real r = LoadReal(LS(), GetUnitTypeId(a), StringHash("CustomData_Mass")) 
        if r == 0 then 
            return 100.0 
        else 
            return r 
        endif 
    endfunction 
    
    function SaveMass takes integer unitid, real mass returns nothing 
        call SaveReal(LS(), unitid, StringHash("CustomData_Mass"), mass) 
    endfunction 
    
endlibrary 
//=========================================================================== 
function InitTrig_UnitCustomData takes nothing returns nothing 

    //Units with a mass of 100 are not represented here. 
    call SaveMass('h02X', 2000.0) //Alien coccoon 
    call SaveMass('h02U', 330.0) //Penguin android 
    call SaveMass('h02F', 330.0) //Surbeit Chassis 
    call SaveMass('h00B', 130.0) //Defense drone 
    call SaveMass('h02S', 4000.0) //Grounded albadar 
    call SaveMass('h02I', 3500.0) //Grounded hunter 
    call SaveMass('h02K', 2500.0) //Grounded obda 
    call SaveMass('h001', 3000.0) //Grounded raptor 
    call SaveMass('h03K', 3000.0) //Grounded sheepyship 
    call SaveMass('h00H', 80.0) //Unsuited personnel 
    call SaveMass('h00K', 95.0) //Chainsaw suit 
    call SaveMass('h00E', 130.0) //Flamethrower suit 
    call SaveMass('h02G', 110.0) //Guard suit 
    call SaveMass('h00M', 130.0) //Illusory suit apparently...? 
    call SaveMass('h00F', 90.0) //Photon suit 
    call SaveMass('h00C', 120.0) //Rocket suit 
    call SaveMass('h027', 80.0) //Scientist suit 
    call SaveMass('h033', 110.0) //Masquerader 
    call SaveMass('h02M', 110) //T1 alien 
    call SaveMass('h03E', 150.0) //T2 power alien 
    call SaveMass('h03G', 275.0) //T3 basilisk 
    call SaveMass('h03A', 120.0) //T3 combustion 
    call SaveMass('h037', 275.0) //T3 electricity 
    call SaveMass('h03P', 175.0) //T3 regeneration 
    call SaveMass('h03V', 180.0) //T3 webspinner 
    call SaveMass('h03Q', 80.0) //Regeneration core 
    call SaveMass('h03F', 130.0) //T2 Power alien spawn 
    call SaveMass('h03H', 200.0) //Basilisk spawn 
    call SaveMass('h03B', 120.0) //Combustion spawn 
    call SaveMass('h039', 275.0) //Electricity spawn 
    call SaveMass('h03R', 165.0) //T3 regeneration spawn 
    call SaveMass('h03W', 180.0) //Webspinner spawn 
    call SaveMass('h03S', 80.0) //Alien spawn core 
    call SaveMass('h01U', 50.0) //Carrier sack 
    call SaveMass('h01T', 160.0) //Harbinger 
    call SaveMass('h01K', 180.0) //Complete infection mutant 
    call SaveMass('h01V', 250.0) //Defiler mutant 
    call SaveMass('h01G', 1000.0) //Flesh golem mutant 
    call SaveMass('h01C', 80.0) //Gargoyle mutant 
    call SaveMass('h01I', 120.0) //Human development mutant 
    call SaveMass('h01H', 260.0) //Minotaur mutant 
    call SaveMass('h00U', 125.0) //Perfection mutant 
    call SaveMass('h01L', 115.0) //Rapid gestation mutant 
    call SaveMass('h01D', 175.0) //Stalker mutant 
    call SaveMass('h01E', 400.0) //Strength mutant 
    call SaveMass('h01O', 120.0) //Sustained development mutant (scorpion) 
    call SaveMass('h01N', 115.0) //Complete infection spawn 
    call SaveMass('h01X', 175.0) //Defiler spawn 
    call SaveMass('h01Y', 175.0) //Overlord spawn 
    call SaveMass('h01M', 115.0) //Rapid gestation spawn 
    call SaveMass('h01P', 30.0) //Spiderling 
    call SaveMass('h01S', 30.0) //Swarm beetle 
    call SaveMass('h022', 165.0) //Overlord tentacle unit 
    call SaveMass('h01W', 20.0) //Defiler worm 
    call SaveMass('h01Q', 4000.0) //Overlord mutant 
    call SaveMass('h04Q', 80.0) //Cage 
    
    //Consoles 
    call SaveMass('h000', 999999999.0) 
    call SaveMass('h00Y', 999999999.0) 
    call SaveMass('h04B', 999999999.0) 
    call SaveMass('h006', 999999999.0) 
    call SaveMass('h048', 999999999.0) 
    call SaveMass('h00A', 999999999.0) 
    call SaveMass('h02A', 999999999.0) 
    call SaveMass('h004', 999999999.0) 
endfunction 

