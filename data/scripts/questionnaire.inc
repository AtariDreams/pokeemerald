EventScript_Questionnaire::
	lockall
	msgbox Questionnaire_Text_FillOut, MSGBOX_YESNO
	goto_if_eq VAR_RESULT, NO, Questionnaire_EventScript_Release
	setvar VAR_0x8004, EASY_CHAT_TYPE_QUESTIONNAIRE
	call Common_ShowEasyChatScreen
	lock
	faceplayer
	specialvar VAR_0x8008, GetMartEmployeeObjectEventId
	goto_if_eq VAR_0x8004, 1, Questionnaire_EventScript_PlayerInputMysteryEventPhrase
	goto_if_eq VAR_0x8004, 2, Questionnaire_EventScript_PlayerInputMysteryGiftPhrase
	goto_if_eq VAR_RESULT, 0, Questionnaire_EventScript_Release
	goto_if_eq VAR_RESULT, 1, Questionnaire_EventScript_ThankYou
	end

Questionnaire_EventScript_PlayerInputMysteryEventPhrase::
	goto_if_unset FLAG_SYS_POKEDEX_GET, Questionnaire_EventScript_ThankYou
	goto_if_set FLAG_SYS_MYSTERY_EVENT_ENABLE, Questionnaire_EventScript_ThankYou
	applymovement VAR_0x8008, Common_Movement_FaceDown
	waitmovement 0
	playse SE_PIN
	applymovement VAR_0x8008, Common_Movement_ExclamationMark
	waitmovement 0
	applymovement VAR_0x8008, Common_Movement_Delay48
	waitmovement 0
	msgbox Questionnaire_Text_YouKnowThoseWordsEvent, MSGBOX_DEFAULT
	setflag FLAG_SYS_MYSTERY_EVENT_ENABLE
	msgbox Questionnaire_Text_YouCanAccessMysteryEvent, MSGBOX_DEFAULT
	releaseall
	end

Questionnaire_EventScript_PlayerInputMysteryGiftPhrase::
	goto_if_unset FLAG_SYS_POKEDEX_GET, Questionnaire_EventScript_ThankYou
	goto_if_set FLAG_RECEIVED_OLD_SEA_MAP, Questionnaire_EventScript_ThankYou
	applymovement VAR_0x8008, Common_Movement_FaceDown
	waitmovement 0
	playse SE_PIN
	applymovement VAR_0x8008, Common_Movement_ExclamationMark
	waitmovement 0
	applymovement VAR_0x8008, Common_Movement_Delay48
	waitmovement 0
	msgbox Questionnaire_Text_YouKnowThoseWordsGift, MSGBOX_DEFAULT
	vgoto_if_set FLAG_RECEIVED_OLD_SEA_MAP, OldSeaMap_Obtained
	vgoto_if_set FLAG_CAUGHT_MEW, OldSeaMap_Obtained
	checkitem ITEM_OLD_SEA_MAP
	vgoto_if_eq VAR_RESULT, TRUE, OldSeaMap_Obtained
	vmessage sText_MysteryGiftOldSeaMapForYou
	waitmessage
	waitbuttonpress
	checkitemspace ITEM_OLD_SEA_MAP
	vgoto_if_eq VAR_RESULT, FALSE, OldSeaMap_NoBagSpace
	giveitem ITEM_OLD_SEA_MAP
	setflag FLAG_RECEIVED_OLD_SEA_MAP
	vmessage sText_MysteryGiftOldSeaMapUseAtPort
	waitmessage
	waitbuttonpress
	releaseall
	end

Questionnaire_EventScript_Release::
	releaseall
	end

Questionnaire_EventScript_ThankYou::
	applymovement VAR_0x8008, Common_Movement_FaceDown
	waitmovement 0
	msgbox Questionnaire_Text_ThankYou, MSGBOX_DEFAULT
	releaseall
	end

OldSeaMap_NoBagSpace:
	vmessage sText_MysteryGiftOldSeaMapBagFull
	waitmessage
	waitbuttonpress
	release
	end

OldSeaMap_Obtained:
	vmessage sText_MysteryGiftOldSeaMapThankYou
	waitmessage
	waitbuttonpress
	release
	end

sText_MysteryGiftOldSeaMapForYou:
	.string "Please take this OLD SEA MAP\n"
	.string "addressed to you.$"

sText_MysteryGiftOldSeaMapUseAtPort:
	.string "It appears to be for use at the\n"
	.string "SS TIDAL ports.\p"
	.string "Why not give it a try and see what\n"
	.string "it is about?$"

sText_MysteryGiftOldSeaMapThankYou:
	.string "Thank you for using the MYSTERY\n"
	.string "GIFT System.$"

sText_MysteryGiftOldSeaMapBagFull:
	.string "Oh, I'm sorry, {PLAYER}.\n"
	.string "Your BAG's KEY ITEMS POCKET is full.\p"
	.string "Please store something on your PC,\n"
	.string "then come back for this.$"
