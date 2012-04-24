	DROP TABLE result;
	CREATE TABLE result 
	LOCATION '/neuro/output/result' 
	AS 
	SELECT r.rat, r.dt, r.channel, r.frequency, p.phaserange, AVG(r.convolution) as convolution
	FROM ratssubset r JOIN phasebuckets p ON r.time = p.time
	GROUP BY r.rat, r.dt, r.channel, r.frequency, p.phaserange
	;
	