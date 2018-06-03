/*************************************************************************************************************
**
**  Script      : personnel_table.sql
**  Created Date: 22-April-2018
**  Author      : Daniel Lowe
**  Description : Create sequence and table for personnel information
**
** Date      | Changed By  | Block                        | Change Description
** ----------+-------------+------------------------------+-----------------------------------------
** 22-Apr-18 | Daniel Lowe | Personnel Sequence           | Created Block
** ----------+-------------+------------------------------+-----------------------------------------
**
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Personnel Sequence
*************************************************************************************************************/
DROP SEQUENCE IF EXISTS MRT_DATA.UNIT_SEQ;

CREATE SEQUENCE IF NOT EXISTS MRT_DATA.PERSONNEL_SEQ
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    CACHE 32;
/*************************************************************************************************************
**  End: Personnel Sequence
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Unit Table
*************************************************************************************************************/
DROP INDEX IF EXISTS MRT_DATA.PERSONNEL_PK;
DROP INDEX IF EXISTS MRT_DATA.IDX_PERSONNEL_NM;
DROP INDEX IF EXISTS MRT_DATA.IDX_PERSONNEL_ID;
DROP INDEX IF EXISTS MRT_DATA.IDX_PERSONNEL_AUNIT;
DROP INDEX IF EXISTS MRT_DATA.IDX_PERSONNEL_HUNIT;
DROP INDEX IF EXISTS MRT_DATA.IDX_PERSONNEL_SUPER;

ALTER TABLE MRT_DATA.PERSONNEL DROP CONSTRAINT IF EXISTS MRT_DATA.FK_PERSONNEL_AUNIT;
ALTER TABLE MRT_DATA.PERSONNEL DROP CONSTRAINT IF EXISTS MRT_DATA.FK_PERSONNEL_HUNIT;

DROP TABLE IF EXISTS MRT_DATA.PERSONNEL CASCADE;

CREATE CACHED TABLE IF NOT EXISTS MRT_DATA.PERSONNEL (
    PERSONNEL_ID    VARCHAR(15),
    GIVEN_NAME      VARCHAR(25),
    MIDDLE_NAME     VARCHAR(25),
    SURNAME         VARCHAR(50),
    SUFFIX          VARCHAR(5),
    IDENTIFIER      VARCHAR(25),
    ASSIGNED_UNIT   VARCHAR(15),
    HOME_UNIT       VARCHAR(15),
    SUPERVISOR      VARCHAR(15),
    COMPONENT       VARCHAR(15),
    RANK            VARCHAR(15),
    STATUS          VARCHAR(15),
);

ALTER TABLE MRT_DATA.PERSONNEL ALTER COLUMN PERSONNEL_ID SET NOT NULL;
ALTER TABLE MRT_DATA.PERSONNEL ALTER COLUMN GIVEN_NAME   SET NOT NULL;
ALTER TABLE MRT_DATA.PERSONNEL ALTER COLUMN SURNAME      SET NOT NULL;
ALTER TABLE MRT_DATA.PERSONNEL ALTER COLUMN IDENTIFIER   SET NOT NULL;
ALTER TABLE MRT_DATA.PERSONNEL ALTER COLUMN COMPONENT    SET NOT NULL;

CREATE PRIMARY KEY IF NOT EXISTS MRT_DATA.PERSONNEL_PK ON MRT_DATA.PERSONNEL(PERSONNEL_ID);
CREATE UNIQUE INDEX IF NOT EXISTS MRT_DATA.IDX_PERSONNEL_NM ON MRT_DATA.PERSONNEL(SURNAME,GIVEN_NAME,MIDDLE_NAME);
CREATE UNIQUE INDEX IF NOT EXISTS MRT_DATA.IDX_PERSONNEL_ID ON MRT_DATA.PERSONNEL(IDENTIFIER);
CREATE INDEX IF NOT EXISTS MRT_DATA.IDX_PERSONNEL_AUNIT ON MRT_DATA.PERSONNEL(ASSIGNED_UNIT);
CREATE INDEX IF NOT EXISTS MRT_DATA.IDX_PERSONNEL_HUNIT ON MRT_DATA.PERSONNEL(HOME_UNIT);
CREATE INDEX IF NOT EXISTS MRT_DATA.IDX_PERSONNEL_SUPER ON MRT_DATA.PERSONNEL(SUPERVISOR);

ALTER TABLE MRT_DATA.PERSONNEL ALTER COLUMN PERSONNEL_ID SET DEFAULT MRT_DATA.NEW_PID(NEXTVAL('MRT_DATA.PERSONNEL_SEQ'));

ALTER TABLE MRT_DATA.PERSONNEL ADD CONSTRAINT (MRT_DATA.FK_PERSONNEL_AUNIT) FOREIGN KEY (MRT_DATA.ASSIGNED_UNIT) REFERENCES MRT_DATA.UNIT(UNIT_ID) ON DELETE CASCADE;
ALTER TABLE MRT_DATA.PERSONNEL ADD CONSTRAINT (MRT_DATA.FK_PERSONNEL_HUNIT) FOREIGN KEY (MRT_DATA.HOME_UNIT) REFERENCES MRT_DATA.UNIT(UNIT_ID) ON DELETE CASCADE;
/*************************************************************************************************************
**  End: Unit Table
*************************************************************************************************************/
