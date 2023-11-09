@ This library can be used to download and execute a multi-boot image from
@ a GameCube using the JOY Bus protocol over the link cable.
	.include "asm/macros.inc"
	.syntax unified

	.text

	thumb_func_start GameCubeMultiBoot_Hash
GameCubeMultiBoot_Hash:
	push {r4,lr}
	ldr r4, pool_HashVal
	eors r3, r1
	movs r2, 0x20

GameCubeMultiBoot_Hash_Loop:
	lsrs r3, 1
	bcc GameCubeMultiBoot_Hash_SkipEor

	eors r3, r4

GameCubeMultiBoot_Hash_SkipEor:
	subs r2, 0x1
	bne GameCubeMultiBoot_Hash_Loop

	pop {r4,pc}
	thumb_func_end GameCubeMultiBoot_Hash

	thumb_func_start GameCubeMultiBoot_Main
@ void GameCubeMultiBoot_Main(struct GameCubeMultiBoot *mb);
GameCubeMultiBoot_Main:
	@ If there is no interrupt handler, skip counter manipulation
	ldr r1, [r0, #0x28]
	cmp r1, 0
	beq GameCubeMultiBoot_Main_SkipCounters
	@ Increment the second counter
	ldrb r1, [r0, #0x1]
	adds r1, 0x1
	strb r1, [r0, #0x1]
	@ If there is nothing more to do, bail out
	ldrb r1, [r0, #0x2]
	cmp r1, #0x2
	beq GameCubeMultiBoot_Main_Return
	@ Save current interrupt master register value
	ldr r3, pool_InterruptRegs
	ldrh r2, [r3, #0x8]
	@ Disable all interrupts
	movs r1, 0
	strh r1, [r3, #0x8]
	@ Increment the first counter, if it's less than or equal to 10.
	ldrb r1, [r0, #0x0]
	cmp r1, 0xA
	bgt GameCubeMultiBoot_Main_SkipCounter1Inc
	adds r1, 0x1
	strb r1, [r0, #0x0]
GameCubeMultiBoot_Main_SkipCounter1Inc:
	@ Load the saved interrupt master register value (re-enables interrupts if they were enabled before)
	strh r2, [r3, #0x8]
GameCubeMultiBoot_Main_SkipCounters:
	@ Initialise multiboot structures if required
	bcs GameCubeMultiBoot_Init
	@ Skip this section (check Nintendo logo) if the check has already passed
	ldrb r1, [r0, #0x2]
	cmp r1, #0x0
	bne GameCubeMultiBoot_Main_SkipLogoCheck
	@ Bail out if no multiboot image data has been transferred yet
	ldr r1, [r0, #0x24]
	ldr r2, [r0, #0x20]
	subs r1, r2
	beq GameCubeMultiBoot_Main_Return2
	@ Also bail out if not enough data has been transferred
	cmp r1, #0xA0
	bcc GameCubeMultiBoot_Main_Return2
	@ Compare the Nintendo logo of the transferred multiboot image header, with the one in the ROM image of the inserted cart
	push {r4-r6}
	movs r1, #0x98
	adds r2, #0x4
	ldr r4, pool_NintendoLogo
GameCubeMultiBoot_Main_LogoCmpLoop:
	ldm r2!, {r5}
	ldm r4!, {r6}
	cmp r5, r6
	bne GameCubeMultiBoot_Main_LogoCmpEnd
	subs r1, 0x4
	bne GameCubeMultiBoot_Main_LogoCmpLoop
	ldm r2!, {r5}
	ldm r4!, {r6}
	eors r5, r6
	lsrs r5, 8
	str r2, [r0, #0x20]
GameCubeMultiBoot_Main_LogoCmpEnd:
	pop {r4-r6}
	@ Throw everything away if the logo data didn't match
	bne GameCubeMultiBoot_Init
	@ Logo matched, set the relevent multiboot progress bit
	movs r1, #0x1
	strb r1, [r0, #0x2]
	@ XOR together KeyA and KeyB to get the initial multiboot image checksum value
	ldr r1, [r0, #0x4]
	ldr r2, [r0, #0x8]
	eors r1, r2
	str r1, [r0, #0x18]
	@ ...also use it as the initial value for the image encryption session key. Algorithm is the same as the GBA BIOS multiboot: sessionkey = (initialvalue * 0x6177614b) + 1
	ldr r2, pool_Kawa
	muls r1, r2
	adds r1, 0x1
	str r1, [r0, #0x14]
GameCubeMultiBoot_Main_Return:
	bx lr
GameCubeMultiBoot_Main_SkipLogoCheck:
	@ If this code is executed, then the logo check has passed, and the data being transferred in is encrypted.
	@ Set up registers.
	ldr r1, [r0, #0x24]
	mov r12, r1
	ldr r3, [r0, #0x18]
	push {r4-r7}
	ldr r4, [r0, #0x20]
	ldr r5, pool_Kawa
	ldr r6, [r0, #0x14]
	ldr r7, pool_HashVal
GameCubeMultiBoot_Main_ImageDecryptHashLoop:
	@ If there's no more data, break out of the loop
	cmp r4, r12
	bcs GameCubeMultiBoot_Main_ImageDecryptHashEnd
	@ Get the next uint32
	ldr r1, [r4]
	@ Decrypt the ciphertext: plaintext = (ciphertext ^ sessionkey) + hashval
	eors r1, r6
	adds r1, r3
	@ Save the current uint32 of plaintext and advance the pointer
	stm r4!, {r1}
	@ Advance the hashval with this uint32 of plaintext -- this is the same code as GameCubeMultiBoot_Hash.
	eors r3, r1
	movs r2, 0x20
GameCubeMultiBoot_Main_HashLoop:
	lsrs r3, 1
	bcc GameCubeMultiBoot_Main_HashSkipEor
	eors r3, r7
GameCubeMultiBoot_Main_HashSkipEor:
	subs r2, 0x1
	bne GameCubeMultiBoot_Main_HashLoop
	@ Advance the sessionkey with the usual algorithm: sessionkey = (sessionkey * 0x6177614b) + 1
	muls r6, r5
	adds r6, 0x1
	b GameCubeMultiBoot_Main_ImageDecryptHashLoop
GameCubeMultiBoot_Main_ImageDecryptHashEnd:
	@ Save the new pointer, sessionkey, hashval
	str r4, [r0, #0x20]
	str r6, [r0, #0x14]
	pop {r4-r7}
	str r3, [r0, #0x18]
	@ Bail out if the image size is unknown
	ldrh r1, [r0, #0x12]
	cmp r1, 0
	bne GameCubeMultiBoot_Main_Return2
	@ Bail out if no image data has been transferred
	ldr r1, [r0, #0x24]
	ldr r2, [r0, #0x20]
	cmp r1, r2
	bne GameCubeMultiBoot_Main_Return2
	@ If KeyC hasn't been generated yet, go generate it
	ldr r1, [r0, #0xC]
	cmp r1, 0
	beq GameCubeMultiBoot_Main_GenerateKeyC
	@ If the other side hasn't sent its boot key yet, bail out
	ldrh r1, [r0, #0x10]
	cmp r1, 0
	beq GameCubeMultiBoot_Main_Return
	@ Save off LR so it doesn't get clobbered by the upcoming function call
	mov r12, lr
	@ Generate the real boot key, which is the checksum of a hardcoded value and KeyC
	movs r1, #0xBB
	ldr r3, [r0, #0xC]
	bl GameCubeMultiBoot_Hash
	ldrh r1, [r0, #0x10]
	@ Restore the saved LR value
	mov lr, r12
	@ Compare the two boot keys (real and passed in), if they don't match then throw everything away
	subs r1, r3
	bne GameCubeMultiBoot_Init
	@ The two boot keys matched, tell the caller that the image is ready to boot
	movs r1, #0x2
	strb r1, [r0, #0x2]
	@ Nothing more to do, return.
	bx lr
GameCubeMultiBoot_Main_GenerateKeyC:
	@ Save off LR so it doesn't get clobbered by the upcoming function call
	mov r12, lr
	@ KeyC = (SavedVCount << 24) - 1
	ldrb r1, [r0, #0x3]
	lsls r1, 24
	subs r1, 0x1
	str r1, [r0, #0xC]
	@ Hash the KeyC with the multiboot image checksum to generate the KeyC derivation material to be sent to the other side of the link
	bl GameCubeMultiBoot_Hash
	@ Make sure the sent KeyC derivation material contains a magic value so that the other side can detect it
	lsls r3, 8
	adds r3, #0xFF
	@ Save off the KeyC derivation material and return to caller
	str r3, [r0, #0x1C]
	bx r12
GameCubeMultiBoot_Main_Return2:
	bx lr
	thumb_func_end GameCubeMultiBoot_Main

	.align 2, 0

pool_HashVal: .4byte 0xa1c1

pool_Kawa: .ascii "Kawa" @ name of BIOS developer

pool_NintendoLogo: .4byte RomHeaderNintendoLogo

	thumb_func_start GameCubeMultiBoot_ExecuteProgram
@ void GameCubeMultiBoot_ExecuteProgram(struct GameCubeMultiBoot *mb);
GameCubeMultiBoot_ExecuteProgram:
	@ If there's no multiboot image ready, just return to caller
	ldrb r1, [r0, #0x2]
	cmp r1, #0x2
	bne GameCubeMultiBoot_ExecuteProgram_Fail
	@ Disable interrupts
	ldr r3, pool_InterruptRegs
	movs r1, 0
	strh r1, [r3, #0x8]
	@ Jump to the real entry point of the multiboot image (past the image header), in ARM mode
	ldr r1, pool_MultiBootLoadAddr
	adds r1, 0xC0
	bx r1
GameCubeMultiBoot_ExecuteProgram_Fail:
	bx lr
	thumb_func_end GameCubeMultiBoot_ExecuteProgram

	thumb_func_start GameCubeMultiBoot_Init
@ void GameCubeMultiBoot_Init(struct GameCubeMultiBoot *mb);
GameCubeMultiBoot_Init:
	ldr r3, pool_InterruptRegs

@ Save IME register.
	ldrh r2, [r3, #0x8]

@ Disable interrupts.
	movs r1, 0
	strh r1, [r3, #0x8]

@ Set the handler to the "Stop" routine.
@ Unless the first command that is received is a device reset command, the
@ "Stop" routine will be executed and no further commands will be processed.
	adr r3, GcMbIntrHandler_Stop
	str r3, [r0, #0x28]

	ldrb r3, [r0, 0x3]
	push {r3}
	ldrb r3, [r0, 0x1]
	push {r0,r3}

	adds r3, r0, 0
	adds r3, #0x20

@ clear all but the last 3 fields of the struct
GameCubeMultiBoot_Init_ClearStructLoop:
	stm r0!, {r1}
	cmp r0, r3
	blo GameCubeMultiBoot_Init_ClearStructLoop

	pop {r0,r3}
	lsrs r3, 1
	strb r3, [r0, 0x3]
	pop {r3}
	strb r3, [r0, 0x1]

	ldr r3, pool_SerialRegs

@ Turn off JOY Bus mode.
	lsls r0, r3, 10
	strh r0, [r3, #0x14]

@ Turn on JOY Bus mode.
	movs r0, 0xC0
	lsls r0, 8
	strh r0, [r3, #0x14]

@ Init JOY Bus registers.
	movs r0, 0x47
	strh r0, [r3, #0x20]
	strh r1, [r3, #0x38]

	ldr r3, pool_InterruptRegs

@ Acknowledge serial interrupt.
	movs r0, #0x80
	strh r0, [r3, #0x2]

@ Enable serial interrupt.
	ldrh r1, [r3, #0x0]
	orrs r1, r0
	strh r1, [r3, #0x0]

@ Restore IME register.
	strh r2, [r3, #0x8]

	bx lr
	thumb_func_end GameCubeMultiBoot_Init

	non_word_aligned_thumb_func_start GameCubeMultiBoot_HandleSerialInterrupt
@ void GameCubeMultiBoot_HandleSerialInterrupt(struct GameCubeMultiBoot *mb);
GameCubeMultiBoot_HandleSerialInterrupt:
	ldr r3, pool_SerialRegs

@ Acknowledge reset/receive/send flags.
	ldrh r1, [r3, #0x20]
	strh r1, [r3, #0x20]

	movs r2, 0
	strb r2, [r0]

	ldr r2, [r0, #0x28]
	cmp r2, 0
	beq GameCubeMultiBoot_HandleSerialInterruptDone

	lsrs r1, 1 @ was a device reset command received?
	bcs GameCubeMultiBoot_BeginHandshake @ branch if so

	mov pc, r2

	.align 2, 0

@ Zero the status and the interrupt handler pointer.
@ Commands from the GameCube will not be processed after this is executed
@ unless GameCubeMultiBoot_Init() is called again.
GcMbIntrHandler_Stop:
	movs r2, 0
	strh r2, [r3, #0x38]

GameCubeMultiBoot_SetInterruptHandler:
	str r2, [r0, #0x28]

GameCubeMultiBoot_ReadVCount:
	ldr r3, pool_RegDispstat
	ldrh r1, [r3, 0x2]
	strb r1, [r0, 0x3]

GameCubeMultiBoot_HandleSerialInterruptDone:
	bx lr

GameCubeMultiBoot_BeginHandshake:
	@ Throw away anything that got sent
	ldr r1, [r3, #0x30]
	@ Send the game code, the other side of the link must send back the same game code
	ldr r1, pool_RubyUSAGameCode
	str r1, [r3, #0x34]
	movs r1, 0x10
	strh r1, [r3, #0x38]
	@ Use the saved VCount value to provide 8 bits of entropy for KeyB
	ldrb r1, [r0, #0x3]
	strb r1, [r0, #0x8 + 1]
	@ If a multiboot image has been transferred at least enough such that the Nintendo logo check has passed, stop everything.
	ldrb r1, [r0, #0x2]
	cmp r1, 0
	bne GcMbIntrHandler_Stop
	@ Set the image destination pointers.
	ldr r1, pool_MultiBootLoadAddr
	str r1, [r0, #0x20]
	str r1, [r0, #0x24]
	@ Set the new interrupt handler.
	adr r2, GcMbIntrHandler_CheckGameCodeSent
	b GameCubeMultiBoot_SetInterruptHandler

	.align 2, 0

GcMbIntrHandler_CheckGameCodeSent:
	lsls r1, 31
	bcc GcMbIntrHandler_Stop @ stop if send failed
	bmi GameCubeMultiBoot_CheckHandshakeResponse @ branch if receive is complete

@ If the response hasn't been fully received yet,
@ check again upon the next interrupt.
	adr r2, GcMbIntrHandler_CheckHandshakeResponse
	b GameCubeMultiBoot_SetInterruptHandler

	.align 2, 0

GcMbIntrHandler_CheckHandshakeResponse:
	lsrs r1, 1 @ is receive complete?
	bcc GcMbIntrHandler_Stop @ stop if not

GameCubeMultiBoot_CheckHandshakeResponse:
	ldr r1, [r3, #0x30]
	ldr r2, pool_RubyUSAGameCode
	cmp r1, r2
	bne GcMbIntrHandler_Stop @ stop if the GameCube didn't reply with the same game code
	@ Use the saved VCount value to provide another 8 bits of entropy for KeyB.
	ldrb r1, [r0, #0x3]
	strb r1, [r0, #0x8 + 3]
	adr r2, GcMbIntrHandler_ReceiveKeyA
	b GameCubeMultiBoot_SetInterruptHandler

	.align 2, 0

GcMbIntrHandler_ReceiveKeyA:
	lsrs r1, 1 @ is receive complete?
	bcc GcMbIntrHandler_Stop @ branch if not
	ldr r1, [r3, #0x30]
	@ make sure top 8 bits of the received value is the KeyA magic number, stop if KeyA is invalid
	lsrs r2, r1, 24
	cmp r2, #0xDD
	bne GcMbIntrHandler_Stop
	@ save received KeyA
	str r1, [r0, #0x4]
	@ use the second GameCubeMultiBoot_Main() counter as another 8 bits of entropy for KeyB
	ldrb r1, [r0, #0x1]
	strb r1, [r0, #0x8 + 2]
	movs r2, 0
	movs r3, 0
	ldr r1, [r0, #0x8]
	lsrs r1, 8
	@ make sure KeyB is valid (other side of the link is supposed to check KeyB too), if it's not then change the byte that was just set so it is
GameCubeMultiBoot_KeyBCheckLoop:
	lsrs r1, 1
	adcs r2, r3
	cmp r1, 0
	bne GameCubeMultiBoot_KeyBCheckLoop
	cmp r2, 0xE
	bgt GameCubeMultiBoot_KeyBSaveNewByte
	cmp r2, 0x7
	bge GameCubeMultiBoot_KeyBCheckEnd
	movs r1, 0xFF
GameCubeMultiBoot_KeyBSaveNewByte:
	strb r1, [r0, #0x8 + 2]
GameCubeMultiBoot_KeyBCheckEnd:
	@ add in the KeyB magic number and send off KeyB
	ldr r1, [r0, #0x8]
	adds r1, #0xEE
	ldr r3, pool_SerialRegs
	str r1, [r3, #0x34]
	movs r1, 0x30
	strh r1, [r3, #0x38]
	@ set new interrupt handler
	adr r2, GcMbIntrHandler_CheckKeyBSent
	b GameCubeMultiBoot_SetInterruptHandler

	.align 2, 0

GcMbIntrHandler_CheckKeyBSent:
	lsls r1, 31
	bcc GcMbIntrHandler_Stop @ stop if send failed
	bmi GameCubeMultiBoot_CheckImageSizeResponse @ branch if receive is complete
	adr r2, GcMbIntrHandler_CheckImageSizeResponse
	b GameCubeMultiBoot_SetInterruptHandler

	.align 2, 0

GcMbIntrHandler_CheckImageSizeResponse:
	lsrs r1, 1 @ is receive complete?
	bcc GcMbIntrHandler_Stop @ branch if not
GameCubeMultiBoot_CheckImageSizeResponse:
	ldr r1, [r3, #0x30]
	ldr r2, GameCubeMultiBoot_MaximumImageSizeUInt32s
	cmp r1, r2
	bhs GcMbIntrHandler_Stop
	adds r1, 0x1
	adds r1, r1
	strh r1, [r0, #0x12]
	ldrb r1, [r0, #0x2]
	cmp r1, 0
GcMbIntrHandler_StopIfNotEqual:
	bne GcMbIntrHandler_Stop
	ldr r1, pool_MultiBootLoadAddr
	str r1, [r0, #0x20]
	str r1, [r0, #0x24]
	adr r2, GcMbIntrHandler_CheckImageResponse
	b GameCubeMultiBoot_SetInterruptHandler

	.align 2, 0

GcMbIntrHandler_CheckImageResponse:
	lsrs r1, 1 @ is receive complete?
	bcc GcMbIntrHandler_Stop @ branch if not
	ldr r2, [r0, #0x24]
	movs r1, 0x4
	ands r1, r2
	adds r1, 0x8
	lsls r1, 2
	strh r1, [r3, #0x38]
	@ get the recieved uint32
	ldr r1, [r3, #0x30]
	@ put it in the current destination pointer and advance that pointer
	stm r2!, {r1}
	@ save off the advanced pointer
	str r2, [r0, #0x24]
	@ decrease the image size (in uint32s)
	ldrh r1, [r0, #0x12]
	subs r1, 0x1
	strh r1, [r0, #0x12]
	@ branch away if the transfer is not yet complete
	bne GameCubeMultiBoot_ReadVCount

GcMbIntrHandler_SendCounter2:
	@ send counter2 with magic number
	ldrb r1, [r0, #0x1]
	lsls r1, 8
	adds r1, #0xCC
	str r1, [r3, #0x34]
	adr r2, GcMbIntrHandler_CheckCounter2Sent
	b GameCubeMultiBoot_SetInterruptHandler

	.align 2, 0

GcMbIntrHandler_CheckCounter2Sent:
	lsls r1, 31

GcMbIntrHandler_StopIfSendFailed:
	bcc GcMbIntrHandler_Stop @ stop if send failed
	@ if KeyC derivation value has not yet been generated, send Counter2 again, otherwise, send KeyC derivation
	ldr r1, [r0, #0x1C]
	cmp r1, 0
	beq GcMbIntrHandler_SendCounter2
	str r1, [r3, #0x34]
	adr r2, GcMbIntrHandler_CheckKeyCDerivationSent
	b GameCubeMultiBoot_SetInterruptHandler

	.align 2, 0

GcMbIntrHandler_CheckKeyCDerivationSent:
	lsls r1, 31
	bcc GcMbIntrHandler_StopIfSendFailed @ branch if send failed
	bmi GameCubeMultiBoot_CheckBootKeyResponse @ branch if receive is complete
	adr r2, GcMbIntrHandler_CheckBootKeyResponse
	b GameCubeMultiBoot_SetInterruptHandler

	.align 2, 0

GcMbIntrHandler_CheckBootKeyResponse:
	lsrs r1, 1 @ is receive complete?
	bcc GcMbIntrHandler_StopIfSendFailed @ branch if not

GameCubeMultiBoot_CheckBootKeyResponse:
	ldr r1, [r3, #0x30]
	@ make sure received boot key contains expected magic number, stop if not
	lsrs r2, r1, 24
	cmp r2, #0xBB
	bne GcMbIntrHandler_StopIfNotEqual
	@ save received bootkey to be checked in GameCubeMultiBoot_Main()
	strh r1, [r0, #0x10]
	@ stop if anything more gets sent
	adr r2, GcMbIntrHandler_StopUnconditionally
	b GameCubeMultiBoot_SetInterruptHandler

	.align 2, 0

GcMbIntrHandler_StopUnconditionally:
	b GcMbIntrHandler_Stop

	thumb_func_end GameCubeMultiBoot_HandleSerialInterrupt

	non_word_aligned_thumb_func_start GameCubeMultiBoot_Quit
@ void GameCubeMultiBoot_Quit();
GameCubeMultiBoot_Quit:
	ldr r3, pool_InterruptRegs

@ Save IME register.
	ldrh r2, [r3, #0x8]

@ Disable interrupts.
	movs r1, 0
	strh r1, [r3, #0x8]

	ldr r3, pool_SerialRegs

@ Acknowledge all JOYCNT flags.
	movs r0, 0x7
	strh r0, [r3, #0x20]

@ Turn off JOY Bus mode.
	lsls r0, r3, 10
	strh r0, [r3, #0x14] @ store 0x8000

	ldr r3, pool_InterruptRegs

@ Acknowledge serial interrupt.
	movs r0, #0x80
	strh r0, [r3, #0x2]

@ Disable serial interrupt.
	ldrh r1, [r3, #0x0]
	bics r1, r0
	strh r1, [r3, #0x0]

@ Restore IME register.
	strh r2, [r3, #0x8]

	bx lr
	thumb_func_end GameCubeMultiBoot_Quit

	.align 2, 0

GameCubeMultiBoot_MaximumImageSizeUInt32s: .4byte 0x4000

pool_InterruptRegs: .4byte 0x04000200

pool_SerialRegs: .4byte 0x04000120

pool_RegDispstat: .4byte 0x04000004

pool_RubyUSAGameCode: .ascii "AXVE"

pool_MultiBootLoadAddr: .4byte 0x02000000

	.align 2, 0 @ Don't pad with nop.
