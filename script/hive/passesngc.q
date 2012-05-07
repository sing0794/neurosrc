DROP TABLE passes;

CREATE EXTERNAL TABLE passes(mintime INT, maxtime STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ', '
LOCATION '/neuro/output/passes/'
;

-- Add jar for custom Group Concat UDAF
add jar /neuro/neurosrc/lib/NeuroHive.jar;

-- Create temporary Hive UDF Neuro Group Concat (ngc)
create temporary function ngc as 'convolution.hive.udaf.NGroupConcat';

-- Use ngc to generate create script for table rat subset
SELECT concat(
	"DROP TABLE ratssubset\;
	CREATE TABLE ratssubset(rat STRING, dt STRING, channel STRING, time INT, frequency INT, convolution FLOAT)
	LOCATION '/neuro/output/ratssubset' 
	\;
	INSERT OVERWRITE TABLE ratssubset
	SELECT r.rat, r.dt, r.channel, r.time, r.frequency, (r.convolution-s.mean) / s.sd AS convolution
	FROM ratsaverage r JOIN ratstats s ON (
		r.rat = s.rat AND
		r.dt = s.dt AND
		r.channel = s.channel AND
		r.frequency = s.frequency
	)
	WHERE ", ngc(concat("((r.time >= ", mintime, ") AND (r.time <= ", maxtime, ")) OR ")), "FALSE
	\;"
	)
FROM passes;
