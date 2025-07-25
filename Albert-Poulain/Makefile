#------Init
#-Name of the collection folder
collection = Albert-Poulain

#-Directories
MUSICXML_DIR = musicxml
MEI_DIR = mei
MSCZ_DIR = mscz
MID_DIR = mid
LY_DIR = ly
SVG_DIR = svg
PDF_DIR = pdf

ARCHIVES_DIR = archives

CYPHER_DIR = cypher

DIRS = $(MUSICXML_DIR) $(MEI_DIR) $(MSCZ_DIR) $(MID_DIR) $(LY_DIR) $(SVG_DIR) $(PDF_DIR) $(ARCHIVES_DIR) $(CYPHER_DIR)

#-Sources
SOURCES := $(wildcard $(MUSICXML_DIR)/*.musicxml)
MUSICXML_OBJECTS = $(SOURCES)
MEI_OBJECTS := $(patsubst $(MUSICXML_DIR)/%.musicxml, $(MEI_DIR)/%.mei, $(SOURCES))
MSCZ_OBJECTS := $(patsubst $(MUSICXML_DIR)/%.musicxml, $(MSCZ_DIR)/%.mscz, $(SOURCES))
MID_OBJECTS := $(patsubst $(MUSICXML_DIR)/%.musicxml, $(MID_DIR)/%.mid, $(SOURCES))
LY_OBJECTS := $(patsubst $(MUSICXML_DIR)/%.musicxml, $(LY_DIR)/%.ly, $(SOURCES))
SVG_OBJECTS := $(patsubst $(MUSICXML_DIR)/%.musicxml, $(SVG_DIR)/%.svg, $(SOURCES))
PDF_OBJECTS := $(patsubst $(MUSICXML_DIR)/%.musicxml, $(PDF_DIR)/%.pdf, $(SOURCES))

#TODO: add ly-obj
# ARCHIVES = $(ARCHIVES_DIR)/$(collection)_FilesAll.zip $(ARCHIVES_DIR)/$(collection)_FilesSvg.zip $(ARCHIVES_DIR)/$(collection)_FilesMei.zip $(ARCHIVES_DIR)/$(collection)_FilesMusicxml.zip $(ARCHIVES_DIR)/$(collection)_FilesMid.zip $(ARCHIVES_DIR)/$(collection)_FilesPdf.zip $(ARCHIVES_DIR)/$(collection)_FilesLy.zip
ARCHIVES = $(ARCHIVES_DIR)/$(collection)_FilesAll.zip $(ARCHIVES_DIR)/$(collection)_FilesSvg.zip $(ARCHIVES_DIR)/$(collection)_FilesMei.zip $(ARCHIVES_DIR)/$(collection)_FilesMusicxml.zip $(ARCHIVES_DIR)/$(collection)_FilesMid.zip $(ARCHIVES_DIR)/$(collection)_FilesPdf.zip

#------Rules
#---All
.PHONY: all
# all: mei-obj mid-obj svg-obj mscz-obj pdf-obj archives-obj $(CYPHER_DIR)
# all: $(DIRS) metadata mei-obj mid-obj svg-obj mscz-obj pdf-obj archives-obj $(CYPHER_DIR)
# all: $(DIRS) mid-obj svg-obj mscz-obj pdf-obj archives-obj $(CYPHER_DIR)
all: $(DIRS) mid-obj svg-obj mscz-obj pdf-obj $(CYPHER_DIR)
#TODO: add ly-obj

#---Mei
$(MEI_DIR):
	@echo Creating folder "$@"
	@mkdir -p $@
	@echo "*" > $@/.gitignore

.PHONY: mei-obj
mei-obj: $(MEI_DIR) $(MEI_OBJECTS)
	@echo "======================"
	@echo "Converted to MEI files"
	@echo "======================"

$(MEI_DIR)/%.mei: $(MUSICXML_DIR)/%.musicxml
	@verovio $^ -t mei -o $@

# There is a convertion problem with verovio for those two files (the only ones with two voices ...) : on the second voice, the attribute 'pname' is not set.
$(MEI_DIR)/10343_Avant_deux.mei: $(MSCZ_DIR)/10343_Avant_deux.mscz
	mscore $^ -o $@ || echo "Error while converting $^ to $@"

$(MEI_DIR)/10346_Ride.mei: $(MSCZ_DIR)/10346_Ride.mscz
	mscore $^ -o $@ || echo "Error while converting $^ to $@"

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

$(MID_DIR)/%.mid: $(MUSICXML_DIR)/%.musicxml
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

$(SVG_DIR)/%.svg: $(MUSICXML_DIR)/%.musicxml
	@verovio $^ -t svg -o $@

#---musicxml (does nothing here as it is the source)
$(MUSICXML_DIR):
	@echo Creating folder "$@"
	@mkdir -p $@
	@echo "*" > $@/.gitignore

.PHONY: musicxml-obj
musicxml-obj: metadata

#---mscz
$(MSCZ_DIR):
	@echo Creating folder "$@"
	@mkdir -p $@
	@echo "*" > $@/.gitignore

.PHONY: mscz-obj
mscz-obj: $(MSCZ_DIR) $(MSCZOBJECTS)
	@echo "======================="
	@echo "Converted to MSCZ files"
	@echo "======================="

$(MSCZ_DIR)/%.mscz: $(MUSICXML_DIR)/%.musicxml
	mscore $^ -o $@ || echo "Error while converting $^ to $@"

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

$(LY_DIR)/%.ly: $(MUSICXML_DIR)/%.musicxml
	musicxml2ly $^ -o $@

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

#TODO: add ly-obj
# $(ARCHIVES_DIR)/$(collection)_FilesAll.zip: $(MSCZ_OBJECTS) $(MUSICXML_OBJECTS) $(SVG_OBJECTS) $(PDF_OBJECTS) $(MID_OBJECTS) $(MEI_OBJECTS) $(LY_OBJECTS)
$(ARCHIVES_DIR)/$(collection)_FilesAll.zip: $(MSCZ_OBJECTS) $(MUSICXML_OBJECTS) $(SVG_OBJECTS) $(PDF_OBJECTS) $(MID_OBJECTS) $(MEI_OBJECTS)
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

$(ARCHIVES_DIR)/$(collection)_FilesMusicxml.zip: $(MUSICXML_OBJECTS)
	@echo "musicxml ..."
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


#---Metadata
.PHONY: metadata
metadata: $(MUSICXML_OBJECTS)
	@echo "===================="
	@echo "Editing metadata ..."
	@echo "===================="
	@for file in $^ ; do \
		sh metadataPoulain.sh $${file} ; \
	done;

#---Clean
.PHONY: clean
clean:
	@echo "======================="
	@echo "Cleanning $(collection)"
	@echo "======================="
	@rm -rf $(CYPHER_DIR)/*.cypher
	@rm -rf $(MEI_OBJECTS)
	@rm -rf $(PDF_OBJECTS)
	@rm -rf $(SVG_OBJECTS)
	@rm -rf $(MSCZ_OBJECTS)
	@rm -rf $(LY_OBJECTS)
	@rm -rf $(MID_OBJECTS)
	@rm -rf $(ARCHIVES_DIR)/*.zip
	@rm -rf load_DB.cql

