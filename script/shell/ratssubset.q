
	DROP TABLE ratssubset;
	CREATE TABLE ratssubset 
	LOCATION '/neuro/output/ratssubset' 
	AS 
	SELECT * FROM rats WHERE FALSE;
