package com.sword.websocket;


import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.sword.mapper.AddfriendMapper;
import com.sword.mapper.CommentMapper;
import com.sword.mapper.SixinMapper;
import com.sword.model.Addfriend;
import com.sword.model.Sixin;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.*;


/**
 * Created by asus on 2017/3/21.
 */
@Component
public class SystemWebSocketHandler implements WebSocketHandler {
    public static final Map<Long, WebSocketSession> users = new HashMap<Long, WebSocketSession>();

    @Resource
    private CommentMapper commentMapper;
    @Resource
    private SixinMapper sixinMapper;
    @Resource
    private AddfriendMapper addfriendMapper;
    public void afterConnectionEstablished(WebSocketSession webSocketSession) throws Exception {
        Long uid = (Long) webSocketSession.getAttributes().get("socketuid");
        if (users.get(uid) == null) {
            users.put(uid, webSocketSession);
            Map<String,Integer> countMap=unReadMsgCount(uid);
            webSocketSession.sendMessage(new TextMessage(JSON.toJSONString(countMap)));
        }
    }

    /**
     * 在客户端通过Websocket API发送的消息会经过这里
     **/
    public void handleMessage(WebSocketSession webSocketSession, WebSocketMessage<?> webSocketMessage) throws Exception {

    }

    public void handleTransportError(WebSocketSession webSocketSession, Throwable throwable) throws Exception {
        if (webSocketSession.isOpen()) {
            webSocketSession.close();
        }
        Iterator<Map.Entry<Long, WebSocketSession>> it = users.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<Long, WebSocketSession> entry = it.next();
            if (entry.getValue().getId().equals(webSocketSession.getId())) {
                users.remove(entry.getKey());
                System.out.println("消息传输错误socket回话移除用户Id" + entry.getKey());
                break;
            }
        }
    }

    public void afterConnectionClosed(WebSocketSession webSocketSession, CloseStatus closeStatus) throws Exception {
        if (webSocketSession.isOpen()) {
            webSocketSession.close();
        }
        Iterator<Map.Entry<Long, WebSocketSession>> it = users.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<Long, WebSocketSession> entry = it.next();
            if (entry.getValue().getId().equals(webSocketSession.getId())) {
                users.remove(entry.getKey());
                System.out.println("关闭连接后socket回话移除用户Id" + entry.getKey());
                break;
            }
        }
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

    }

    /**
     * 给某个用户发送消息
     *
     * @param uid
     * @param message
     */
    public void sendMessageToUser(long uid, TextMessage message) throws IOException {
        WebSocketSession session = users.get(uid);
        if (session != null && session.isOpen()) {
            session.sendMessage(message);
        }
    }
    /**查询 uid的未读消息数量**/
    public Map<String, Integer> unReadMsgCount(long uid){
        Map<String,Integer>countMap=new HashMap<>();
        int commentcount = commentMapper.unreadCount(uid);
        Sixin sixinWhere=new Sixin();
        sixinWhere.setIsread(0);
        sixinWhere.setSitouid(uid);
        int sixincount=sixinMapper.selectCount(sixinWhere);
        //我加他人
        EntityWrapper<Addfriend> ew1=new EntityWrapper<>();
        ew1.where("fromuid="+uid).and("staus!={0}","'等待'").and("flag=1");
        int i=addfriendMapper.selectCountByEw(ew1);
        //他人加我
        EntityWrapper<Addfriend> ew2=new EntityWrapper<>();
        ew2.where("touid="+uid).and("staus={0}","'等待'");
        int j=addfriendMapper.selectCountByEw(ew2);
        int advisecount=i+j;
        int allcount=commentcount+sixincount+advisecount;

        countMap.put("allcount",allcount);
        countMap.put("commentcount",commentcount);
        countMap.put("sixincount",sixincount);
        countMap.put("advisecount",advisecount);
        return countMap;

    }


}

