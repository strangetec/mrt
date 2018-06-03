/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.strangetec.db;

import java.math.BigInteger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import org.h2.tools.SimpleResultSet;
/**
 *
 * @author Elfin
 */
public class Function {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
    }
    
    /**
     * 
     * @param newID Value of unique identifier within 
     * @return New identifier with database identifier
     */
    public static String newPrimaryKey(long newID) {
        return new StringBuffer("JFHQ").append(newID).toString();
    }
    
    public static ResultSet getAllUnitTypes(java.sql.Connection conn) throws SQLException {
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

    /**
     * 
     * @param conn Connection object to database
     * @return A result set of all configurations in hierarchal view
     * @throws SQLException 
     */
    public static ResultSet getAllConfigurations(java.sql.Connection conn) throws SQLException {
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
    
        public static ResultSet getConfigurationList(java.sql.Connection conn, String config_list) throws SQLException {
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
        public static ResultSet getConfigurationSubList(java.sql.Connection conn, String config_list, String config_sublist) throws SQLException {
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
}
