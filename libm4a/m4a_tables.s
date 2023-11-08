	.arch armv4t
	.fpu softvfp
	.eabi_attribute 23, 1
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"<stdin>"
	.text
	.global	gXcmdTable
	.global	gPokemonCrySongTemplate
	.global	gClockTable
	.global	gCgb3Vol
	.global	gNoiseTable
	.global	gCgbFreqTable
	.global	gCgbScaleTable
	.global	gPcmSamplesPerVBlankTable
	.global	gFreqTable
	.global	gScaleTable
	.global	gDeltaEncodingTable
	.global	gMPlayJumpTableTemplate
	.section	.rodata
	.align	2
	.type	gXcmdTable, %object
	.size	gXcmdTable, 56
gXcmdTable:
	.word	ply_xxx
	.word	ply_xwave
	.word	ply_xtype
	.word	ply_xxx
	.word	ply_xatta
	.word	ply_xdeca
	.word	ply_xsust
	.word	ply_xrele
	.word	ply_xiecv
	.word	ply_xiecl
	.word	ply_xleng
	.word	ply_xswee
	.word	ply_xcmd_0C
	.word	ply_xcmd_0D
	.type	gPokemonCrySongTemplate, %object
	.size	gPokemonCrySongTemplate, 52
gPokemonCrySongTemplate:
	.byte	1
	.byte	0
	.byte	-1
	.byte	0
	.word	voicegroup000
	.word	0
	.word	0
	.byte	0
	.byte	-56
	.byte	64
	.byte	-78
	.word	0
	.byte	-56
	.byte	80
	.ascii	"\275\000"
	.byte	-66
	.byte	127
	.ascii	"\315\015"
	.word	0
	.ascii	"\315\007"
	.byte	0
	.byte	-65
	.byte	64
	.byte	-49
	.byte	60
	.byte	127
	.ascii	"\315\014"
	.short	60
	.ascii	"\316\261"
	.space	2
	.type	gClockTable, %object
	.size	gClockTable, 49
gClockTable:
	.ascii	"\000\001\002\003\004\005\006\007\010\011\012\013\014"
	.ascii	"\015\016\017\020\021\022\023\024\025\026\027\030\034"
	.ascii	"\036 $(*,0468<@BDHLNPTXZ\\`"
	.space	3
	.type	gCgb3Vol, %object
	.size	gCgb3Vol, 16
gCgb3Vol:
	.ascii	"\000\000````@@@@\200\200\200\200  "
	.type	gNoiseTable, %object
	.size	gNoiseTable, 60
gNoiseTable:
	.ascii	"\327\326\325\324\307\306\305\304\267\266\265\264\247"
	.ascii	"\246\245\244\227\226\225\224\207\206\205\204wvutgfe"
	.ascii	"dWVUTGFED7654'&%$\027\026\025\024\007\006\005\004\003"
	.ascii	"\002\001\000"
	.type	gCgbFreqTable, %object
	.size	gCgbFreqTable, 24
gCgbFreqTable:
	.short	-2004
	.short	-1891
	.short	-1785
	.short	-1685
	.short	-1591
	.short	-1501
	.short	-1417
	.short	-1337
	.short	-1262
	.short	-1192
	.short	-1125
	.short	-1062
	.type	gCgbScaleTable, %object
	.size	gCgbScaleTable, 132
gCgbScaleTable:
	.ascii	"\000\001\002\003\004\005\006\007\010\011\012\013\020"
	.ascii	"\021\022\023\024\025\026\027\030\031\032\033 !\"#$%"
	.ascii	"&'()*+0123456789:;@ABCDEFGHIJKPQRSTUVWXYZ[`abcdefgh"
	.ascii	"ijkpqrstuvwxyz{\200\201\202\203\204\205\206\207\210"
	.ascii	"\211\212\213\220\221\222\223\224\225\226\227\230\231"
	.ascii	"\232\233\240\241\242\243\244\245\246\247\250\251\252"
	.ascii	"\253"
	.type	gPcmSamplesPerVBlankTable, %object
	.size	gPcmSamplesPerVBlankTable, 24
gPcmSamplesPerVBlankTable:
	.short	96
	.short	132
	.short	176
	.short	224
	.short	264
	.short	304
	.short	352
	.short	448
	.short	528
	.short	608
	.short	672
	.short	704
	.type	gFreqTable, %object
	.size	gFreqTable, 48
gFreqTable:
	.word	-2147483648
	.word	-2019787625
	.word	-1884498402
	.word	-1741164462
	.word	-1589307444
	.word	-1428420536
	.word	-1257966796
	.word	-1077377349
	.word	-886049494
	.word	-683344693
	.word	-468586438
	.word	-241057991
	.type	gScaleTable, %object
	.size	gScaleTable, 180
gScaleTable:
	.ascii	"\340\341\342\343\344\345\346\347\350\351\352\353\320"
	.ascii	"\321\322\323\324\325\326\327\330\331\332\333\300\301"
	.ascii	"\302\303\304\305\306\307\310\311\312\313\260\261\262"
	.ascii	"\263\264\265\266\267\270\271\272\273\240\241\242\243"
	.ascii	"\244\245\246\247\250\251\252\253\220\221\222\223\224"
	.ascii	"\225\226\227\230\231\232\233\200\201\202\203\204\205"
	.ascii	"\206\207\210\211\212\213pqrstuvwxyz{`abcdefghijkPQR"
	.ascii	"STUVWXYZ[@ABCDEFGHIJK0123456789:; !\"#$%&'()*+\020\021"
	.ascii	"\022\023\024\025\026\027\030\031\032\033\000\001\002"
	.ascii	"\003\004\005\006\007\010\011\012\013"
	.type	gDeltaEncodingTable, %object
	.size	gDeltaEncodingTable, 16
gDeltaEncodingTable:
	.ascii	"\000\001\004\011\020\031$1\300\317\334\347\360\367\374"
	.ascii	"\377"
	.type	gMPlayJumpTableTemplate, %object
	.size	gMPlayJumpTableTemplate, 144
gMPlayJumpTableTemplate:
	.word	ply_fine
	.word	ply_goto
	.word	ply_patt
	.word	ply_pend
	.word	ply_rept
	.word	ply_fine
	.word	ply_fine
	.word	ply_fine
	.word	ply_fine
	.word	ply_prio
	.word	ply_tempo
	.word	ply_keysh
	.word	ply_voice
	.word	ply_vol
	.word	ply_pan
	.word	ply_bend
	.word	ply_bendr
	.word	ply_lfos
	.word	ply_lfodl
	.word	ply_mod
	.word	ply_modt
	.word	ply_fine
	.word	ply_fine
	.word	ply_tune
	.word	ply_fine
	.word	ply_fine
	.word	ply_fine
	.word	ply_port
	.word	ply_fine
	.word	ply_endtie
	.word	SampleFreqSet
	.word	TrackStop
	.word	FadeOutBody
	.word	TrkVolPitSet
	.word	RealClearChain
	.word	SoundMainBTM
	.ident	"GCC: (devkitARM release 62) 13.2.0"
.text
	.align	2, 0

