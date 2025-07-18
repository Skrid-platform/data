#------Init
#-Name of the collection folder
collection = Bach

#-Directories
MEI_DIR = mei
MSCZ_DIR = mscz
MID_DIR = mid
LY_DIR = ly
SVG_DIR = svg
PDF_DIR = pdf

ARCHIVES_DIR = archives
CYPHER_DIR = cypher

DIRS = $(MEI_DIR) $(MSCZ_DIR) $(MID_DIR) $(LY_DIR) $(SVG_DIR) $(PDF_DIR) $(ARCHIVES_DIR) $(CYPHER_DIR)

#-Sources
SOURCES := $(wildcard $(MEI_DIR)/*.mei)
MEI_OBJECTS = $(SOURCES)
MSCZ_OBJECTS := $(patsubst $(MEI_DIR)/%.mei, $(MSCZ_DIR)/%.mscz, $(SOURCES))
MID_OBJECTS := $(patsubst $(MEI_DIR)/%.mei, $(MID_DIR)/%.mid, $(SOURCES))
LY_OBJECTS := $(patsubst $(MEI_DIR)/%.mei, $(LY_DIR)/%.ly, $(SOURCES))
SVG_OBJECTS := $(patsubst $(MEI_DIR)/%.mei, $(SVG_DIR)/%.svg, $(SOURCES))
PDF_OBJECTS := $(patsubst $(MEI_DIR)/%.mei, $(PDF_DIR)/%.pdf, $(SOURCES))

ARCHIVES = $(ARCHIVES_DIR)/$(collection)_FilesAll.zip $(ARCHIVES_DIR)/$(collection)_FilesSvg.zip $(ARCHIVES_DIR)/$(collection)_FilesMei.zip $(ARCHIVES_DIR)/$(collection)_FilesMid.zip $(ARCHIVES_DIR)/$(collection)_FilesPdf.zip $(ARCHIVES_DIR)/$(collection)_FilesLy.zip

#------Rules
#---All
.PHONY: all
all: $(DIRS) mid-obj svg-obj mscz-obj pdf-obj ly-obj archives-obj $(CYPHER_DIR)

#---Midi
$(MID_DIR):
	@echo Creating folder "$@"
	@mkdir -p $@
	@echo "*" > $@/.gitignore

.PHONY: mid-obj
mid-obj: $(MID_DIR) $(MID_OBJECTS)
	@echo "======================="
	@echo "Converted to MIDI files"
	@echo "======================="

$(MID_DIR)/%.mid: $(MEI_DIR)/%.mei
	@verovio $^ -t midi -o $@

#---SVG
$(SVG_DIR):
	@echo Creating folder "$@"
	@mkdir -p $@
	@echo "*" > $@/.gitignore

.PHONY: svg-obj
svg-obj: $(SVG_DIR) $(SVG_OBJECTS)
	@echo "======================"
	@echo "Converted to SVG files"
	@echo "======================"

$(SVG_DIR)/%.svg: $(MEI_DIR)/%.mei
	@verovio $^ -t svg -o $@

#---mscz
$(MSCZ_DIR):
	@echo Creating folder "$@"
	@mkdir -p $@
	@echo "*" > $@/.gitignore

.PHONY: mscz-obj
mscz-obj: $(MSCZ_DIR) $(MSCZ_OBJECTS)
	@echo "======================="
	@echo "Converted to MSCZ files"
	@echo "======================="

$(MSCZ_DIR)/%.mscz: $(MEI_DIR)/%.mei
	mscore $^ -o $@

#---PDF
$(PDF_DIR):
	@echo Creating folder "$@"
	@mkdir -p $@
	@echo "*" > $@/.gitignore

.PHONY: pdf-obj
pdf-obj: $(PDF_DIR) $(PDF_OBJECTS)
	@echo "======================"
	@echo "Converted to PDF files"
	@echo "======================"

# Conversion SVG -> PDF avec rsvg-convert
$(PDF_DIR)/%.pdf: $(SVG_DIR)/%.svg
	@echo "Converting $< to $@"
	@rsvg-convert -f pdf -o "$@" "$<"

#---Ly
$(LY_DIR):
	@echo Creating folder "$@"
	@mkdir -p $@
	@echo "*" > $@/.gitignore

.PHONY: ly-obj
ly-obj: $(LY_DIR) $(LY_OBJECTS)
	@echo "==========================="
	@echo "Converted to Lilypond files"
	@echo "==========================="

$(LY_DIR)/%.ly: $(MEI_DIR)/%.mei
	@verovio $^ -t ly -o $@

#---Archives
$(ARCHIVES_DIR):
	@echo Creating folder "$@"
	@mkdir -p $@
	@echo "*" > $@/.gitignore

.PHONY: archives-obj
archives-obj: $(ARCHIVES_DIR) $(ARCHIVES)
	@echo "================="
	@echo "Archives created."
	@echo "================="

$(ARCHIVES_DIR)/$(collection)_FilesAll.zip: $(MSCZ_OBJECTS) $(MEI_OBJECTS) $(SVG_OBJECTS) $(PDF_OBJECTS) $(MID_OBJECTS) $(LY_OBJECTS)
	@echo "All ..."
	@zip -9 -y -r -q $@ $^

$(ARCHIVES_DIR)/$(collection)_FilesSvg.zip: $(SVG_OBJECTS)
	@echo "SVG ..."
	@zip -9 -y -r -q $@ $^

$(ARCHIVES_DIR)/$(collection)_FilesMei.zip: $(MEI_OBJECTS)
	@echo "MEI ..."
	@zip -9 -y -r -q $@ $^

$(ARCHIVES_DIR)/$(collection)_FilesLy.zip: $(LY_OBJECTS)
	@echo "Lilypond ..."
	@zip -9 -y -r -q $@ $^

$(ARCHIVES_DIR)/$(collection)_FilesMid.zip: $(MID_OBJECTS)
	@echo "midi ..."
	@zip -9 -y -r -q $@ $^

$(ARCHIVES_DIR)/$(collection)_FilesPdf.zip: $(PDF_OBJECTS)
	@echo "pdf ..."
	@zip -9 -y -r -q $@ $^

#---Cypher dir
$(CYPHER_DIR):
	@echo Creating folder "$@"
	@mkdir -p $@
	@echo "*" > $@/.gitignore

#---Clean
.PHONY: clean
clean:
	@echo "======================="
	@echo "Cleaning $(collection)"
	@echo "======================="
	@rm -rf $(CYPHER_DIR)/*.cypher
	@rm -rf $(PDF_OBJECTS)
	@rm -rf $(SVG_OBJECTS)
	@rm -rf $(MSCZ_OBJECTS)
	@rm -rf $(LY_OBJECTS)
	@rm -rf $(MID_OBJECTS)
	@rm -rf $(ARCHIVES_DIR)/*.zip
	@rm -rf load_DB.cql
