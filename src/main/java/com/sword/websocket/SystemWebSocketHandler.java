package com.sword.websocket;



import com.sword.mapper.CommentMapper;
import com.sword.model.Comment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.*;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;


/**
 * Created by asus on 2017/3/21.
 */
public class SystemWebSocketHandler implements WebSocketHandler {
    private static  ArrayList<WebSocketSession> users = null;

    public static ArrayList<WebSocketSession> getUsers() {
        return users;
    }

    static {
        users=new ArrayList<WebSocketSession>();
    }
    @Resource
    private CommentMapper commentMapper;
    public void afterConnectionEstablished(WebSocketSession webSocketSession) throws Exception {

        users.add(webSocketSession);
        long uid=(Long)webSocketSession.getAttributes().get("socketuid");
        if(uid!=0){
            int count=commentMapper.unreadCount(uid);
            webSocketSession.sendMessage(new TextMessage(count+""));
        }
    }

    public void handleMessage(WebSocketSession webSocketSession, WebSocketMessage<?> webSocketMessage) throws Exception {
        //sendMessageToUser()
    }

    public void handleTransportError(WebSocketSession webSocketSession, Throwable throwable) throws Exception {
        if(webSocketSession.isOpen()){
            webSocketSession.close();
        }
        users.remove(webSocketSession);
    }

    public void afterConnectionClosed(WebSocketSession webSocketSession, CloseStatus closeStatus) throws Exception {
    }

    public boolean supportsPartialMessages() {
        return false;
    }
    /**
     * 给所有在线用户发送消息
     *
     * @param message
     */
    public void sendMessageToUsers(TextMessage message) {
        for (WebSocketSession user : users) {
                if (user.isOpen()) {
                        try {
                        user.sendMessage(message);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    /**
     * 给某个用户发送消息
     *
     * @param uid
     * @param message
     */
    public void sendMessageToUser(long uid, TextMessage message) {
        for (WebSocketSession user : users) {
            if ((Long)user.getAttributes().get("socketuid")==uid) {
                try {
                    if (user.isOpen()) {
                        user.sendMessage(message);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
                break;
            }
        }
    }


    }

