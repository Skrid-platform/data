# SKRID Data

This repository contains the source data for the SKRID platform.

This data is used in two ways:
- generation of the Neo4j database, using [`Musypher`](https://gitlab.inria.fr/skrid/data-ingestion) ;
- serving the frontend server (that needs the MEI files).

For the installation in the frontend server, please see in [its README](https://gitlab.inria.fr/skrid/frontend/-/blob/main/README.md).

<!-- TODO: update the following part of the README -->

This README explains the data generation process.

The process is separated in two parts: each collection generates all the files by converting from the source, and then the MEI files are converted to cypher dumps.

The conversion from MEI to cypher graph dump is handled by the [`Musypher`](https://gitlab.inria.fr/skrid/data-ingestion) program.

## File structure
```
.
├── collection_1
│   ├── source/    The source files for this collection (possible to have multiple). The folder name is not `source`, but the filetype.
│   │
│   ├── Makefile   Manages the generation of the files from source for this collection
│   └── README.txt Explain details about this collection
│
├── collection_2
│   └── ...
│
│ ...
│
├── Makefile
└── README.md
```

When data is generated, in each collection folder a directory per filetype is created.

For example :
```
collection_1/
├── archives/
├── cypher/
├── ly/
├── mei/
├── mid/
├── mscz/
├── mus/
├── musicxml/
├── pdf/
├── svg/
│
├── load_DB.cql
│
├── Makefile
└── README.txt
```

## Dependencies
- [`verovio`](https://book.verovio.org/installing-or-building-from-sources/command-line.html) to convert the sources into mei and other file formats ;
- [`mscore`](https://musescore.org/en/download) to do some conversions (try package `musescore` in your Linux distribution) ;
- [`musicxml2ly`](https://manpages.ubuntu.com/manpages/trusty/man1/musicxml2ly.1.html) to convert musicXML to lilypond ;
- [`Musypher`](https://gitlab.inria.fr/skrid/data-ingestion) to create the cypher dump from the MEI. It is not needed to download it, it is done automatically.

## Usage
To generate all files :
```bash
make
```
For each collection, this will :
- generate files in other formats with conversion using the makefile of that collection ;
- generate the cypher dumps using [`Musypher`](https://gitlab.inria.fr/skrid/data-ingestion).

To clean the generated files, run :
```
make clean
```
This will call the `clean` rule of each collection makefile.


Note that the generation will take some time (10 minutes to generate all files, and then around 15 minutes to populate the database).

## Adding a collection
To add a new collection to the database, create a new folder in the root of this repository.

Then add the source in a folder named after the filetype inside the new folder (e.g add all the `.mei` source files in a folder named `mei/` if the source is made of MEI files).

For the generation, create a Makefile by inspiring from the other collections.

The makefile must have two rules : `all` (the first one, so `make` can be called without arguments) and `clean`.
