package com.sword.websocket;

import com.sword.model.User;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * Created by asus on 2017/3/21.
 */
public class WebSocketHandshakeInterceptor implements HandshakeInterceptor {
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler webSocketHandler, Map<String, Object> map) throws Exception {
        if(request instanceof ServletServerHttpRequest){
            ServletServerHttpRequest serverRequest= (ServletServerHttpRequest) request;
            HttpSession session=serverRequest.getServletRequest().getSession(false);
            if(session!=null){
                User user=(User)session.getAttribute("user");
                if(user!=null)
                map.put("socketuid",user.getUid());
            }
        }
        return true;
    }

    public void afterHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Exception e) {

    }
}
