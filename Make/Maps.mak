# Directories
MAPS := $(realpath .)/Maps
MAPS_TMX := $(MAPS)/tmx
MAPS_EVENT := $(MAPS)/event
MAPS_DMP := $(MAPS)/dmp

# Files
MAPS_INSTALLER := $(MAPS)/MasterMapInstaller.event
MAPS_ALL_TMX := $(shell find $(MAPS_TMX) -type f -name "*.tmx")
MAPS_ALL_EVENT := $(patsubst $(MAPS_TMX)/%.tmx, $(MAPS_EVENT)/%.event, $(MAPS_ALL_TMX))
MAPS_ALL_DATA := $(patsubst $(MAPS_TMX)%.tmx, $(MAPS_DMP)/%_data.dmp, $(MAPS_ALL_TMX))

# Tmx to Event
$(MAPS_EVENT)/%.event $(MAPS_DATA)/%_data.dmp: $(MAPS_TMX)/%.tmx
	$(NOTIFY_PROCESS)
	@mkdir -p $(MAPS_DMP)
	$(MAKE_DIR)
	@python3 $(TMX1EA) $< --output-event $(MAPS_EVENT)/$*.event --output-data $(MAPS_DMP)/$*_data.dmp

# Events to Installer
$(MAPS_INSTALLER): $(MAPS_ALL_EVENT)
	$(NOTIFY_PROCESS)
	$(MAKE_DIR)
	@python3 $(FILES_TO_INSTALLER) --input $(MAPS_ALL_EVENT) --output $(MAPS_INSTALLER) --relative-path $(MAPS)
