#!/bin/bash
BASEDIR=$1
INPUT_FILE=$2
OUTPUT_NAME=$3
mkdir -p $BASEDIR/$OUTPUT_NAME/scans
convert -density 300 $INPUT_FILE $BASEDIR/$OUTPUT_NAME/scans/x-%03d.png
python imagesplit-facingpages.py -i $BASEDIR/$OUTPUT_NAME/scans/ -o $BASEDIR/$OUTPUT_NAME/ -p tmp.pdf
ocrmypdf $BASEDIR/$OUTPUT_NAME/tmp.pdf $BASEDIR/$OUTPUT_NAME/$OUTPUT_NAME.pdf
