# Directories
TABLES := $(realpath .)/Tables
TABLES_CSV := $(TABLES)/NightmareModules
TABLES_EVENT := $(TABLES)/event

# Files
TABLES_INSTALLER := $(TABLES)/TableInstaller.event
TABLES_ALL_CSV := $(shell find $(TABLES_CSV) -type f -name "*.csv")
TABLES_ALL_EVENT := $(patsubst $(TABLES_CSV)/%.csv, $(TABLES_EVENT)/%.event, $(TABLES_ALL_CSV))

# Csv to Event
$(TABLES_EVENT)/%.event: $(TABLES_CSV)/%.csv
	$(NOTIFY_PROCESS)
	$(MAKE_DIR)
	@echo | python3 $(C2EA) -csv $< -out $(TABLES_EVENT)/$*.event $(ROM_SOURCE) > /dev/null

# Events to Installer
$(TABLES_INSTALLER): $(TABLES_ALL_EVENT)
	$(NOTIFY_PROCESS)
	$(MAKE_DIR)
	@python3 $(FILES_TO_INSTALLER) --input $(TABLES_ALL_EVENT) --output $(TABLES_INSTALLER) --relative-path $(TABLES)

