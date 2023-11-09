#ifndef GUARD_CONSTANTS_ASM_CONSTANTS_INC
#define GUARD_CONSTANTS_ASM_CONSTANTS_INC
	
	.macro inc x:req
	.set \x, \x + 1
	.endm

	.macro enum_start x=0
	.set __enum__, \x
	.endm

	.macro enum constant:req
	.set \constant, __enum__
	inc __enum__
	.endm
#endif