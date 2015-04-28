#!/bin/sh
#
# arg 1: pt 
# arg 2: ttf name
# arg 3: internalname
#
PT=$1
ARG3=$3
BDF=${ARG3}.bdf
CFILE=./pixel/ucg_font_${ARG3}_tf.c
CFILER=./pixel/ucg_font_${ARG3}_tr.c
CFILEN=./pixel/ucg_font_${ARG3}_tn.c
IDENTIFIER=ucg_font_${ARG3}
echo $2  ... ${CFILE}
../otf2bdf/otf2bdf -p $1 -r 72 $2 -o ${BDF}
# replace BDF if it exists
if test -r ../ttfbdfupdate/${BDF}; then echo ${BDF} "manual update" &&  cp ../ttfbdfupdate/${BDF} .; fi
../bdf2ucg/bdf2ucg ${BDF} ${IDENTIFIER}_tf ${CFILE} >/dev/null
../bdf2ucg/bdf2ucg -b 0 -m '32-127>32'  ${BDF} ${IDENTIFIER}_tr ${CFILER} >/dev/null
../bdf2ucg/bdf2ucg -b 0 -m '32,42-58>42' ${BDF} ${IDENTIFIER}_tn ${CFILEN} >/dev/null
#cp ${CFILE} ../../../src/.