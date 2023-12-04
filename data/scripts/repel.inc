EventScript_RepelWoreOff::
	msgbox Text_RepelWoreOff, MSGBOX_SIGN
	end
EventScript_RepelWoreOffAskForMore::
	lockall
	msgbox Text_RepelWoreOff_UseAnother, MSGBOX_YESNO
	goto_if_eq VAR_RESULT, YES, UseRepelAgains
	releaseall
	end
UseRepelAgains::
	special UseRepelAgain
	releaseall
	end

Text_RepelWoreOff:
	.string "REPEL's effect wore off…$"

Text_RepelWoreOff_UseAnother:
    .string "REPEL's effect wore off…\n"
    .string "Use another?$"
