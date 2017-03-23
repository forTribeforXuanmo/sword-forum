import java.util.ResourceBundle;

/**
 * Created by Administrator on 2016/11/28.
 */
public class mailTest {
    public static void main(String[] args) {
        ResourceBundle resourceBundle=ResourceBundle.getBundle("mail");
        System.out.println(resourceBundle.getString("from"));
    }
}
