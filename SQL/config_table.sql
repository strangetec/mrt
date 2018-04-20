/*************************************************************************************************************
**
**  Script      : config_table.sql
**  Created Date: 19-April-2018
**  Author      : Daniel Lowe
**  Description : Create sequence and table for configuration information
**
** Date      | Changed By  | Block                        | Change Description
** ----------+-------------+------------------------------+-----------------------------------------
** 19-Apr-18 | Daniel Lowe | Configuration Sequence       | Created Block
** ----------+-------------+------------------------------+-----------------------------------------
**           |             | Configuration Table          | Created Block
** ----------+-------------+------------------------------+-----------------------------------------
**           |             | Configuration Rights         | Created Block
** ----------+-------------+------------------------------+-----------------------------------------
**           |             | Configuration Default Values | Created Block
** ----------+-------------+------------------------------+-----------------------------------------
**
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Configuration Sequence
*************************************************************************************************************/
DROP SEQUENCE IF EXISTS MRT_DATA.CONFIG_SEQ;

CREATE SEQUENCE IF NOT EXISTS MRT_DATA.CONFIG_SEQ
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    CACHE 32;
/*************************************************************************************************************
**  End: Configuration Sequence
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Configuration Table
*************************************************************************************************************/
DROP INDEX IF EXISTS MRT_DATA.CONFIG_PK;
DROP INDEX IF EXISTS MRT_DATA.IDX_CONFIG;
DROP TABLE IF EXISTS MRT_DATA.CONFIGURATIONS CASCADE;

CREATE CACHED TABLE IF NOT EXISTS MRT_DATA.CONFIGURATIONS (
    Config_ID    VARCHAR(15) AS MRT_DATA.NEW_PID(NEXTVAL('MRT_DATA.CONFIG_SEQ')),
    Parent_ID    VARCHAR(15),
    Config_Value VARCHAR(25),
    Config_Desc  VARCHAR(1000)
);

ALTER TABLE MRT_DATA.CONFIGURATIONS ALTER COLUMN Config_ID SET NOT NULL;
CREATE PRIMARY KEY IF NOT EXISTS MRT_DATA.CONFIG_PK ON MRT_DATA.CONFIGURATIONS(Config_ID);
ALTER TABLE MRT_DATA.CONFIGURATIONS ALTER COLUMN Config_Value SET NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS MRT_DATA.IDX_CONFIG ON MRT_DATA.CONFIGURATIONS(Parent_ID,Config_Value);
/*************************************************************************************************************
**  End: Configuration Table
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Configuration Rights
*************************************************************************************************************/
GRANT SELECT,INSERT,UPDATE,DELETE ON MRT_DATA.CONFIGURATIONS TO MRT_USERS;
/*************************************************************************************************************
**  End: Configuration Rights
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Configuration Default Values
*************************************************************************************************************/
MERGE INTO MRT_DATA.CONFIGURATIONS conf
    USING (SELECT 'Unit Type' Config_Value,
                  'Types Of Units' Config_Desc
           FROM DUAL) AS fnoc
    ON (conf.Config_Value = fnoc.Config_Value AND
        conf.Config_Desc  = fnoc.Config_Desc)
    WHEN NOT MATCHED THEN
        INSERT (conf.Config_Value,conf.Config_Desc)
        VALUES (fnoc.Config_Value,fnoc.Config_Desc);
/*************************************************************************************************************
**  End: Configuration Default Values
*************************************************************************************************************/
