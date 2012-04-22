INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='R192',dt='2009-11-19',channel='r1r2')
SELECT time, frequency, convolution
FROM rats
WHERE rat='R192'
AND dt='2009-11-19'
AND channel='r1r2'
;

INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='R192',dt='2009-11-19',channel='r1')
SELECT time, frequency, convolution
FROM rats
WHERE rat='R192'
AND dt='2009-11-19'
AND channel='r1'
;

INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='R192',dt='2009-11-19', channel='avg')
SELECT time, frequency, AVG(convolution)
FROM rats
WHERE rat='R192'
AND dt='2009-11-19'
AND NOT(channel LIKE '%r%')
GROUP BY time, frequency
;

INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='R192',dt='2009-11-19',channel='r2')
SELECT time, frequency, convolution
FROM rats
WHERE rat='R192'
AND dt='2009-11-19'
AND channel='r2'
;

