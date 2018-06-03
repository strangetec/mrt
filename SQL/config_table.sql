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
    CONFIG_ID    VARCHAR(15),
    PARENT_ID    VARCHAR(15),
    CONFIG_VALUE VARCHAR(100),
    CONFIG_DESC  VARCHAR(1000)
);

ALTER TABLE MRT_DATA.CONFIGURATIONS ALTER COLUMN CONFIG_ID SET NOT NULL;
ALTER TABLE MRT_DATA.CONFIGURATIONS ALTER COLUMN PARENT_ID SET NOT NULL;
ALTER TABLE MRT_DATA.CONFIGURATIONS ALTER COLUMN CONFIG_VALUE SET NOT NULL;

ALTER TABLE MRT_DATA.CONFIGURATIONS ALTER COLUMN CONFIG_ID SET DEFAULT MRT_DATA.NEW_PID(NEXTVAL('MRT_DATA.CONFIG_SEQ'));
ALTER TABLE MRT_DATA.CONFIGURATIONS ALTER COLUMN PARENT_ID SET DEFAULT '0';

CREATE PRIMARY KEY IF NOT EXISTS MRT_DATA.CONFIG_PK ON MRT_DATA.CONFIGURATIONS(CONFIG_ID);
CREATE UNIQUE INDEX IF NOT EXISTS MRT_DATA.IDX_CONFIG ON MRT_DATA.CONFIGURATIONS(PARENT_ID,CONFIG_VALUE);
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
MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT '0','Unit Type','Types Of Units' FROM DUAL
    UNION ALL
    SELECT '0','Component Type','Types of military components' FROM DUAL
    UNION ALL
    SELECT '0','Rank Type','Types of military ranks' FROM DUAL
    UNION ALL
    SELECT '0','Personnel Status','Legal statuses for personnel' FROM DUAL;

MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'Mission Ready'                                   AS CONFIG_VALUE,
           'Personnel is available for mission'              AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'On Mission'                                      AS CONFIG_VALUE,
           'Personnel is currently on mission'               AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'Profile - Mission Capable'                       AS CONFIG_VALUE,
           'Personnel has a profile but mission capable'     AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'Profile - Mission Incapable'                     AS CONFIG_VALUE,
           'Personnel has a profile and not mission capable' AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'On Leave'                                        AS CONFIG_VALUE,
           'Personnel is currently on leave status'          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'Equipment Maintenance'                           AS CONFIG_VALUE,
           'Personnel is maintaining equipment'              AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0'
    UNION ALL
    SELECT CONFIG_ID                                         AS PARENT_ID,
           'Rest Period'                                     AS CONFIG_VALUE,
           'Personnel is on post-mission rest period'        AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Personnel Status'
      AND PARENT_ID = '0';

MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                AS PARENT_ID,
           'Army Unit Type'         AS CONFIG_VALUE,
           'Types of US Army units' AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Unit Type'
    UNION ALL
    SELECT CONFIG_ID                AS PARENT_ID,
           'Air Force Unit Type'         AS CONFIG_VALUE,
           'Types of US Air Force units' AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Unit Type';

MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Field Army'                   AS CONFIG_VALUE,
           'US Field Army Unit Type'      AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Corps'                   AS CONFIG_VALUE,
           'US Army Corps Unit Type'      AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Division'                AS CONFIG_VALUE,
           'US Army Division Unit Type'   AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Brigade'                 AS CONFIG_VALUE,
           'US Army Brigade Unit Type'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Regiment'                AS CONFIG_VALUE,
           'US Army Regiment Unit Type'   AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Group'                   AS CONFIG_VALUE,
           'US Army Group Unit Type'      AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Battalion'               AS CONFIG_VALUE,
           'US Army Battalion Unit Type'  AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Squadron'                AS CONFIG_VALUE,
           'US Army Squadron Unit Type'   AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Company'                 AS CONFIG_VALUE,
           'US Army Company Unit Type'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Battery'                 AS CONFIG_VALUE,
           'US Army Battery Unit Type'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Troop'                   AS CONFIG_VALUE,
           'US Army Troop Unit Type'      AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Detachment'              AS CONFIG_VALUE,
           'US Army Detachment Unit Type' AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'Army Platoon'                 AS CONFIG_VALUE,
           'US Army Platoon Unit Type'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Unit Type'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Unit Type');

MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Army'                        AS CONFIG_VALUE,
           'US Active Duty Army'         AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Air Force'                   AS CONFIG_VALUE,
           'US Active Duty Air Force'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Navy'                        AS CONFIG_VALUE,
           'US Active Duty Navy'         AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Marine Corps'                AS CONFIG_VALUE,
           'US Active Duty Marine Corps' AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Coast Guard'                 AS CONFIG_VALUE,
           'US Coast Guard'              AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Army Reserves'               AS CONFIG_VALUE,
           'US Army Reserves'            AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Army Guard'                  AS CONFIG_VALUE,
           'US State Army Guard'         AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Air Force Reserves'          AS CONFIG_VALUE,
           'US Air Force Reserves'       AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Air Guard'                   AS CONFIG_VALUE,
           'US State Air Force Guard'    AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Marine Reserves'             AS CONFIG_VALUE,
           'US Marine Reserves'          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Navy Reserves'               AS CONFIG_VALUE,
           'US Navy Reserves'            AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type'
    UNION ALL
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Coast Guard Reserves'        AS CONFIG_VALUE,
           'US Coast Guard Reserves'     AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Component Type';

MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                     AS PARENT_ID,
           'Army Ranks'                  AS CONFIG_VALUE,
           'US Army Ranks'               AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Rank Type';

MERGE INTO MRT_DATA.CONFIGURATIONS(PARENT_ID, CONFIG_VALUE, CONFIG_DESC) KEY (PARENT_ID,CONFIG_VALUE)
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E1 - Private'                 AS CONFIG_VALUE,
           'PVT'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E2 - Private Second Class'    AS CONFIG_VALUE,
           'PV2'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E3 - Private First Class'     AS CONFIG_VALUE,
           'PFC'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E4 - Corporal'                AS CONFIG_VALUE,
           'CPL'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E4 - Specialist'              AS CONFIG_VALUE,
           'SPC'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E5 - Sergeant'                AS CONFIG_VALUE,
           'SGT'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E6 - Staff Sergeant'          AS CONFIG_VALUE,
           'SSG'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E7 - Sergeant First Class'    AS CONFIG_VALUE,
           'SFC'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E8 - Master Sergeant'         AS CONFIG_VALUE,
           'MSG'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E8 - First Sergeant'          AS CONFIG_VALUE,
           '1SG'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E9 - Sergeant Major'          AS CONFIG_VALUE,
           'SGM'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'E9 - Command Sergeant Major'  AS CONFIG_VALUE,
           'CSM'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'W1 - Warrant Officer 1'       AS CONFIG_VALUE,
           'WO1'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'W2 - Chief Warrant Officer 2' AS CONFIG_VALUE,
           'CW2'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'W3 - Chief Warrant Officer 3' AS CONFIG_VALUE,
           'CW3'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'W4 - Chief Warrant Officer 4' AS CONFIG_VALUE,
           'CW4'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'W5 - Chief Warrant Officer 5' AS CONFIG_VALUE,
           'CW5'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O1 - Second Lieutenant'       AS CONFIG_VALUE,
           '2LT'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O2 - First Lieutenant'        AS CONFIG_VALUE,
           '1LT'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O3 - Captain'                 AS CONFIG_VALUE,
           'CPT'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O4 - Major'                   AS CONFIG_VALUE,
           'MAJ'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O5 - Lieutenant Colonel'      AS CONFIG_VALUE,
           'LTC'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O6 - Colonel'                 AS CONFIG_VALUE,
           'COL'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O7 - Brigadier General'       AS CONFIG_VALUE,
           'BG'                           AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O8 - Major General'           AS CONFIG_VALUE,
           'MG'                           AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O9 - Lieutenant General'      AS CONFIG_VALUE,
           'LTG'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type')
    UNION ALL
    SELECT CONFIG_ID                      AS PARENT_ID,
           'O10 - General'                AS CONFIG_VALUE,
           'GEN'                          AS CONFIG_DESC
    FROM MRT_DATA.CONFIGURATIONS
    WHERE CONFIG_VALUE = 'Army Ranks'
      AND PARENT_ID = (SELECT CONFIG_ID
                       FROM MRT_DATA.CONFIGURATIONS
                       WHERE PARENT_ID    = '0'
                         AND CONFIG_VALUE = 'Rank Type');
/*************************************************************************************************************
**  End: Configuration Default Values
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Configuration View
*************************************************************************************************************/
DROP ALIAS IF EXISTS MRT_DATA.VP_CONFIGURATIONS;
CREATE ALIAS MRT_DATA.VP_CONFIGURATIONS AS $$
    import java.sql.Connection;
    import java.sql.ResultSet;
    import java.sql.SQLException;
    import java.sql.Types;
    import org.h2.tools.SimpleResultSet;
    @CODE
    ResultSet getAllConfigurations(final Connection conn) throws SQLException {
        String sqlStatement =
            "WITH v_unit_type(CONFIG_ID,PARENT_ID,TYPE_PATH,CONFIG_VALUE,CONFIG_DESC) AS (\n"         +
            "    SELECT CONFIG_ID,\n"                                                                 +
            "           PARENT_ID,\n"                                                                 +
            "           CONCAT('[',CONCAT(CONFIG_ID,']')),\n"                                         +
            "           CONFIG_VALUE,\n"                                                              +
            "           CONFIG_DESC\n"                                                                +
            "    FROM MRT_DATA.CONFIGURATIONS\n"                                                      +
            "    WHERE PARENT_ID    = '0'\n"                                                          +
            "    UNION ALL\n"                                                                         +
            "    SELECT config.CONFIG_ID,\n"                                                          +
            "           config.PARENT_ID,\n"                                                          +
            "           CONCAT(ut.TYPE_PATH,CONCAT('/',CONCAT('[',CONCAT(config.CONFIG_ID,']')))),\n" +
            "           config.CONFIG_VALUE,\n"                                                       +
            "           config.CONFIG_DESC\n"                                                         +
            "    FROM MRT_DATA.CONFIGURATIONS config\n"                                               +
            "    INNER JOIN v_unit_type ut\n"                                                         +
            "            ON config.PARENT_ID = ut.CONFIG_ID\n"                                        +
            "           AND ut.TYPE_PATH NOT LIKE CONCAT('%[',CONCAT(config.CONFIG_ID,']%'))\n"       +
            ")\n"                                                                                     +
            "SELECT * FROM v_unit_type ORDER BY TYPE_PATH\n";
        ResultSet rs = conn.createStatement().executeQuery(sqlStatement);
        SimpleResultSet srs = new SimpleResultSet();
        srs.addColumn("CONFIG_ID", Types.VARCHAR, 15, 0);
        srs.addColumn("PARENT_ID", Types.VARCHAR, 15, 0);
        srs.addColumn("TYPE_PATH", Types.VARCHAR, 1000, 0);
        srs.addColumn("CONFIG_VALUE", Types.VARCHAR, 25, 0);
        srs.addColumn("CONFIG_DESC", Types.VARCHAR, 1000, 0);
        String url = conn.getMetaData().getURL();
        if(url.equals("jdbc:columnlist:connection")) {
            return srs;
        }
        try {
            while(rs.next()) {
                srs.addRow(rs.getString("CONFIG_ID"),
                           rs.getString("PARENT_ID"),
                           rs.getString("TYPE_PATH"),
                           rs.getString("CONFIG_VALUE"),
                           rs.getString("CONFIG_DESC")
                );
            }
        } finally {
            rs.close();
        }
        return srs;
    }
$$;
/*************************************************************************************************************
**  End: Configuration View
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Configuration List View
*************************************************************************************************************/
DROP ALIAS IF EXISTS MRT_DATA.VP_CONFIG_LIST;
CREATE ALIAS MRT_DATA.VP_CONFIG_LIST AS $$
    import java.sql.Connection;
    import java.sql.ResultSet;
    import java.sql.SQLException;
    import java.sql.Types;
    import org.h2.tools.SimpleResultSet;
    import java.sql.PreparedStatement;
    @CODE
    ResultSet getConfigurationList(final Connection conn, final String config_list) throws SQLException {
        String sqlStatement =
            "WITH v_unit_type(CONFIG_ID,PARENT_ID,TYPE_PATH,CONFIG_VALUE,CONFIG_DESC) AS (\n"         +
            "    SELECT CONFIG_ID,\n"                                                                 +
            "           PARENT_ID,\n"                                                                 +
            "           CONCAT('[',CONCAT(CONFIG_ID,']')),\n"                                         +
            "           CONFIG_VALUE,\n"                                                              +
            "           CONFIG_DESC\n"                                                                +
            "    FROM MRT_DATA.CONFIGURATIONS\n"                                                      +
            "    WHERE CONFIG_VALUE    = ?\n"                                                         +
            "      AND PARENT_ID       = ?\n"                                                         +
            "    UNION ALL\n"                                                                         +
            "    SELECT config.CONFIG_ID,\n"                                                          +
            "           config.PARENT_ID,\n"                                                          +
            "           CONCAT(ut.TYPE_PATH,CONCAT('/',CONCAT('[',CONCAT(config.CONFIG_ID,']')))),\n" +
            "           config.CONFIG_VALUE,\n"                                                       +
            "           config.CONFIG_DESC\n"                                                         +
            "    FROM MRT_DATA.CONFIGURATIONS config\n"                                               +
            "    INNER JOIN v_unit_type ut\n"                                                         +
            "            ON config.PARENT_ID = ut.CONFIG_ID\n"                                        +
            "           AND ut.TYPE_PATH NOT LIKE CONCAT('%[',CONCAT(config.CONFIG_ID,']%'))\n"       +
            ")\n"                                                                                     +
            "SELECT * FROM v_unit_type ORDER BY TYPE_PATH\n";
        PreparedStatement prep = conn.prepareStatement(sqlStatement);
        prep.setString(1,config_list);
        prep.setString(2,"0");
        ResultSet rs = prep.executeQuery();
        SimpleResultSet srs = new SimpleResultSet();
        srs.addColumn("CONFIG_ID", Types.VARCHAR, 15, 0);
        srs.addColumn("PARENT_ID", Types.VARCHAR, 15, 0);
        srs.addColumn("TYPE_PATH", Types.VARCHAR, 1000, 0);
        srs.addColumn("CONFIG_VALUE", Types.VARCHAR, 25, 0);
        srs.addColumn("CONFIG_DESC", Types.VARCHAR, 1000, 0);
        String url = conn.getMetaData().getURL();
        if(url.equals("jdbc:columnlist:connection")) {
            return srs;
        }
        try {
            while(rs.next()) {
                srs.addRow(rs.getString("CONFIG_ID"),
                           rs.getString("PARENT_ID"),
                           rs.getString("TYPE_PATH"),
                           rs.getString("CONFIG_VALUE"),
                           rs.getString("CONFIG_DESC")
                );
            }
        } finally {
            rs.close();
        }
        return srs;
    }
$$;
/*************************************************************************************************************
**  End: Configuration List View
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Configuration Sublist View
*************************************************************************************************************/
DROP ALIAS IF EXISTS MRT_DATA.VP_CONFIG_SUBLIST;
CREATE ALIAS MRT_DATA.VP_CONFIG_SUBLIST AS $$
    import java.sql.Connection;
    import java.sql.ResultSet;
    import java.sql.SQLException;
    import java.sql.Types;
    import org.h2.tools.SimpleResultSet;
    import java.sql.PreparedStatement;
    @CODE
    ResultSet getConfigurationSubList(final Connection conn, final String config_list, final String config_sublist) throws SQLException {
        String sqlStatement =
            "WITH v_unit_type(CONFIG_ID,PARENT_ID,TYPE_PATH,CONFIG_VALUE,CONFIG_DESC) AS (\n"         +
            "    SELECT CONFIG_ID,\n"                                                                 +
            "           PARENT_ID,\n"                                                                 +
            "           CONCAT('[',CONCAT(CONFIG_ID,']')),\n"                                         +
            "           CONFIG_VALUE,\n"                                                              +
            "           CONFIG_DESC\n"                                                                +
            "    FROM MRT_DATA.CONFIGURATIONS\n"                                                      +
            "    WHERE CONFIG_VALUE    = ?\n"                                                         +
            "      AND PARENT_ID       = (SELECT CONFIG_ID\n"                                         +
            "                             FROM MRT_DATA.CONFIGURATIONS\n"                             +
            "                             WHERE PARENT_ID    = ?\n"                                   +
            "                               AND CONFIG_VALUE = ?)\n"                                  +
            "    UNION ALL\n"                                                                         +
            "    SELECT config.CONFIG_ID,\n"                                                          +
            "           config.PARENT_ID,\n"                                                          +
            "           CONCAT(ut.TYPE_PATH,CONCAT('/',CONCAT('[',CONCAT(config.CONFIG_ID,']')))),\n" +
            "           config.CONFIG_VALUE,\n"                                                       +
            "           config.CONFIG_DESC\n"                                                         +
            "    FROM MRT_DATA.CONFIGURATIONS config\n"                                               +
            "    INNER JOIN v_unit_type ut\n"                                                         +
            "            ON config.PARENT_ID = ut.CONFIG_ID\n"                                        +
            "           AND ut.TYPE_PATH NOT LIKE CONCAT('%[',CONCAT(config.CONFIG_ID,']%'))\n"       +
            ")\n"                                                                                     +
            "SELECT * FROM v_unit_type ORDER BY TYPE_PATH\n";
        PreparedStatement prep = conn.prepareStatement(sqlStatement);
        prep.setString(1,config_sublist);
        prep.setString(2,"0");
        prep.setString(3,config_list);
        ResultSet rs = prep.executeQuery();
        SimpleResultSet srs = new SimpleResultSet();
        srs.addColumn("CONFIG_ID", Types.VARCHAR, 15, 0);
        srs.addColumn("PARENT_ID", Types.VARCHAR, 15, 0);
        srs.addColumn("TYPE_PATH", Types.VARCHAR, 1000, 0);
        srs.addColumn("CONFIG_VALUE", Types.VARCHAR, 25, 0);
        srs.addColumn("CONFIG_DESC", Types.VARCHAR, 1000, 0);
        String url = conn.getMetaData().getURL();
        if(url.equals("jdbc:columnlist:connection")) {
            return srs;
        }
        try {
            while(rs.next()) {
                srs.addRow(rs.getString("CONFIG_ID"),
                           rs.getString("PARENT_ID"),
                           rs.getString("TYPE_PATH"),
                           rs.getString("CONFIG_VALUE"),
                           rs.getString("CONFIG_DESC")
                );
            }
        } finally {
            rs.close();
        }
        return srs;
    }
$$;
/*************************************************************************************************************
**  End: Configuration Sublist View
*************************************************************************************************************/

/*************************************************************************************************************
**  Block: Unit Type View
*************************************************************************************************************/
DROP ALIAS IF EXISTS MRT_DATA.VP_ALL_UNIT_TYPES;
CREATE ALIAS MRT_DATA.VP_ALL_UNIT_TYPES AS $$
    import java.sql.Connection;
    import java.sql.ResultSet;
    import java.sql.SQLException;
    import java.sql.Types;
    import org.h2.tools.SimpleResultSet;
    @CODE
    ResultSet getAllUnitTypes(final Connection conn) throws SQLException {
        String sqlStatement =
            "WITH v_unit_type(CONFIG_ID,PARENT_ID,TYPE_PATH,CONFIG_VALUE,CONFIG_DESC) AS (\n"         +
            "    SELECT CONFIG_ID,\n"                                                                 +
            "           PARENT_ID,\n"                                                                 +
            "           CONCAT('[',CONCAT(CONFIG_ID,']')),\n"                                         +
            "           CONFIG_VALUE,\n"                                                              +
            "           CONFIG_DESC\n"                                                                +
            "    FROM MRT_DATA.CONFIGURATIONS\n"                                                      +
            "    WHERE PARENT_ID    = '0'\n"                                                          +
            "      AND CONFIG_VALUE = 'Unit Type'\n"                                                  +
            "    UNION ALL\n"                                                                         +
            "    SELECT config.CONFIG_ID,\n"                                                          +
            "           config.PARENT_ID,\n"                                                          +
            "           CONCAT(ut.TYPE_PATH,CONCAT('/',CONCAT('[',CONCAT(config.CONFIG_ID,']')))),\n" +
            "           config.CONFIG_VALUE,\n"                                                       +
            "           config.CONFIG_DESC\n"                                                         +
            "    FROM MRT_DATA.CONFIGURATIONS config\n"                                               +
            "    INNER JOIN v_unit_type ut\n"                                                         +
            "            ON config.PARENT_ID = ut.CONFIG_ID\n"                                        +
            "           AND ut.TYPE_PATH NOT LIKE CONCAT('%[',CONCAT(config.CONFIG_ID,']%'))\n"       +
            ")\n"                                                                                     +
            "SELECT * FROM v_unit_type ORDER BY TYPE_PATH\n";
        ResultSet rs = conn.createStatement().executeQuery(sqlStatement);
        SimpleResultSet srs = new SimpleResultSet();
        srs.addColumn("CONFIG_ID", Types.VARCHAR, 15, 0);
        srs.addColumn("PARENT_ID", Types.VARCHAR, 15, 0);
        srs.addColumn("TYPE_PATH", Types.VARCHAR, 1000, 0);
        srs.addColumn("CONFIG_VALUE", Types.VARCHAR, 25, 0);
        srs.addColumn("CONFIG_DESC", Types.VARCHAR, 1000, 0);
        String url = conn.getMetaData().getURL();
        if(url.equals("jdbc:columnlist:connection")) {
            return srs;
        }
        try {
            while(rs.next()) {
                srs.addRow(rs.getString("CONFIG_ID"),
                           rs.getString("PARENT_ID"),
                           rs.getString("TYPE_PATH"),
                           rs.getString("CONFIG_VALUE"),
                           rs.getString("CONFIG_DESC")
                );
            }
        } finally {
            rs.close();
        }
        return srs;
    }
$$;

/* Alternate version */
CREATE ALIAS IF NOT EXISTS MRT_DATA.VP_ALL_UNIT_TYPES FOR "net.strangetec.db.Function.getAllUnitTypes";

/* To run query, run [SELECT * FROM MRT_DATA.VP_ALL_UNIT_TYPES();] */
/*************************************************************************************************************
**  End: Unit Type View
*************************************************************************************************************/
