package com.kuyun.demo.rpc.api;

/**
 * 降级实现DemoService接口
 * Created by kuyun on 2017/4/1.
 */
public class DemoServiceMock implements DemoService {

    @Override
    public String sayHello(String name) {
        return null;
    }

}
