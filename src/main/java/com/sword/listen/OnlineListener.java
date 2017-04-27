package com.sword.listen;
import com.sword.mapper.LogtableMapper;
import com.sword.model.Logtable;
import com.sword.model.User;
import com.sword.util.IpUtil;
import javafx.application.Application;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Created by asus on 2017/3/22.
 * 项目启动容器会自己生成session,这里有三个一开始就生成.估计是个环境框架等有关
 */
public class OnlineListener implements HttpSessionListener {
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {

    }
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        HttpSession session=httpSessionEvent.getSession();
        if(session.getAttribute("user")!=null){
            Online.delete();
            System.out.println("==SESSION 失效 ：user在线退出减一===");
        }
        System.out.println("session销毁==减1==");
    }

}
