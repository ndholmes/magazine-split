#!/bin/bash
WORKDIR=$1
mkdir -p /media/sf_E_DRIVE/rrtp/$WORKDIR/scans
mv /media/sf_E_DRIVE/pcn/input/*.jpg /media/sf_E_DRIVE/rrtp/$WORKDIR/scans
python imagesplit.py -r 0 -i /media/sf_E_DRIVE/rrtp/$WORKDIR/scans/ -o /media/sf_E_DRIVE/rrtp/$WORKDIR/ -p tmp.pdf
ocrmypdf /media/sf_E_DRIVE/rrtp/$WORKDIR/tmp.pdf /media/sf_E_DRIVE/rrtp/$WORKDIR/$WORKDIR.pdf
mkdir -p /media/sf_E_DRIVE/rrtp/$WORKDIR/pages
mv /media/sf_E_DRIVE/rrtp/$WORKDIR/*.jpg /media/sf_E_DRIVE/rrtp/$WORKDIR/pages
rm /media/sf_E_DRIVE/rrtp/$WORKDIR/tmp.pdf
