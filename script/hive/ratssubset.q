
	DROP TABLE ratssubset;
	CREATE TABLE ratssubset 
	LOCATION '/neuro/output/ratssubset' 
	AS 
	SELECT * FROM rats WHERE ((time >= 6737456) AND (time <=  6786004 )) OR ((time >= 8199236) AND (time <=  8226095 )) OR ((time >= 8903099) AND (time <=  8958654 )) OR ((time >= 9484674) AND (time <=  9513536 )) OR ((time >= 9829182) AND (time <=  9853372 )) OR ((time >= 10542888) AND (time <=  10574753 )) OR ((time >= 11557559) AND (time <=  11577745 )) OR ((time >= 12002833) AND (time <=  12031861 )) OR ((time >= 12670827) AND (time <=  12696853 )) OR ((time >= 13137289) AND (time <=  13165984 )) OR ((time >= 14073548) AND (time <=  14104413 )) OR ((time >= 14634437) AND (time <=  14663633 )) OR ((time >= 18452715) AND (time <=  18475905 )) OR ((time >= 22887270) AND (time <=  22986034 )) OR ((time >= 24721752) AND (time <=  24753617 )) OR ((time >= 25807159) AND (time <=  25834353 )) OR ((time >= 26435615) AND (time <=  26475154 )) OR ((time >= 27708875) AND (time <=  27734066 )) OR ((time >= 30229202) AND (time <=  30257730 )) OR FALSE;
