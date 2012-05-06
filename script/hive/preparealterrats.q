SELECT DISTINCT concat(
	"
		ALTER TABLE rats ADD PARTITION(rat='", TRIM(rat), "',dt='", TRIM(dt), "',channel='", TRIM(channel), "')\;
	"
	)
FROM session
;
