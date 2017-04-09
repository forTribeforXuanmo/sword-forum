import java.util.ResourceBundle;

/**
 * Created by Administrator on 2016/11/28.
 */
public class mailTest {
    public static final int END = Integer.MAX_VALUE;
    public static final int START = END - 2;
    public static void main(String[] args) {
        int count = 0;
        for (int i = START; i <= END; i++)
        {count++;
            System.out.println(count);}
    }
}
