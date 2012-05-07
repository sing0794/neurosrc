	DROP TABLE result;
	CREATE TABLE result(rat STRING, dt STRING, channel STRING, frequency INT, phaserange INT, convolution FLOAT)
	LOCATION '/neuro/output/result' 
	;
	INSERT OVERWRITE TABLE result
	SELECT r.rat, r.dt, r.channel, r.frequency, p.phaserange, AVG(r.convolution) AS convolution
	FROM ratssubset r JOIN phasebuckets p ON r.time = p.time
	GROUP BY r.rat, r.dt, r.channel, r.frequency, p.phaserange
	;
	