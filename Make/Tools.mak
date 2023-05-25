# Directories
TOOLS := $(realpath .)/Tools

# EA
EA := $(TOOLS)/EventAssembler
EA_BUILD := $(EA)/build.sh
EA_CORE := $(EA)/ColorzCore
#EA_DEP := $(EA)/ea-dep

# Build EA
$(EA_CORE): $(EA_BUILD)
	$(NOTIFY_PROCESS)
	$(MAKE_DIR)
	@dos2unix $(EA_BUILD)
	@bash $(EA_BUILD)

# Event files
EVENT_MAIN := ROMBuildfile.event