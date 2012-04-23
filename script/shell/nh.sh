#!/bin/bash

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

#Hive scripts

hive -f /neuro/neurosrc/script/hive/createrats.q
hive -f /neuro/neurosrc/script/hive/alterrats.q
hive -f /neuro/neurosrc/script/hive/insertratsaverage.q
hive -f /neuro/neurosrc/script/hive/passesngc.q > /neuro/neurosrc/script/hive/ratssubset.q
hive -f /neuro/neurosrc/script/hive/ratssubset.q
hive --hiveconf maxphaserange=100 -f /neuro/neurosrc/script/hive/phasebucket.q
