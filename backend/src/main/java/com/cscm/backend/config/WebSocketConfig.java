package com.cscm.backend.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.HandlerMapping;
import org.springframework.web.reactive.handler.SimpleUrlHandlerMapping;
import org.springframework.web.reactive.socket.WebSocketHandler;
import org.springframework.web.reactive.socket.server.support.WebSocketHandlerAdapter;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class WebSocketConfig {

    @Bean
    HandlerMapping webSocketHandlerMapping(Map<String, WebSocketHandler> wsHandlers) {
        Map<String, WebSocketHandler> urlMap = new HashMap<>();

        wsHandlers.forEach((beanName, handler) -> {
            // Convention: bean named "consultationWsHandler" → /ws/consultation
            String path = "/ws/" + beanName
                    .replace("WsHandler", "")
                    .replace("WebSocketHandler", "")
                    .replaceAll("([A-Z])", "-$1")
                    .toLowerCase()
                    .replaceAll("^-", "");
            urlMap.put(path, handler);
        });

        SimpleUrlHandlerMapping mapping = new SimpleUrlHandlerMapping();
        mapping.setUrlMap(urlMap);
        mapping.setOrder(-1);
        return mapping;
    }

    @Bean
    WebSocketHandlerAdapter handlerAdapter() {
        return new WebSocketHandlerAdapter();
    }
}
