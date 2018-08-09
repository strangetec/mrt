/*************************************************************************************************************
**
**  Script      : unit_table.sql
**  Created Date: 19-April-2018
**  Author      : Daniel Lowe
**  Description : Create sequence and table for unit information
**
** Date      | Changed By  | Block                        | Change Description
** ----------+-------------+------------------------------+-----------------------------------------
** 19-Apr-18 | Daniel Lowe | Unit Sequence                | Created Block
** ----------+-------------+------------------------------+-----------------------------------------
**           |             | Unit Table                   | Created Block
** ----------+-------------+------------------------------+-----------------------------------------
**
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Unit Sequence
*************************************************************************************************************/
DROP SEQUENCE IF EXISTS MRT_DATA.UNIT_SEQ;

CREATE SEQUENCE IF NOT EXISTS MRT_DATA.UNIT_SEQ
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    CACHE 32;
/*************************************************************************************************************
**  End: Unit Sequence
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Unit Table
*************************************************************************************************************/
DROP INDEX IF EXISTS MRT_DATA.UNIT_PK;
DROP INDEX IF EXISTS MRT_DATA.IDX_UNIT_ID;
DROP INDEX IF EXISTS MRT_DATA.IDX_UNIT_NM;
DROP INDEX IF EXISTS MRT_DATA.IDX_UNIT_PRT;

DROP TABLE IF EXISTS MRT_DATA.UNIT CASCADE;

CREATE CACHED TABLE IF NOT EXISTS MRT_DATA.UNIT (
    UNIT_ID        VARCHAR(15),
    IDENTIFIER     VARCHAR(25),
    UNIT_NAME      VARCHAR(150),
    STREET_ADDRESS VARCHAR(150),
    CITY           VARCHAR(25),
    UNIT_STATE     VARCHAR(2),
    ZIP_CODE       VARCHAR(5),
    PHONE_NUMBER   VARCHAR(10),
    FAX_NUMBER     VARCHAR(10),
    PARENT_UNIT    VARCHAR(15),
    UNIT_TYPE      VARCHAR(15),
    ARCHIVE        TIMESTAMP
);

ALTER TABLE MRT_DATA.UNIT ALTER COLUMN UNIT_ID SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN IDENTIFIER SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN UNIT_NAME SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN STREET_ADDRESS SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN CITY SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN UNIT_STATE SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN ZIP_CODE SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN PHONE_NUMBER SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN PHONE_NUMBER SET NOT NULL;

ALTER TABLE MRT_DATA.UNIT ALTER COLUMN UNIT_ID SET DEFAULT MRT_DATA.NEW_PID(NEXTVAL('MRT_DATA.UNIT_SEQ'));
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN ARCHIVE SET DEFAULT FALSE;

CREATE PRIMARY KEY IF NOT EXISTS MRT_DATA.UNIT_PK ON MRT_DATA.UNIT(UNIT_ID);
CREATE UNIQUE INDEX IF NOT EXISTS MRT_DATA.IDX_UNIT_ID ON MRT_DATA.UNIT(IDENTIFIER);
CREATE UNIQUE INDEX IF NOT EXISTS MRT_DATA.IDX_UNIT_NM ON MRT_DATA.UNIT(UNIT_NAME);
CREATE INDEX IF NOT EXISTS MRT_DATA.IDX_UNIT_PRT ON MRT_DATA.UNIT(PARENT_UNIT);
/*************************************************************************************************************
**  End: Unit Table
*************************************************************************************************************/
