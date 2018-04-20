/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.strangetec.db;

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
}
