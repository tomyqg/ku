package com.kuyun.common.interceptor;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 允许跨域请求
 */
public class CrossDomainInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization, Cache-Control, X-Requested-With");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT");
        //return super.preHandle(request, response, handler);
        return !request.getMethod().equals("OPTIONS");
    }
}
