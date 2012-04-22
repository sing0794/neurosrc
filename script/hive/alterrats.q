ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='7a');
ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='r1r2');

ALTER TABLE ratsaverage ADD PARTITION(rat='R192',dt='2009-11-19',channel='r1r2');

ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='r1');

ALTER TABLE ratsaverage ADD PARTITION(rat='R192',dt='2009-11-19',channel='r1');

ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='8a');
ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='12a');
ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='11a');
ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='6a');
ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='5a');
ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='10a');
ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='3a');

ALTER TABLE ratsaverage ADD PARTITION(rat='R192',dt='2009-11-19',channel='avg');
ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='4a');
ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='2a');
ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='1a');
ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='r2');

ALTER TABLE ratsaverage ADD PARTITION(rat='R192',dt='2009-11-19',channel='r2');

ALTER TABLE rats ADD PARTITION(rat='R192',dt='2009-11-19',channel='9a');
