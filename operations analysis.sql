SELECT * FROM operations.consolidated_csv;

SELECT distinct(consolidated_csv.KEYS), distance_km, state from consolidated_csv
where state="Lagos"

select count(consolidated_csv.keys) as number_of_keys from consolidated_csv
where state="Lagos"

select loadingpoint, destination, consolidated_csv.keys, state, geo_zones, Distance_km, 5_ton, 7_ton
from consolidated_csv where Geo_Zones="South East"

select Geo_zones, sum(5_ton), sum(7_ton), sum(10_ton), sum(15_ton), sum(30_ton), sum(40_ton), sum(45_ton), sum(60_ton)
from consolidated_csv where Geo_Zones="South East"

select Geo_zones, sum(5_ton), sum(7_ton), sum(10_ton), sum(15_ton), sum(30_ton), sum(40_ton), sum(45_ton), sum(60_ton)
from consolidated_csv where Geo_Zones="South South"

select Geo_zones, sum(5_ton), sum(7_ton), sum(10_ton), sum(15_ton), sum(30_ton), sum(40_ton), sum(45_ton), sum(60_ton)
from consolidated_csv where Geo_Zones="South west"

SELECT Geo_Zones, Distance_km, 5_ton,7_ton, 10_ton, 15_ton, 30_ton, 40_ton, 45_ton, 60_ton
FROM consolidated_csv

select sum(5_ton) from consolidated_csv where Geo_Zones="South west"

Select Distinct Geo_Zones 
FROM consolidated_csv

--------------------------------------------------------------------------------------------------------------------------------------------------

# Looking into details on revenue for Lagos state per truck
CREATE VIEW LagosRevenueView
AS
SELECT * FROM consolidated_csv
WHERE State LIKE'lagos'

SELECT * FROM LagosRevenueView

# Creating a view for Revenue generated for South West
CREATE VIEW SouthWestRevenue
AS 
SELECT Geo_Zones, Distance_km, 5_ton,7_ton, 10_ton, 15_ton, 30_ton, 40_ton, 45_ton, 60_ton
FROM consolidated_csv WHERE Geo_Zones = 'South West'

Select * from SouthWestRevenue



# Creating a view for Revenue generated per Geo Zone
CREATE VIEW TotalSouthWestRevenue
AS 
SELECT Geo_Zones, sum(Distance_km), sum(5_ton), sum(7_ton), sum(10_ton), sum(15_ton), sum(30_ton), sum(40_ton), sum(45_ton), sum(60_ton)
FROM consolidated_csv WHERE Geo_Zones = 'South West'

-- drop view TotalSouthWestRevenuePerLocation

Select * FROM TotalSouthWestRevenue


----------------------------------------------------TRIGGER--------------------------------------------------------------------
SELECT * FROM consolidated_csv

CREATE TRIGGER Demo_Data
ON consolidated_csv
AFTER INSERT
AS
BEGIN
PRINT 'INSERT IS NOT ALLOWED. YOU NEED APPROVAL'
ROLLBACK TRANSACTION
END
GO

SELECT * FROM consolidated_csv


-------------------------------- STORED PROCEDURE----------------------------------------------------------------------------------------
DROP procedure IF EXISTS ProcedureTest()

DELIMITER //
CREATE PROCEDURE ProcedureTest()
BEGIN
SELECT Geo_Zones, Destination, Distance_km, 5_ton, 7_ton, 10_ton, 30_ton
from consolidated_csv
where Distance_km > 800;
END //
DELIMITER ;

CALL ProcedureTest

CALL TestProcedure

-- DROP PROCEDURE ProcedureTest

----------------------------- ANOTHER STORE PROCEDURE

DELIMITER //
CREATE PROCEDURE LocationByDelivery()
BEGIN
SELECT Loadingpoint, Destination, Distance_km, 40_ton, 45_ton, 60_ton
FROM consolidated_csv
order by 5,6;
END //
DELIMITER ;

CALL LocationByDelivery

----------------------------- ANOTHER STORE PROCEDURE
DELIMITER //
CREATE PROCEDURE PickUpSales(IN Loadingpoint varchar(20))
BEGIN
SELECT Loadingpoint, Destination, Distance_km, 40_ton, 45_ton, 60_ton
FROM consolidated_csv
where Loadingpoint=Loadingpoint;
-- order by 5,6;
END //
DELIMITER ;

CALL PickUpSales('Ibadan')

-- drop procedure ZonalRevenue

----------------------------- ANOTHER STORE PROCEDURE
DELIMITER //
CREATE PROCEDURE ZonalRevenue(IN Geo_Zones varchar(20))
BEGIN
SELECT Geo_Zones, Destination, Distance_km, 40_ton, 45_ton, 60_ton
FROM consolidated_csv
where Geo_Zones=Geo_Zones;
-- order by 5,6;
END //
DELIMITER ;

CALL ZonalRevenue('South West')

-------- drop procedure ZonalRevenue

----------------------------- ANOTHER STORE PROCEDURE
DELIMITER //
CREATE PROCEDURE KeysCount(OUT DestinationKeys int)
begin
select count(consolidated_csv.keys) into DestinationKeys
from consolidated_csv
where consolidated_csv.keys='lagos-abule';
END //
DELIMITER ;

CALL KeysCount(@DestinationKeys)
SELECT @DestinationKeys FROM consolidated_csv