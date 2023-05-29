# ROM files
ROM_SOURCE := FE8_clean.gba
ROM_TARGET := SkillsTest.gba

# Notify us when stuff happens
NOTIFY_PROCESS = @echo "$(notdir $^) => $(notdir $@)"

# Create output directories as needed
MAKE_DIR = @mkdir -p $(dir $@)

# Make subfiles
MAKE := $(realpath .)/Make
include $(MAKE)/Tools.mak
include $(MAKE)/FE-PyTools.mak
include $(MAKE)/Elucidator.mak
include $(MAKE)/Text.mak
include $(MAKE)/Maps.mak
include $(MAKE)/Tables.mak
include $(MAKE)/Wizardry.mak

# Build flags
EA_FLAGS = --nocash-sym

# Rule to build the target ROM
$(ROM_TARGET): $(EVENT_MAIN) $(EA_CORE) $(TEXT_INSTALLER) $(MAPS_INSTALLER) $(TABLES_INSTALLER) $(CHAX_INSTALLER)
	$(NOTIFY_PROCESS)
	$(MAKE_DIR)
	@echo Building $(ROM_TARGET).
	@cp -f $(ROM_SOURCE) $(ROM_TARGET)
	@$(EA_CORE) A FE8 -output:$(ROM_TARGET) -input:$(EVENT_MAIN) $(EA_FLAGS) || (rm -f $(ROM_TARGET) $(ROM_TARGET:.gba=.sym) && false)
	@cat "$(ROM_SOURCE:.gba=.sym)" >> "$(ROM_TARGET:.gba=.sym)" || true

# make hack
hack: $(ROM_TARGET)
.PHONY: hack

# Files and directories to clean
CLEAN_FILES := \
$(ROM_TARGET) $(ROM_TARGET:.gba=.sym) \
$(TEXT_INSTALLER) $(TEXT_DEFINITIONS) \
$(MAPS_INSTALLER) \
$(TABLES_INSTALLER) \
$(CHAX_INSTALLER)

CLEAN_DIRS := \
$(TEXT_ENTRIES) \
$(MAPS_EVENT) $(MAPS_DMP) \
$(TABLES_EVENT) \
$(SRC_EVENT)

# make clean
clean:
	@rm -f $(CLEAN_FILES)
	@rm -rf $(CLEAN_DIRS)
	@echo all clean!
.PHONY: clean