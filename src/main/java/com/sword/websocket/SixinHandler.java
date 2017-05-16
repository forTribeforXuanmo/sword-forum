package com.sword.websocket;

import com.alibaba.fastjson.JSON;
import com.sword.control.MessageControl;
import com.sword.mapper.FriendMapper;
import com.sword.mapper.SixinMapper;
import com.sword.mapper.UserMapper;
import com.sword.model.Sixin;
import com.sword.model.VO.GroupByIdVo;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.*;

import static com.sword.websocket.SystemWebSocketHandler.users;

/**
 * author: lishengzhu
 * eamil:530735771@qq.com
 * date:2017/5/15
 * time:11:09
 */
@Component
public class SixinHandler implements WebSocketHandler {
    @Resource
    private SixinMapper sixinMapper;
    @Resource
    private UserMapper userMapper;
    @Resource
    private FriendMapper friendMapper;
    @Resource
    private SystemWebSocketHandler webSocketHandler;
    //保存记录谁正在和谁对话
    public static final Map<Long,Long> who_To_who=new HashMap<Long,Long>();
    //记录当前页面的长连接对象，为了和index.jsp分开,因为js的new Socket只能连接一个到一个地方
    public static final Map<Long, WebSocketSession> chatusers = new HashMap<Long, WebSocketSession>();
    @Override
    public void afterConnectionEstablished(WebSocketSession webSocketSession) throws Exception {
        //查询有多少未读记录 数字显示在在线列表好友后面
        Long uid = (Long) webSocketSession.getAttributes().get("socketuid");
        if (chatusers.get(uid) == null) {
            chatusers.put(uid,webSocketSession);
            who_To_who.put(uid,0L);   //表示打开这个页面
            List<GroupByIdVo> list=unReadSixinCount(uid);
            Map map=new HashMap(1);
            map.put("unreadsixinlist",list);
            webSocketSession.sendMessage(new TextMessage(JSON.toJSONString(map)));
        }
    }

    @Override
    public void handleMessage(WebSocketSession webSocketSession, WebSocketMessage<?> webSocketMessage) throws Exception {
        if (webSocketMessage.getPayloadLength() == 0) return;
        Sixin sixin = JSON.parseObject(webSocketMessage.getPayload().toString(), Sixin.class);
        sixin.setTime(new Date());
        Long uid = (Long) webSocketSession.getAttributes().get("socketuid");
        Long hisuid=sixin.getSitouid();
        sixin.setSifromuid(uid);
        if(!MessageControl.isFriend(hisuid,uid,friendMapper)){
            return;
        }
        if(hisuid==-1){
            return;
        }
        if(who_To_who.get(hisuid)==null){
            //如果没有打开这个聊天页面则为未读，并且推给对方首页提示未读私信数量
            sixin.setIsread(0);
            sixinMapper.insert(sixin);
            Map map=webSocketHandler.unReadMsgCount(hisuid);
            webSocketHandler.sendMessageToUser(hisuid,new TextMessage(JSON.toJSONString(map)));

        }else if(who_To_who.get(hisuid)==0L||who_To_who.get(hisuid)!=uid){
                //对方打开了这个页面或者不是和我在聊天，这个时候不应该推送到Index.jsp而是更新用户列表的未读数量
                sixin.setIsread(0);
                sixinMapper.insert(sixin);
                Sixin sixinWhere=new Sixin();
                sixinWhere.setSifromuid(uid);
                sixinWhere.setSitouid(hisuid);
                sixinWhere.setIsread(0);
                int count=sixinMapper.selectCount(sixinWhere);
                GroupByIdVo groupByIdVo=new GroupByIdVo();
                groupByIdVo.setUid(uid);
                groupByIdVo.setCount(count);
                Map map=new HashMap(1);
                map.put("someonecount",groupByIdVo);
                sendMessageToUser(hisuid,new TextMessage(JSON.toJSONString(map)));
        }else if(who_To_who.get(hisuid)==uid){
            //是和我正在聊天
            sixin.setIsread(1);
            sixinMapper.insert(sixin);
            Map<String,String> map=new HashMap(1);
            map.put("message",sixin.getContent());
            sendMessageToUser(hisuid,new TextMessage(JSON.toJSONString(map)));
        }
    }

    @Override
    public void handleTransportError(WebSocketSession webSocketSession, Throwable throwable) throws Exception {
        Long uid = (Long) webSocketSession.getAttributes().get("socketuid");
        if(who_To_who.get(uid)!=null){
            who_To_who.remove(uid);
        }
        if(chatusers.get(uid)!=null){
            chatusers.remove(uid);
        }
        if (webSocketSession.isOpen()) {
            webSocketSession.close();
        }

    }

    @Override
    public void afterConnectionClosed(WebSocketSession webSocketSession, CloseStatus closeStatus) throws Exception {
        Long uid = (Long) webSocketSession.getAttributes().get("socketuid");
        if(who_To_who.get(uid)!=null){
            who_To_who.remove(uid);
        }
        if(chatusers.get(uid)!=null){
            chatusers.remove(uid);
        }
        if (webSocketSession.isOpen()) {
            webSocketSession.close();
        }
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 给某个用户发送消息
     *
     * @param uid
     * @param message
     */
    public void sendMessageToUser(long uid, TextMessage message) throws IOException {
        WebSocketSession session = chatusers.get(uid);
        if (session != null && session.isOpen()) {
            session.sendMessage(message);
        }
    }

    /**
     * 给所有在线用户发送消息
     *
     * @param message
     */
    public void sendMessageToUsers(TextMessage message) {

    }
    /**
     * 查询未读私信数目集合 一对一
     * @param uid
     * @return
     */
    public List<GroupByIdVo> unReadSixinCount(long uid){
        List<GroupByIdVo> countList=sixinMapper.unReadSixinCount(uid);
        return countList;
    }

}
