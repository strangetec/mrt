/**
 * MrtPlugin is the template interface for the plugin classes.
 * @author Elfin
 * @since 2018-10-07
 */

import java.util.ArrayList;
import java.util.HashMap;

public interface MrtPlugin {
    /**
     * Retrieve the name of the plugin.
     * @return Plugin name
     */
    public String getPluginName();
    
    /**
     * Retrieve the names of methods with their parameter types.
     * @return HashMap of method names, and their parameter types.
     */
    public HashMap<String,ArrayList<String>> getMethods();
    
    /**
     * Returns the roles which have permission to use plugin.
     * @return ArrayList of roles with permissions
     */
    public ArrayList<String> getPermissions();
    
    /**
     * Gives the menu structure for the plugin.
     * <p>
     * <h2>Format is</h2>
     * <ul>
     *     <li>menu[0] is the top menu (i.e. Reports)</li>
     *     <li>menu[1] is the next menu selection</li>
     *     <li>menu[2] is the next menu select ... etc</li>
     *     <li>Returns <b>null</b> if plugin does not have a menu.
     * </ul>
     * @return Array with menu selections.
     */
    public String[] getMenu();
    
    /**
     * If the plugin has an error, this method will return the message.
     * <p>
     * If no error has occurred, return null.
     * @return Error message or null.
     */
    public String getError();
    
    /**
     * Clear the plugin's error message.
     */
    public void clearError();
}