# Directories
WIZARDRY := $(realpath .)/Wizardry
CHAX := $(WIZARDRY)/CHAX
SRC := $(CHAX)/src
SRC_INCLUDE := $(CHAX)/include
SRC_EVENT := $(CHAX)/event
CLIB := $(CHAX)/FE-CLib-Decompatible
CLIB_INCLUDE := $(CLIB)/include

# Fils
CHAX_INSTALLER := $(CHAX)/MasterChaxInstaller.event

# Lyn
LYN_REFERENCE := $(CHAX)/definitions.o

# DevKit
include $(DEVKITARM)/base_tools

# Include Flags
INCLUDE_DIRS := $(CLIB_INCLUDE) $(SRC_INCLUDE)
INCFLAGS := $(foreach dir, $(INCLUDE_DIRS), -I "$(dir)")

# Compilation Flags
ARCH := -mcpu=arm7tdmi -mthumb -mthumb-interwork
CFLAGS := $(ARCH) $(INCFLAGS) -Wall -O2 -mtune=arm7tdmi -ffreestanding -fomit-frame-pointer -mlong-calls
ASFLAGS := $(ARCH) $(INCFLAGS)

# OBJ to event rule
$(SRC_EVENT)%.lyn.event: $(SRC)%.o $(LYN_REFERENCE)
	@mkdir -p $(dir $@)
	@$(LYN) $< $(LYN_REFERENCE) > $@

# OBJ to DMP rule
$(SRC)%.dmp: $(SRC)%.o
	@mkdir -p $(dir $@)
	@$(OBJCOPY) -S $< -O binary $@

# ASM to OBJ rule
%.o: %.s
	@mkdir -p $(dir $@)
	@$(AS) $(ASFLAGS) -I $(dir $<) $< -o $@

# C to ASM rule
$(SRC)%.o: $(SRC)%.c
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@

# C to ASM rule
$(SRC)/asm/%.asm: $(SRC)%.c
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -S $< -o $@ -fverbose-asm

# ASM/C and generated files
CFILES := $(shell find $(SRC) -type f -name '*.c')
LYNFILES := $(patsubst $(SRC)%.c, $(SRC_EVENT)%.lyn.event, $(CFILES))

# Lyn files to Installer
$(CHAX_INSTALLER): $(LYNFILES)
	@python3 $(FILES_TO_INSTALLER) --input $(LYNFILES) --output $(CHAX_INSTALLER) --relative-path $(CHAX)
