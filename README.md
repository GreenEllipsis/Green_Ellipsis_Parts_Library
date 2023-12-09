==Main folder==
- Parts go in this folder
- Each part or assembly is in its own folder (or a zipped file of the folder)
- Folder name is partnumber_description or just partnumber
- partnumber format is YYDDDabcNN where abc are your initials and NN is a unique alphanumeric for that YYDDDabc combination

==Part folder==
- contains the part file
- part file name is partnumber_REV x_description, where x is the REV number, REV x and description are optional
- REV follows the ASME Y.100 Appendix C(?) sequence of -, A, B, C, etc
- optionally contains a meta data file
- may contain files used to create the part file or files the part was derived from

==Meta Data File==
- meta data files is in YAML format
- is named partnumber.yaml, where partnumber is the partnumber
- has these optional key/value pairs
  - author:
  - copyright:
  - license:
  - derived from: filename or URL
  - file format: 
  - last edited using: software name, version
  - last updated:
  - next higher assembly:
  - system:


