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
CREATE CACHED TABLE IF NOT EXISTS MRT_DATA.UNIT (
    Unit_ID        VARCHAR(15) AS MRT_DATA.NEW_PID(NEXTVAL('MRT_DATA.UNIT_SEQ')),
    Identifier     VARCHAR(25),
    Unit_Name      VARCHAR(150),
    Street_Address VARCHAR(150),
    City           VARCHAR(25),
    Unit_State     VARCHAR(2),
    Phone_Number   VARCHAR(10),
    Fax_Number     VARCHAR(10),
    Parent_Unit    VARCHAR(15),
    Unit_Type      VARCHAR(15)
);

ALTER TABLE MRT_DATA.UNIT ALTER COLUMN Unit_ID SET NOT NULL;
CREATE PRIMARY KEY IF NOT EXISTS MRT_DATA.UNIT_PK ON MRT_DATA.UNIT(Unit_ID);
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN Identifier SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN Unit_Name SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN Street_Address SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN City SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN Unit_State SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN Phone_Number SET NOT NULL;
ALTER TABLE MRT_DATA.UNIT ALTER COLUMN Phone_Number SET NOT NULL;
/*************************************************************************************************************
**  End: Unit Table
*************************************************************************************************************/
