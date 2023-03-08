#!/bin/bash
WORKDIR=$1
mkdir -p /media/sf_E_DRIVE/pcn/$WORKDIR/scans
mv /media/sf_E_DRIVE/pcn/input/*.jpg /media/sf_E_DRIVE/pcn/$WORKDIR/scans
python imagesplit-facingpages.py -i /media/sf_E_DRIVE/pcn/$WORKDIR/scans/ -o /media/sf_E_DRIVE/pcn/$WORKDIR/ -p tmp.pdf
ocrmypdf /media/sf_E_DRIVE/pcn/$WORKDIR/tmp.pdf /media/sf_E_DRIVE/pcn/$WORKDIR/$WORKDIR.pdf
