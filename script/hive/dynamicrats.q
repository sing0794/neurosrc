SELECT DISTINCT concat(
	"
		ALTER TABLE ratsaverage ADD PARTITION(rat='", rat, "',dt='", dt, "',channel='", channel, "')\;

		INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='", rat, "',dt='", dt, "',channel='", channel, "')
		SELECT time, frequency, pow(convolution, 2)
		FROM rats
		WHERE rat='", rat, "'
		AND dt='", dt, "'
		AND channel='", channel, "'
		\;
	"
	)
FROM rats
WHERE channel LIKE '%r%'
;

SELECT DISTINCT concat(
	"
		ALTER TABLE ratsaverage ADD PARTITION(rat='", rat, "',dt='", dt, "',channel='avg')\;

		INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='", rat, "',dt='", dt, "',channel='avg')
		SELECT time, frequency, AVG(POW(convolution, 2))
		FROM rats
		WHERE rat='", rat, "'
		AND dt='", dt, "'
		AND NOT(channel LIKE '%r%')
		GROUP BY time, frequency
		\;
	"
	)
FROM rats
WHERE NOT(channel LIKE '%r%')
;
