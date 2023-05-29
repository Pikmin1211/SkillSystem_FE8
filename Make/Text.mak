# Directories
TEXT := $(realpath .)/Text
TEXT_ENTRIES := $(TEXT)/.TextEntries
TEXT_FILES := $(TEXT)/TextFiles

# Files
TEXT_BUILDFILE := $(TEXT)/text_buildfile.txt
TEXT_INSTALLER := $(TEXT)/InstallTextData.event
TEXT_DEFINITIONS := $(TEXT)/TextDefinitions.event
PARSE_DEFINITIONS := $(TEXT)/ParseDefinitions.txt
ALL_TEXT := $(shell find $(TEXT_FILES) -type f -name "*.txt")

# Text Buildfile to installer and definitions
$(TEXT_INSTALLER) $(TEXT_DEFINITIONS): $(TEXT_BUILDFILE) $(ALL_TEXT) $(PARSE_DEFINITIONS)
	$(NOTIFY_PROCESS)
	$(MAKE_DIR)
	@python3 $(TEXT_PROCESS) $(TEXT_BUILDFILE) \
	--installer $(TEXT_INSTALLER) --definitions $(TEXT_DEFINITIONS) \
	--parser-exe $(PARSEFILE) --parse-definitions $(PARSE_DEFINITIONS)
