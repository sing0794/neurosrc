	DROP TABLE ratstats;
	CREATE TABLE ratstats(rat STRING, dt STRING, channel STRING, frequency INT, mean FLOAT, sd FLOAT)
	LOCATION '/neuro/output/ratstats'
	;

	INSERT OVERWRITE TABLE ratstats 
	SELECT rat, dt, channel, frequency, AVG(convolution) AS mean, STDDEV_POP(convolution) AS sd
	FROM ratsaverage
	GROUP BY rat, dt, channel, frequency
	;
