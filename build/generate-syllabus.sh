#!/bin/bash
#
# Generate syllabus.html file from AsciiDoc files
#
WORKDIR=".."
PDFDIR="${1:-pdfs}"

cd $WORKDIR

# create the pdf directory if it doesn't already exist
if ! [ -d $PDFDIR ] ; then
    mkdir $PDFDIR
fi

# use asciidoctor to generate file in pdf dir
asciidoctor -D $PDFDIR syllabus.adoc 
