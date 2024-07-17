-- //TESH.scrollpos=214
-- //TESH.alwaysfold=0


-- function LogPlayerAchievements takes player achiever, boolean display, boolean displaytoall returns nothing
-- local integer i=1
-- local integer q=LoadInteger(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("got_" .. I2S(GetConvertedPlayerId(achiever))))
-- if display == true and q >= 1 then
-- if displaytoall == true then
-- call DisplayTextToForce(GetPlayersAll(), "|cff008080" .. udg_OriginalName[GetConvertedPlayerId(achiever)] .. "|r has earned the following achievements:")
-- else
-- call DisplayTextToPlayer(achiever,0,0, "|cff008080You have earned the following achievements:|r")
-- endif
-- endif
-- loop
-- exitwhen i > 13
-- if HaveSavedBoolean(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("Player_" .. I2S(GetConvertedPlayerId(achiever)) .. "_won_" .. I2S(i))) then
-- if q>0 then
-- call MMD_UpdateValueString("Achievement" .. I2S(q), achiever, LoadStr(LS(),GetHandleId(gg_trg_AchievementsInit),StringHash(I2S(i)+"_file")))
-- else
-- call MMD_UpdateValueString("Achievement", achiever, LoadStr(LS(),GetHandleId(gg_trg_AchievementsInit),StringHash(I2S(i)+"_file")))
-- set q=q+1
-- endif
-- if display == true then
-- if displaytoall == true then
-- call DisplayTextToForce(GetPlayersAll(), "|cff00FFFF" .. LoadStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash(I2S(i))))
-- else
-- call DisplayTextToPlayer(achiever,0,0, "|cff00FFFF" .. LoadStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash(I2S(i))))
-- endif
-- endif
-- call SaveInteger(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("got_" .. I2S(GetConvertedPlayerId(achiever))), q)
-- endif
-- set i=i+1
-- endloop
-- endfunction

-- function AwardAchievement2 takes integer achievement, player achiever returns nothing

-- call SaveBoolean(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("Player_" .. I2S(GetConvertedPlayerId(achiever)) .. "_won_" .. I2S(achievement)),true)

-- endfunction

-- //



-- //





-- function AchievementCheck_GameEnd takes nothing returns nothing
-- local force h=CreateForce()
-- local integer i=0
-- if not udg_SirBot then
-- return
-- endif
-- //Check for Overkill achievement:
-- //Awarded if over 4000 EP accumulated in one game.
-- if udg_UpgradePointsAlien >= 4000 then
-- if GetPlayerSlotState(udg_Parasite) == PLAYER_SLOT_STATE_PLAYING and IsPlayerInForce(udg_Parasite,udg_DeadGroup)==false then
-- call AwardAchievement(9, udg_Parasite)
-- endif
-- endif
-- if udg_UpgradePointsMutant >= 4000 then
-- if GetPlayerSlotState(udg_Mutant) == PLAYER_SLOT_STATE_PLAYING and IsPlayerInForce(udg_Mutant,udg_DeadGroup)==false then
-- call AwardAchievement(9, udg_Mutant)
-- endif
-- endif
-- ///////////////////////////////////////////////
-- //Check for Lone Wolf achievement:
-- //Awarded if alien has no spawns and has won the game.
-- //Possibly buggy with temporal alien, but I don't care!
-- set i=0
-- set udg_TempBool=true
-- loop
-- exitwhen i > 11
-- if udg_Player_IsParasiteSpawn[i]==true then
-- set udg_TempBool=false
-- endif
-- set i=i+1
-- endloop
-- if udg_TempBool and udg_GameWinner == "Parasite" then
-- call AwardAchievement(8,udg_Parasite)
-- endif
-- ///////////////////////////////////////////////
-- //Check for: Ruthless Efficiency
-- if TimerGetElapsed(udg_GameTimer) < 1080 and udg_GameWinner == "Parasite" then
-- call AwardAchievement(6,udg_Parasite)
-- endif
-- if TimerGetElapsed(udg_GameTimer) < 1080 and udg_GameWinner == "Mutant" then
-- call AwardAchievement(6,udg_Mutant)
-- endif

-- //
-- ///////////////////////////////////////////////
-- //Check for: Stims are not obligatory
-- set i=0
-- loop
-- exitwhen i > 11
-- if udg_Achievement_StimQualification[i+1]==true and TimerGetElapsed(udg_GameTimer) > 300 and IsPlayerInForce(Player(i),udg_DeadGroup)==false then
-- call AwardAchievement( 4, Player(i))
-- endif
-- set i=i+1
-- endloop
-- ///////////////////////////////////////////////
-- //Check for: Retirement Fund, Just a Flesh Wound
-- set i=0
-- loop
-- exitwhen i > 11
-- if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING and udg_Player_Left[i+1] == false then
-- if GetPlayerState(Player(i), PLAYER_STATE_RESOURCE_GOLD) >= 100000 and udg_Player_IsParasiteSpawn[i+1] == false and udg_Player_IsMutantSpawn[i+1] == false and udg_Parasite != Player(i) and udg_Mutant != Player(i) then
-- call AwardAchievement(7, Player(i))
-- endif
-- if udg_Player_DamageTaken[i+1] >= 4000 and udg_Player_IsParasiteSpawn[i+1] == false and udg_Player_IsMutantSpawn[i+1] == false and udg_Parasite != Player(i) and udg_Mutant != Player(i) and IsPlayerInForce(Player(i),udg_DeadGroup)==false then
-- call AwardAchievement(5, Player(i))
-- endif
-- endif
-- set i=i+1
-- endloop
-- ///////////////////////////////////////////////////
-- //Check for: Remote Controlled Carnage
-- set i=0
-- loop
-- exitwhen i > 11
-- if udg_Achievement_DefenseDroneKills[i+1] >= 3 then
-- call AwardAchievement(3,Player(i))
-- endif
-- set i=i+1
-- endloop
-- ///////////////////////////////////////////////////
-- //Check for: True Captain
-- //This check is for people who never leave their post but may qualify for the 30 minutes.
-- set i=0
-- loop
-- exitwhen i > 11
-- if udg_Achievement_SwaggerControlEnd[i+1]<udg_Achievement_SwaggerControl[i+1] then
-- set udg_Achievement_SwaggerControlEnd[i+1]=TimerGetElapsed(udg_GameTimer)
-- endif
-- if udg_Achievement_SwaggerControl[i+1] != 0 and udg_Achievement_SwaggerControlEnd[i+1]-udg_Achievement_SwaggerControl[i+1]>=1800.0 then
-- call AwardAchievement(11,Player(i))
-- endif
-- set i=i+1
-- endloop
-- //////////////////////////////////////////////////
-- //Check for: Silence is Golden
-- //By the by, the disabler is under ChatGroupBroadcast conditions.
-- set i=0
-- loop
-- exitwhen i > 11
-- if udg_Achievement_SilenceIsGolden[i+1]==true and TimerGetElapsed(udg_GameTimer)>=600.0 and udg_Player_IsParasiteSpawn[i+1] == false and udg_Player_IsMutantSpawn[i+1] == false and IsPlayerInForce(Player(i),udg_DeadGroup)==false then
-- call AwardAchievement(12,Player(i))
-- endif
-- set i=i+1
-- endloop
-- //////////////////////////////////////////////////
-- //Check for: Suit strike
-- //Won as human in a game over 15 minutes without ever wearing a suit.
-- set i=0
-- loop
-- exitwhen i > 11
-- if udg_Achievement_SuitStrike[i+1]==true and TimerGetElapsed(udg_GameTimer)>=900.0 and udg_Mutant != Player(i) and udg_Parasite != Player(i) and udg_Player_IsParasiteSpawn[i+1] == false and udg_Player_IsMutantSpawn[i+1] == false and IsPlayerInForce(Player(i),udg_DeadGroup)==false then
-- call AwardAchievement(13,Player(i))
-- endif
-- set i=i+1
-- endloop
-- //////////////////////////////////////////////////
-- loop
-- exitwhen i > 11
-- call LogPlayerAchievements(Player(i), true, false)
-- set i=i+1
-- endloop
-- endfunction















-- //===========================================================================
-- function InitTrig_AchievementsInit takes nothing returns nothing
-- local integer i=0
-- set gg_trg_AchievementsInit=CreateTrigger()
-- loop
-- exitwhen i > 11
-- call SaveInteger(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("got_" .. I2S(i+1)), 0)
-- set i=i+1
-- endloop

-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("1"), "Administrative Intervention")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("1_file"), "adminintervention")
-- //
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("2"), "Ruthless Cannoneer")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("2_file"), "defunctkill")
-- //
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("3"), "Remote Controlled Carnage")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("3_file"), "remotecarnage")
-- //
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("4"), "Stims Are Not Obligatory")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("4_file"), "stimsarentneeded")
-- //
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("5"), "Just a Flesh Wound")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("5_file"), "justafleshwound")
-- //
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("6"), "Ruthless Efficiency")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("6_file"), "ruthlessefficiency")
-- //
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("7"), "Retirement Fund")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("7_file"), "retirementfund")
-- //
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("8"), "Lone Wolf")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("8_file"), "lonewolf")
-- //
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("9"), "Overkill")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("9_file"), "overkill")
-- //
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("10"), "Ostensibly Superior Kickass")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("10_file"), "osk")
-- //
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("11"), "True Captain")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("11_file"), "truecaptain")
-- //
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("12"), "Silence is Golden")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("12_file"), "silenceisgolden")
-- //
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("13"), "Suit Strike")
-- call SaveStr(LS(), GetHandleId(gg_trg_AchievementsInit), StringHash("13_file"), "suitstrike")
-- endfunction
