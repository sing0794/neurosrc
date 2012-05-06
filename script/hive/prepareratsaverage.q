SELECT DISTINCT concat(
	"
		ALTER TABLE ratsaverage ADD PARTITION(rat='", TRIM(rat), "',dt='", TRIM(dt), "',channel='", TRIM(channel), "')\;

		INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='", TRIM(rat), "',dt='", TRIM(dt), "',channel='", TRIM(channel), "')
		SELECT time, frequency, pow(convolution, 2)
		FROM rats
		WHERE rat='", rat, "'
		AND dt='", dt, "'
		AND channel='", channel, "'
		\;
	"
	)
FROM session
WHERE channel LIKE '%r%'
;

SELECT DISTINCT concat(
	"
		ALTER TABLE ratsaverage ADD PARTITION(rat='", TRIM(rat), "',dt='", TRIM(dt), "',channel='", TRIM(channel), "')\;

		INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='", TRIM(rat), "',dt='", TRIM(dt), "',channel='", TRIM(channel), "')
		SELECT time, frequency, AVG(POW(convolution, 2))
		FROM rats
		WHERE rat='", rat, "'
		AND dt='", dt, "'
		AND NOT(channel LIKE '%r%')
		GROUP BY time, frequency
		\;
	"
	)
FROM session
WHERE NOT(channel LIKE '%r%')
;
