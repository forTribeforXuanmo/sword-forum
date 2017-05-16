package com.sword.websocket;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

/**
 * Created by asus on 2017/3/21.
 */
@Configuration
@EnableWebMvc
@EnableWebSocket
public class WebSocketConfig extends WebMvcConfigurerAdapter implements WebSocketConfigurer {

    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
       registry.addHandler(systemWebSocketHandler(),"/msgCountSocket").addInterceptors(new WebSocketHandshakeInterceptor());
       registry.addHandler(systemWebSocketHandler(),"/sockjs/msgCountSocket").addInterceptors(
               new WebSocketHandshakeInterceptor()).withSockJS();
       registry.addHandler(sixinHandler(),"/chatouser").addInterceptors(new WebSocketHandshakeInterceptor());
       registry.addHandler(sixinHandler(),"/sockjs/chattouser").
               addInterceptors(new WebSocketHandshakeInterceptor()).withSockJS();
    }
    @Bean
    public WebSocketHandler systemWebSocketHandler(){
        return  new SystemWebSocketHandler();
    }
    @Bean
    public SixinHandler sixinHandler(){return  new SixinHandler();}
}