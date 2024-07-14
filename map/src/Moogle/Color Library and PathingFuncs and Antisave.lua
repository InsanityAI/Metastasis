//TESH.scrollpos=75
//TESH.alwaysfold=0

library PathingFuncs initializer init
    globals
        private constant real ItemSafeX = 133. //This is the X coordinate of a point that nobody can get to on your map.
        private constant real ItemSafeY = 133. //This is the Y coordinate of the same point. It's to keep from having hidden
        //The itemSafeX and Y are slightly above the Niffy's cargo bay, for reference.
        private item I                       //item errors, such as comps picking them up, etc.
        private unit U
    endglobals

    function IsPointPathable takes real x, real y, boolean evalunits returns boolean
        local boolean b
        if(evalunits)then
            call ShowUnit(U,true)
            call SetUnitPosition(U,x,y)
            set b=GetUnitX(U)==x and GetUnitY(U)==y
            call ShowUnit(U,false)
        else
            call SetItemVisible(I,true)
            call SetItemPosition(I,x,y)
            set b=SquareRoot((GetItemX(I)-x)*(GetItemX(I)-x) + (GetItemY(I)-y)*(GetItemY(I)-y)) <= 20.0
            call SetItemPosition(I,ItemSafeX,ItemSafeY)
            call SetItemVisible(I,false)
        endif
        return b
    endfunction
    
    private function init takes nothing returns nothing
        set I=CreateItem('ward',ItemSafeX,ItemSafeY)
        call SetItemInvulnerable(I,true)
        call SetItemVisible(I,false)
        set U=CreateUnit(Player(15),'hfoo',ItemSafeX,ItemSafeY,0.)
        call SetUnitInvulnerable(U,true)
        call ShowUnit(U,false)
    endfunction
endlibrary



//====================================
// PreventSave
//====================================
//
//   This library is simple enough. It allows you to enable or
//   disabled game saving. It works by showing a dialog instantly
//   before a game is saved. This closes the save screen therefor
//   the game is never actually saved.
//
//   Nothing visually happens to the game except for maybe a quick open
//   and close of the save dialog, though it's hardly noticeable.
//   This even works in single player surprisngly without pausing the game
//   which usually happens when a dialog is opened offline.
//
//   You can toggle allowing or disallowing saving by setting
//   GameAllowSave to true, or false.
//
//====================================
// Import Instructions
//====================================
//
//   1. Copy this entire script.
//   2. Create a new trigger in your trigger
//      editor and convert it to Jass.
//   3. Paste this in there and save the map.
//
//      This requires JassHelper which is included
//      in JassNewGenPack.
//
//====================================

library PreventSave initializer onInit
    
    globals
        boolean GameAllowSave = false
    endglobals
    
//====================================
// Do not edit below this line
//====================================
    
    globals
        private dialog D = DialogCreate()
        private timer T  = CreateTimer()
        private player p
    endglobals
    
    private function Exit takes nothing returns nothing
        call DialogDisplay(p, D, false)
    endfunction
    
    private function StopSave takes nothing returns nothing
        if not GameAllowSave then
            call DialogDisplay(p, D, true)
            call TimerStart(T, 0.00, false, function Exit)
        endif
    endfunction
    
    private function onInit takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterGameEvent(t, EVENT_GAME_SAVE)
        call TriggerAddAction(t, function StopSave)
        set p = GetLocalPlayer()
    endfunction

endlibrary