package com.kuyun.api.rpc.service.impl;

import com.kuyun.api.rpc.api.ApiService;
import com.kuyun.cms.rpc.api.*;
import com.kuyun.upms.rpc.api.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 实现ApiService接口
 * Created by kuyun on 2017/2/19.
 */
public class ApiServiceImpl implements ApiService {

    private static Logger _log = LoggerFactory.getLogger(ApiServiceImpl.class);

    @Autowired
    private UpmsSystemService upmsSystemService;

    @Autowired
    private UpmsOrganizationService upmsOrganizationService;

    @Autowired
    private UpmsUserService upmsUserService;

    @Autowired
    private UpmsRoleService upmsRoleService;

    @Autowired
    private UpmsPermissionService upmsPermissionService;

    @Autowired
    private UpmsApiService upmsApiService;

    @Autowired
    private CmsArticleService cmsArticleService;

    @Autowired
    private CmsCategoryService cmsCategoryService;

    @Autowired
    private CmsCommentService cmsCommentService;

    @Autowired
    private CmsTagService cmsTagService;

    @Override
    public String hello(String name) {
        return "hello," + name + "!";
    }

}
