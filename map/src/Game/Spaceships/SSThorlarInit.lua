if Debug then Debug.beginFile "Game/Spaceships/SSThorlarInit" end
OnInit.map("SSThorlarInit", function(require)
    function Trig_SSThorlarInit_Actions()
        udg_SpaceshipRect[1] = gg_rct_SS1
        udg_SpaceshipGround[1] = gg_unit_h001_0041
        udg_SpaceshipSpace[1] = gg_unit_h002_0020

        udg_SpaceshipRect[2] = gg_rct_SS2
        udg_SpaceshipGround[2] = gg_unit_h001_0043
        udg_SpaceshipSpace[2] = gg_unit_h002_0021

        udg_SpaceshipRect[3] = gg_rct_SS3
        udg_SpaceshipGround[3] = gg_unit_h001_0044
        udg_SpaceshipSpace[3] = gg_unit_h002_0045

        udg_SpaceshipRect[4] = gg_rct_SS4
        udg_SpaceshipGround[4] = gg_unit_h001_0042
        udg_SpaceshipSpace[4] = gg_unit_h002_0046

        udg_SpaceshipRect[5] = gg_rct_SS5
        udg_SpaceshipGround[5] = gg_unit_h001_0016
        udg_SpaceshipSpace[5] = gg_unit_h002_0138

        udg_SpaceshipRect[6] = gg_rct_SS6
        udg_SpaceshipGround[6] = gg_unit_h001_0002
        udg_SpaceshipSpace[6] = gg_unit_h002_0153

        udg_SpaceshipRect[7] = gg_rct_SS7
        udg_SpaceshipGround[7] = gg_unit_h001_0163
        udg_SpaceshipSpace[7] = gg_unit_h002_0158

        udg_SpaceshipRect[8] = gg_rct_SS8
        udg_SpaceshipGround[8] = gg_unit_h001_0162
        udg_SpaceshipSpace[8] = gg_unit_h002_0159

        --Hunter
        udg_SpaceshipRect[9] = gg_rct_SS9
        udg_SpaceshipGround[9] = gg_unit_h02I_0183
        udg_SpaceshipSpace[9] = gg_unit_h02H_0198

        --Obda
        udg_SpaceshipRect[10] = gg_rct_SS10
        udg_SpaceshipGround[10] = gg_unit_h02K_0203
        udg_SpaceshipSpace[10] = gg_unit_h02L_0205

        --Obda
        udg_SpaceshipRect[11] = gg_rct_SS11
        udg_SpaceshipGround[11] = gg_unit_h02K_0204
        udg_SpaceshipSpace[11] = gg_unit_h02L_0202

        --Albadar
        udg_SpaceshipRect[12] = gg_rct_SS12
        udg_SpaceshipGround[12] = gg_unit_h02S_0215
        udg_SpaceshipSpace[12] = gg_unit_h02Q_0212

        --Unused 13th craft
        udg_SpaceshipRect[13] = gg_rct_SS13
        udg_SpaceshipGround[13] = nil
        udg_SpaceshipSpace[13] = nil
    end

    --===========================================================================
    gg_trg_SSThorlarInit = CreateTrigger()
    TriggerAddAction(gg_trg_SSThorlarInit, Trig_SSThorlarInit_Actions)
end)
if Debug then Debug.endFile() end
