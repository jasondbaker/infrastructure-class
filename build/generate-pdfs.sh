#!/bin/bash
#
# Generate PDF files from AsciiDoc files
#
WORKDIR=".."
PDFDIR="${1:-pdfs}"
ASCIIDCOTOR_CMD="asciidoctor-pdf"

cd $WORKDIR

# create the pdf directory if it doesn't already exist
if ! [ -d $PDFDIR ] ; then
    mkdir $PDFDIR
fi

# if we set to build with docker, we can do that.
if [ -n "$DOCKER_BUILD" ]; then
  ASCIIDCOTOR_CMD="docker run -it -v $(pwd):/documents/ asciidoctor/docker-asciidoctor asciidoctor"
fi

# loop through all .adoc files in working dir
for FILENAME in $(ls *.adoc)
do
  echo "Generating PDF for $FILENAME"
  # use asciidoctor to generate file in pdf dir
  $ASCIIDCOTOR_CMD -D $PDFDIR $FILENAME
done
