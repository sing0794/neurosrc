DROP TABLE rats;
DROP TABLE ratsaverage;

CREATE EXTERNAL TABLE rats(time INT, frequency INT, convolution INT)
PARTITIONED BY(rat STRING, dt STRING, channel STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS SEQUENCEFILE LOCATION '/neuro/output/rats';

CREATE TABLE ratsaverage(time INT, frequency INT, convolution INT)
PARTITIONED BY(rat STRING, dt STRING, channel STRING)
LOCATION '/neuro/output/ratsaverage';

