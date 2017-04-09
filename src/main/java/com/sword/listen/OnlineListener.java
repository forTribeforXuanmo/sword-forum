package com.sword.listen;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Created by asus on 2017/3/22.
 * 项目启动容器会自己生成session,这里有三个一开始就生成.
 */
public class OnlineListener implements HttpSessionListener {
    private static long countNumber=0;

    public static long getCountNumber() {
        return countNumber;
    }

    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
                countNumber++;
    }
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
                countNumber--;

    }

}
