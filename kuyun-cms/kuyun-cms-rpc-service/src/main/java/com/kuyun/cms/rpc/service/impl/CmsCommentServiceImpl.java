package com.kuyun.cms.rpc.service.impl;

import com.kuyun.common.annotation.BaseService;
import com.kuyun.common.base.BaseServiceImpl;
import com.kuyun.cms.dao.mapper.CmsCommentMapper;
import com.kuyun.cms.dao.model.CmsComment;
import com.kuyun.cms.dao.model.CmsCommentExample;
import com.kuyun.cms.rpc.api.CmsCommentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
* CmsCommentService实现
* Created by kuyun on 2017/4/5.
*/
@Service
@Transactional
@BaseService
public class CmsCommentServiceImpl extends BaseServiceImpl<CmsCommentMapper, CmsComment, CmsCommentExample> implements CmsCommentService {

    private static Logger _log = LoggerFactory.getLogger(CmsCommentServiceImpl.class);

    @Autowired
    CmsCommentMapper cmsCommentMapper;

}