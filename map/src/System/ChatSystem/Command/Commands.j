library Commands initializer init requires Table, StringUtil, ChatService
    globals 
        private constant string COMMAND_PREFIX = "-"


        private Table commands // table<string, Command>   
        public boolean isCommand = false
    endglobals 

    struct Command 
        readonly string name 
        readonly integer minimumArgC 

        public static method create takes string name, integer minimumArgC returns thistype 
            local thistype this = thistype.allocate() 
            set this.name = name 
            set this.minimumArgC = minimumArgC 
            call commands.write(COMMAND_PREFIX + name, this) 
            return this 
        endmethod 

        public stub method execute takes player initiator, integer argc returns nothing 
        endmethod 
    endstruct 

/* Example for how to make a command
struct ExampleCommand extends Command
    public static method create takes nothing returns thistype
        return thistype.allocate("example", 1) //1 argc for command
        //Players would have to type -example to activate it, if commandPrefix is "-"
    endmethod

    //Use StringUtil.argv to fetch arguments, [0] is always the command name!
    public method execute takes player initiator, integer argc returns nothing
        // command action goes here!
    endmethod
endstruct

private function init takes nothing returns nothing
    call ExampleCommand.create()
endfunction
*/

    public function processInput takes player thisPlayer, string message returns nothing 
        local string commandName
        local Command command
        call StringUtil_ParseStringArgs(message)
        set commandName = StringUtil_argv[0]
        if SubString(commandName, 0, 1) != COMMAND_PREFIX then
            set isCommand = false
            return
        else
            set isCommand = true
        endif

        if not commands.written(commandName) then
            call ChatSystem_sendSystemMessageToPlayer(thisPlayer, "|cFFFF0000Error: Unknown command!|r")
            return
        endif
        set command = commands.read(commandName)

        if commands.minimumArgc < StringUtil_argc then
            call ChatSystem_sendSystemMessageToPlayer(thisPlayer, "|cFFFF0000Error: Not enough arguments for|r " + command.name + " |cFFFF0000command!|r")
        else
            call command.execute(thisPlayer, StringUtil_argc)
        endif
    endfunction 

    private function init takes nothing returns nothing 
        set commands = Table.create() 
    endfunction 
endlibrary