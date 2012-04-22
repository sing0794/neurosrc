#!/bin/bash
MASTERFILE=$1
GENERATEDFILE=$2

# -w to ignore spaces
var=`diff -w $MASTERFILE $GENERATEDFILE | sed '1q;d'`

if [ -z $var ]
then
    echo "No difference"
elif [[ $var = *a* ]]; then
        difflines=`echo $var | sed 's/a/\n/g'`

    gendiffs=`echo $difflines | cut -d \   -f 2`

    gendifflines=`echo $gendiffs | sed 's/,/\n/g'`

    genfirst=`echo $gendifflines | cut -d \   -f 1`

    genfirstdiff=`cat $GENERATEDFILE | sed $genfirst'q;d'`

    echo 'added:' $genfirstdiff 'at line:' $genfirst
    
elif [[ $var = *c* ]]; then
        difflines=`echo $var | sed 's/c/\n/g'`

    masterdiffs=`echo $difflines | cut -d \   -f 1`
    gendiffs=`echo $difflines | cut -d \   -f 2`

    masterdifflines=`echo $masterdiffs | sed 's/,/\n/g'`
    gendifflines=`echo $gendiffs | sed 's/,/\n/g'`

    masterfirst=`echo $masterdifflines | cut -d \   -f 1`
    genfirst=`echo $gendifflines | cut -d \   -f 1`

    masterfirstdiff=`cat $MASTERFILE | sed $masterfirst'q;d'`
    genfirstdiff=`cat $GENERATEDFILE | sed $genfirst'q;d'`

    echo 'value:' $masterfirstdiff 'at line:' $masterfirst
    echo 'value:' $genfirstdiff 'at line:' $genfirst
    
elif  [[ $var = *d* ]]; then
        difflines=`echo $var | sed 's/d/\n/g'`

    masterdiffs=`echo $difflines | cut -d \   -f 1`

    masterdifflines=`echo $masterdiffs | sed 's/,/\n/g'`

    masterfirst=`echo $masterdifflines | cut -d \   -f 1`

    masterfirstdiff=`cat $MASTERFILE | sed $masterfirst'q;d'`

    echo 'deleted:' $masterfirstdiff 'from line: ' $masterfirst
fi
