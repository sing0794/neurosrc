DROP TABLE passes;

CREATE EXTERNAL TABLE passes(mintime INT, maxtime STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ', '
LOCATION '/neuro/output/passes/'
;

-- Add jar for custom Group Concat UDAF
add jar /neuro/lib/NeuroHive.jar;

-- Create temporary Hive UDF Neuro Group Concat (ngc)
create temporary function ngc as 'convolution.hive.udaf.NGroupConcat';

-- Use ngc to generate create script for table rat subset
SELECT concat(
	"
	DROP TABLE ratssubset\;
	CREATE TABLE ratssubset 
	LOCATION '/neuro/output/ratssubset' 
	AS 
	SELECT * FROM rats WHERE ", ngc(concat("((time >= ", mintime, ") AND (time <= ", maxtime, ")) OR ")), "FALSE\;"
	)
FROM passes;
