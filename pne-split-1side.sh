#!/bin/bash
WORKDIR=$1
mkdir -p /media/sf_E_DRIVE/pcn/$WORKDIR/$WORKDIR
mkdir -p /media/sf_E_DRIVE/pcn/$WORKDIR/resized-scans
pushd /media/sf_E_DRIVE/pcn/input/
for f in *.JPG; do
    mv -- "$f" "${f%.JPG}.jpg"
done
mv /media/sf_E_DRIVE/pcn/input/*.jpg /media/sf_E_DRIVE/pcn/$WORKDIR/$WORKDIR
popd

cp /media/sf_E_DRIVE/pcn/$WORKDIR/$WORKDIR/*.jpg /media/sf_E_DRIVE/pcn/$WORKDIR/resized-scans

python imagesplit-rmc.py -d 300 -i /media/sf_E_DRIVE/pcn/$WORKDIR/resized-scans/ -o /media/sf_E_DRIVE/pcn/$WORKDIR/ -p tmp.pdf
ocrmypdf /media/sf_E_DRIVE/pcn/$WORKDIR/tmp.pdf /media/sf_E_DRIVE/pcn/$WORKDIR/$WORKDIR.pdf
rm /media/sf_E_DRIVE/pcn/$WORKDIR/tmp.pdf
rm /media/sf_E_DRIVE/pcn/$WORKDIR/page*.png
rm -r /media/sf_E_DRIVE/pcn/$WORKDIR/resized-scans

