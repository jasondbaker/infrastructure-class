#!/bin/bash
#
# Generate PDF files from AsciiDoc files
#
WORKDIR=".."
PDFDIR="${1:-pdfs}"

cd $WORKDIR

# create the pdf directory if it doesn't already exist
if ! [ -d $PDFDIR ] ; then
    mkdir $PDFDIR
fi

# loop through all .adoc files in working dir
for FILENAME in $(ls *.adoc)
do
  echo "Generating PDF for $FILENAME"
  # use asciidoctor to generate file in pdf dir
  asciidoctor-pdf -D $PDFDIR $FILENAME
done
