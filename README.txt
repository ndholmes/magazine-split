1) Set up a venv with python 3.11
(not strictly necessary, but makes some things much happier)

You'll at least need to install the following packages:
ocrmypdf (which will need ghostscript 9.50 or later, which is an isssue on ubuntu 18.04)
Pillow


3) Expand imagemagick's very limited limits
Edit /etc/ImageMagick-6/policy.xml

There's a bunch of resource limits at the top. Just make them huge like this:

  <policy domain="resource" name="memory" value="2GiB"/>
  <policy domain="resource" name="map" value="2GiB"/>
  <policy domain="resource" name="width" value="16KP"/>
  <policy domain="resource" name="height" value="16KP"/>
  <policy domain="resource" name="area" value="2GiB"/>
  <policy domain="resource" name="disk" value="2GiB"/>

You'll also need to tell it that it can work on PDFs and PSs.  Otherwise it thinks (somewhat correctly) that
ghostscript is a security risk.  Down towards the bottom, you'll find policy lines about PDF and PS.  Remove them
and add this in their place:
  <policy domain="coder" rights="read|write" pattern="PDF|PS" />



3) Install tesseract OCR (v5)
sudo add-apt-repository ppa:alex-p/tesseract-ocr5
sudo apt update
sudo apt install tesseract-ocr

