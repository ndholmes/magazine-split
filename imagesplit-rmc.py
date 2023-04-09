#!/usr/bin/python

from PIL import Image
import glob
import os
import sys
import argparse

parser = argparse.ArgumentParser(description="Process a directory of scanned magazine pages into individual images")
parser.add_argument('-i', nargs='?', default='./input/', dest='inputDir')
parser.add_argument('-o', nargs='?', default='./output/', dest='outputDir')
parser.add_argument('-p', nargs='?', default=None, dest='outputPDF')
parser.add_argument('-d', nargs='?', default='300', dest='dpiStr' )

args = vars(parser.parse_args())

inputDir = os.path.dirname(args['inputDir'])
outputDir = args['outputDir']
outputPDF = args['outputPDF']
dpi = int(args['dpiStr'])

print("inputDir = %s\n" % inputDir)
print("outputDir = %s\n" % outputDir)
print("dpi = %d\n" % dpi)

if (0 == len(inputDir)) or not os.path.isdir(inputDir):
   sys.exit("ERROR!  Input path [%s] is not a directory!!!" % (args['inputDir']))


if os.path.isdir(outputDir) is False:
   if os.path.exists(outputDir):
      sys.exit("ERROR!  Output path [%s] is not a directory!!!" % (outputDir))
   else:
      os.makedirs(outputDir)

files = glob.glob("%s/*.jpg" % inputDir)
files += glob.glob("%s/*.tif" % inputDir)
files += glob.glob("%s/*.png" % inputDir)

sortedFiles = sorted(files)

pages = len(sortedFiles) * 2

currentPage = 1
tailPage = currentPage + pages - 1

front = 1

for file in sortedFiles:
   try:
      print("Opening file %s" % file)
      srcImg = Image.open(file, mode='r')
      width,height = srcImg.size
      print("Original image is w=%d h=%d" % (width, height))

      rightHalfPgNum = currentPage
      currentPage += 2
      leftHalfPgNum = tailPage
      tailPage -= 2

      print("This should be the %s, and therefore pages %d and %d" % (['BACK', 'FRONT'][front], leftHalfPgNum, rightHalfPgNum))

      leftHalf = srcImg.crop((0,0,width/2,height))
      rightHalf = srcImg.crop((width/2,0,width,height))

      leftHalf.save("%s/page-%04d.png" % (outputDir, leftHalfPgNum))
      rightHalf.save("%s/page-%04d.png" % (outputDir, rightHalfPgNum))

   except:
      print("Could not load image %s" % file)
      exit
      
if outputPDF is not None:
   pdfCommand = "convert \"%s/*.png\" -density %d -quality 75 \"%s/%s\"" % (outputDir, dpi, outputDir, outputPDF)
   os.system(pdfCommand)
   
   

