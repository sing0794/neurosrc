
	DROP TABLE result;
	CREATE TABLE result 
	LOCATION '/neuro/output/result' 
	AS 
	SELECT r.rat, r.dt, r.channel, r.frequency, p.phaserange, AVG(r.convolution)
	FROM ratssubset r, phasebuckets p
	WHERE r.time = p.time
	GROUP BY r.rat, r.dt, r.channel, r.frequency, p.phaserange
	;
	