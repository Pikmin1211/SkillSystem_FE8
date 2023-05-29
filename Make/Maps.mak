# Directories
MAPS := $(realpath .)/Maps
MAPS_TMX := $(Maps)/tmx
MAPS_EVENT := $(Maps)/event
MAPS_DMP := $(Maps)/dmp

# Files
MAP_INSTALLER := $(MAPS)/MasterMapInstaller.event
MAPS_ALL_TMX := $(wildcard $(MAPS_TMX)/*.tmx)
MAPS_ALL_EVENT := $(patsubst $(MAPS_TMX)/%.tmx, $(MAPS_EVENT)/%.event, $(MAPS_ALL_TMX))
MAPS_ALL_DATA := $(patsubst $(MAPS_TMX)%.tmx, $(MAPS_DMP)/%_data.dmp, $(MAPS_ALL_TMX))

# Text Buildfile to installer and definitions
$(MAP_INSTALLER): $(MAPS_ALL_TMX)

