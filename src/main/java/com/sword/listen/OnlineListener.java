package com.sword.listen;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Created by asus on 2017/3/22.
 */
public class OnlineListener implements HttpSessionListener {
    private static long countNumber=0;

    public static long getCountNumber() {
        return countNumber;
    }

    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
                countNumber++;
        System.out.println("来了一个。。。。"+countNumber);
    }
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
                countNumber--;
        System.out.println("退出一个.。。。。"+countNumber);
    }

}
