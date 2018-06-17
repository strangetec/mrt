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
