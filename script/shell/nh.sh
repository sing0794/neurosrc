#!/bin/bash
START=$(date +%s)

hadoop fs -rmr /neuro/output
hadoop fs -rmr /neuro/input
hadoop fs -rmr /neuro/lookup
rm /neuro/neurosrc/script/hive/createrats.q
rm /neuro/neurosrc/script/hive/alterrats.q
rm /neuro/neurosrc/script/hive/insertratsaverage.q

hadoop fs -mkdir /neuro/input
hadoop fs -mkdir /neuro/lookup
hadoop fs -mkdir /neuro/output/passes
hadoop fs -mkdir /neuro/output/phase

hadoop fs -put /neuro/data/morlet-2000.csv /neuro/lookup/morlet-2000.dat
hadoop fs -put /neuro/data/signals/*.csv /neuro/input/
hadoop fs -put /neuro/data/passes/*.csv /neuro/output/passes/
hadoop fs -put /neuro/data/phase/*.csv /neuro/output/phase/

hadoop jar /neuro/neurosrc/lib/NeuroHadoop.jar convolution.rchannel.ConvolutionJob /neuro/input /neuro/output/rats > /neuro/output.txt

END=$(date +%s)
DIFF=$(($END - $START))
echo "ConvolutionJob took $DIFF seconds"

#Hive scripts
#Ratsaverage
START=$(date +%s)
hive -f /neuro/neurosrc/script/hive/createrats.q
hive -f /neuro/neurosrc/script/hive/alterrats.q
hive -f /neuro/neurosrc/script/hive/insertratsaverage.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Ratsaverage took $DIFF seconds"

#Ratstats
START=$(date +%s)
hive -f /neuro/neurosrc/script/hive/ratstats.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Ratstats took $DIFF seconds"

#Passes
START=$(date +%s)
hive -f /neuro/neurosrc/script/hive/passesngc.q > /neuro/neurosrc/script/hive/ratssubset.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Passes & script for ratssubset took $DIFF seconds"

#Ratssubset
START=$(date +%s)
hive -f /neuro/neurosrc/script/hive/ratssubset.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Ratssubset took $DIFF seconds"

#Phasebucket
START=$(date +%s)
hive --hiveconf maxphaserange=100 -f /neuro/neurosrc/script/hive/phasebucket.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Phasebucket took $DIFF seconds"
