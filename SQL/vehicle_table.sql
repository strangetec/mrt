/*************************************************************************************************************
**
**  Script      : vehicle_table.sql
**  Created Date: 24-June-2018
**  Author      : Daniel Lowe
**  Description : Create sequence and table for vehicle information
**
** Date      | Changed By  | Block                        | Change Description
** ----------+-------------+------------------------------+-----------------------------------------
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Vehicle Sequence
*************************************************************************************************************/
DROP SEQUENCE IF EXISTS MRT_DATA.VEHICLE_SEQ;

CREATE SEQUENCE IF NOT EXISTS MRT_DATA.VEHICLE_SEQ
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    CACHE 32;
/*************************************************************************************************************
**  End: Vehicle Sequence
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Vehicle Table
*************************************************************************************************************/
DROP INDEX IF EXISTS MRT_DATA.VEHICLE_PK;

ALTER TABLE IF EXISTS MRT_DATA DROP CONSTRAINT IF EXISTS FK_VEHICLE_HOME;

DROP TABLE IF EXISTS MRT_DATA.VEHICLE CASCADE;

CREATE CACHED TABLE IF NOT EXISTS MRT_DATA.VEHICLE (
    VEHICLE_ID      VARCHAR(15),
    BUMPER_ID       VARCHAR(15),
    HOME_UNIT       VARCHAR(15),
    ASSIGNED_UNIT   VARCHAR(15),
    VEHICLE_TYPE    VARCHAR(15),
    VEHICLE_STATUS  VARCHAR(15)
);

ALTER TABLE MRT_DATA.VEHICLE ALTER COLUMN VEHICLE_ID     SET NOT NULL;
ALTER TABLE MRT_DATA.VEHICLE ALTER COLUMN BUMPER_ID      SET NOT NULL;
ALTER TABLE MRT_DATA.VEHICLE ALTER COLUMN HOME_UNIT      SET NOT NULL;
ALTER TABLE MRT_DATA.VEHICLE ALTER COLUMN ASSIGNED_UNIT  SET NOT NULL;
ALTER TABLE MRT_DATA.VEHICLE ALTER COLUMN VEHICLE_TYPE   SET NOT NULL;
ALTER TABLE MRT_DATA.VEHICLE ALTER COLUMN VEHICLE_STATUS SET NOT NULL;

CREATE PRIMARY KEY IF NOT EXISTS MRT_DATA.VEHICLE_PK ON MRT_DATA.VEHICLE(VEHICLE_ID);

ALTER TABLE MRT_DATA.VEHICLE ALTER COLUMN VEHICLE_ID SET DEFAULT MRT_DATA.NEW_PID(NEXTVAL('MRT_DATA.VEHICLE_SEQ'));

ALTER TABLE MRT_DATA.VEHICLE ADD CONSTRAINT FK_VEHICLE_HOME   FOREIGN KEY (HOME_UNIT)     REFERENCES MRT_DATA.UNIT(UNIT_ID) ON DELETE CASCADE;
ALTER TABLE MRT_DATA.VEHICLE ADD CONSTRAINT FK_VEHICLE_ASSIGN FOREIGN KEY (ASSIGNED_UNIT) REFERENCES MRT_DATA.UNIT(UNIT_ID) ON DELETE CASCADE;
/*************************************************************************************************************
**  End: Vehicle Table
*************************************************************************************************************/
