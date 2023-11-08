TOOLCHAIN := $(DEVKITARM)
COMPARE ?= 0

# don't use dkP's base_tools anymore
# because the redefinition of $(CC) conflicts
# with when we want to use $(CC) to preprocess files
# thus, manually create the variables for the bin
# files, or use arm-none-eabi binaries on the system
# if dkP is not installed on this system

ifneq (,$(TOOLCHAIN))
ifneq ($(wildcard $(TOOLCHAIN)/bin),)
export PATH := $(TOOLCHAIN)/bin:$(PATH)
endif
endif

PREFIX := arm-none-eabi-
OBJCOPY := $(PREFIX)objcopy
AS := $(PREFIX)as
LD := $(PREFIX)ld
AR := $(PREFIX)ar

# note: the makefile must be set up so MODERNCC is never called
# if MODERN=0
MODERNCC := $(PREFIX)gcc

ifeq ($(OS),Windows_NT)
EXE := .exe
else
EXE :=
endif

# use arm-none-eabi-cpp for macOS
# as macOS's default compiler is clang
# and clang's preprocessor will warn on \u
# when preprocessing asm files, expecting a unicode literal
# we can't unconditionally use arm-none-eabi-cpp
# as installations which install binutils-arm-none-eabi
# don't come with it
ifneq ($(MODERN),1)
  ifeq ($(shell uname -s),Darwin)
    CPP := $(PREFIX)cpp
  else
    CPP := $(CC) -E
  endif
else
  CPP := $(PREFIX)cpp
endif

ASFLAGS := -mcpu=arm7tdmi
ARFLAGS := rcs

OBJS := m4a.o m4a_1.o m4a_tables.o

LIB := libm4a.a

CFLAGS := -mthumb-interwork -Ofast -mabi=aapcs -mtune=arm7tdmi -march=armv4t -mthumb -fno-toplevel-reorder

.PHONY: all clean 

all: $(LIB)
	@:

clean:
  rm -f $(LIB) $(OBJS)

$(LIB): $(OBJS)
  $(AR) $(ARFLAGS) $@ $^
  ranlib $@

%.o: %.c
  $(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
  $(AS) $(ASFLAGS) -o $@ $<
