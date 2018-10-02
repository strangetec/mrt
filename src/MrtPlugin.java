import java.util.HashMap;
import java.util.ArrayList;

public interface MrtPlugin {
    public String getPluginName();
    public HashMap<String,ArrayList<String>> getMethods();
    public ArrayList<String> getPermissions();
}