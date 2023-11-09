ENTRY(Start)

gNumMusicPlayers = 4;
gMaxLines = 0;

MEMORY
{
    EWRAM (rwx) : ORIGIN = 0x2000000, LENGTH = 256K
    IWRAM (rwx) : ORIGIN = 0x3000000, LENGTH = 32K
    ROM    (rx) : ORIGIN = 0x8000000, LENGTH = 32M
}

SECTIONS {

    ewram 0x2000000 (NOLOAD) :
    ALIGN(4)
    {
        gflib/malloc.o(ewram_data);
        src/decompress.o(ewram_data);
        *.o(ewram_data);
        *(.data)
		*(.data.*)
    }

    iwram 0x3000000 (NOLOAD) :
    ALIGN(4)
    {
        /* .bss starts at 0x3000000 */
		*(.dynbss)
		*(.bss)
		*(.bss.*)
		*(COMMON)	
        end = .;
        . = 0x8000;
    }

    /* BEGIN ROM DATA */
    . = 0x8000000;

    .text :
    ALIGN(4)
    {
        src/rom_header.o(.text*);
        src/rom_header_gf.o(.text.*);
        src/crt0.o(.text);
        src/main.o(.text);

        src/m4a.o(.text.MidiKeyToFreq);
        src/m4a.o(.text.UnusedDummyFunc);
        src/m4a.o(.text.MPlayContinue);
        src/m4a.o(.text.MPlayFadeOut);
        src/m4a.o(.text.m4aSoundInit);
        src/m4a.o(.text.m4aSoundMain);
        src/m4a.o(.text.m4aSongNumStart);
        src/m4a.o(.text.m4aSongNumStartOrChange);
        src/m4a.o(.text.m4aSongNumStartOrContinue);
        src/m4a.o(.text.m4aSongNumStop);
        src/m4a.o(.text.m4aSongNumContinue);
        src/m4a.o(.text.m4aMPlayAllStop);
        src/m4a.o(.text.m4aMPlayContinue);
        src/m4a.o(.text.m4aMPlayFadeOut);
        src/m4a.o(.text.m4aMPlayFadeOutTemporarily);
        src/m4a.o(.text.m4aMPlayFadeIn);
        src/m4a.o(.text.m4aMPlayImmInit);
        src/m4a.o(.text.MPlayExtender);
        src/m4a.o(.text.MusicPlayerJumpTableCopy);
        src/m4a.o(.text.ClearChain);
        src/m4a.o(.text.Clear64byte);
        src/m4a.o(.text.SoundInit);
        src/m4a.o(.text.SampleFreqSet);
        src/m4a.o(.text.m4aSoundMode);
        src/m4a.o(.text.SoundClear);
        src/m4a.o(.text.m4aSoundVSyncOff);
        src/m4a.o(.text.m4aSoundVSyncOn);
        src/m4a.o(.text.MPlayOpen);
        src/m4a.o(.text.MPlayStart);
        src/m4a.o(.text.m4aMPlayStop);
        src/m4a.o(.text.FadeOutBody);
        src/m4a.o(.text.TrkVolPitSet);
        src/m4a.o(.text.MidiKeyToCgbFreq);
        src/m4a.o(.text.CgbOscOff);
        src/m4a.o(.text.CgbModVol);
        src/m4a.o(.text.CgbSound);
        src/m4a.o(.text.m4aMPlayTempoControl);
        src/m4a.o(.text.m4aMPlayVolumeControl);
        src/m4a.o(.text.m4aMPlayPitchControl);
        src/m4a.o(.text.m4aMPlayModDepthSet);
        src/m4a.o(.text.m4aMPlayLFOSpeedSet);
        src/m4a.o(.text.ply_memacc);
        src/m4a.o(.text.ply_xcmd);
        src/m4a.o(.text.ply_xxx);
        src/m4a.o(.text.ply_xwave);
        src/m4a.o(.text.ply_xtype);
        src/m4a.o(.text.ply_xatta);
        src/m4a.o(.text.ply_xdeca);
        src/m4a.o(.text.ply_xsust);
        src/m4a.o(.text.ply_xrele);
        src/m4a.o(.text.ply_xiecv);
        src/m4a.o(.text.ply_xiecl);
        src/m4a.o(.text.ply_xleng);
        src/m4a.o(.text.ply_xswee);
        src/m4a.o(.text.ply_xcmd_0C);
        src/m4a.o(.text.ply_xcmd_0D);
        src/m4a.o(.text.DummyFunc);
        src/m4a.o(.text.SetPokemonCryTone);
        src/m4a.o(.text.SetPokemonCryVolume);
        src/m4a.o(.text.SetPokemonCryPanpot);
        src/m4a.o(.text.SetPokemonCryPitch);
        src/m4a.o(.text.SetPokemonCryLength);
        src/m4a.o(.text.SetPokemonCryRelease);
        src/m4a.o(.text.SetPokemonCryProgress);
        src/m4a.o(.text.IsPokemonCryPlaying);
        src/m4a.o(.text.SetPokemonCryChorus);
        src/m4a.o(.text.SetPokemonCryStereo);
        src/m4a.o(.text.SetPokemonCryPriority);
        src/librfu_intr.o(.text.IntrSIO32);
        src/librfu_intr.o(.text.sio32intr_clock_master);
        src/librfu_intr.o(.text.sio32intr_clock_slave);
        src/librfu_intr.o(.text.handshake_wait);
        src/librfu_intr.o(.text.STWI_set_timer_in_RAM);
        src/librfu_intr.o(.text.STWI_stop_timer_in_RAM);
        src/librfu_intr.o(.text.STWI_init_slave);
        src/librfu_intr.o(.text.Callback_Dummy_M);
        src/librfu_intr.o(.text.Callback_Dummy_S);
        src/librfu_intr.o(.text.Callback_Dummy_ID);


        gflib/*.o(.text*);
        src/*.o(.text*);
        asm/*.o(.text*);
    } > ROM =0

    script_data :
    ALIGN(4)
    {
		data/*.o(script_data);
    } > ROM =0

    lib_text :
    ALIGN(4)
    {
        src/libgcnmultiboot.o(.text);
        src/m4a_1.o(.text);
        src/m4a.o(.text);
        src/agb_flash.o(.text);
        src/agb_flash_1m.o(.text);
        src/agb_flash_mx.o(.text);
        src/siirtc.o(.text);
        src/librfu_stwi.o(.text);
        src/librfu_intr.o(.text);
        src/librfu_rfu.o(.text);
        src/librfu_sio32id.o(.text);
        *libagbsyscall.a:*.o(.text*);
        *libgcc.a:*.o(.text*);
        *libc.a:*.o(.text*);
        *libnosys.a:*.o(.text*);
        src/libisagbprn.o(.text);
    } > ROM =0

    .rodata :
    ALIGN(4)
    {
        src/*.o(.rodata*);
        gflib/*.o(.rodata*);
        data/*.o(.rodata*);
    } > ROM =0

    song_data :
    ALIGN(4)
    {
        sound/songs/*.o(.rodata);
    } > ROM =0

    lib_rodata :
    SUBALIGN(4)
    {
        src/m4a.o(.rodata);
        src/agb_flash.o(.rodata);
        src/agb_flash_1m.o(.rodata);
        src/agb_flash_mx.o(.rodata);
        src/agb_flash_le.o(.rodata);
        src/siirtc.o(.rodata);
        src/librfu_rfu.o(.rodata);
        src/librfu_sio32id.o(.rodata);
        *libgcc.a:*.o(.rodata*);
        *libc.a:*.o(.rodata*);
        *libc.a:*.o(.data*);
        src/libisagbprn.o(.rodata);
    } =0

    multiboot_data :
    ALIGN(4)
    {
        data/multiboot_ereader.o(.rodata);
        data/multiboot_berry_glitch_fix.o(.rodata);
        data/multiboot_pokemon_colosseum.o(.rodata);
    } > ROM =0

    anim_mon_front_pic_data :
    ALIGN(4)
    {
        src/anim_mon_front_pics.o(.rodata);
    } > ROM =0

    gfx_data :
    ALIGN(4)
    {
        src/graphics.o(.rodata);
    } > ROM =0

    /* DWARF debug sections.
       Symbols in the DWARF debugging sections are relative to the beginning
       of the section so we begin them at 0.  */

    /* DWARF 1 */
    .debug          0 : { *(.debug) }
    .line           0 : { *(.line) }

    /* GNU DWARF 1 extensions */
    .debug_srcinfo  0 : { *(.debug_srcinfo) }
    .debug_sfnames  0 : { *(.debug_sfnames) }

    /* DWARF 1.1 and DWARF 2 */
    .debug_aranges  0 : { *(.debug_aranges) }
    .debug_pubnames 0 : { *(.debug_pubnames) }

    /* DWARF 2 */
    .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
    .debug_abbrev   0 : { *(.debug_abbrev) }
    .debug_line     0 : { *(.debug_line) }
    .debug_frame    0 : { *(.debug_frame) }
    .debug_str      0 : { *(.debug_str) }
    .debug_loc      0 : { *(.debug_loc) }
    .debug_macinfo  0 : { *(.debug_macinfo) }

    /* Discard everything not specifically mentioned above. */
    /DISCARD/ :
    {
        *(*);
    }
}
