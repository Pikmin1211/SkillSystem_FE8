# Directories
TOOLS := $(realpath .)/Tools

# EA
EA := $(TOOLS)/EventAssembler
EA_BUILD := $(EA)/build.sh
EA_CORE := $(EA)/ColorzCore
#EA_DEP := $(EA)/ea-dep
EA_TOOLS := $(EA)/Tools

# EA Formatting Suite
COMPRESS := $(EA_TOOLS)/compress
LYN := $(EA_TOOLS)/lyn
PARSEFILE := $(EA_TOOLS)/ParseFile
PNG2DMP := $(EA_TOOLS)/Png2Dmp
PORTRAITFORMATTER := $(EA_TOOLS)/PortraitFormatter

# Build EA
$(EA_CORE) $(COMPRESS) $(LYN) $(PARSEFILE) $(PNG2DMP) $(PORTRAITFORMATTER): $(EA_BUILD)
	$(NOTIFY_PROCESS)
	$(MAKE_DIR)
	@dos2unix $(EA_BUILD)
	@bash $(EA_BUILD)

# Event files
EVENT_MAIN := ROMBuildfile.event