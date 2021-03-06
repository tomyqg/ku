package com.kuyun.cms.web.controller;

import com.kuyun.cms.common.constant.CmsResult;
import com.kuyun.cms.common.constant.CmsResultConstant;
import com.kuyun.cms.dao.model.CmsComment;
import com.kuyun.cms.rpc.api.CmsCommentService;
import com.kuyun.common.base.BaseController;
import com.kuyun.common.util.RequestUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * 评论控制器
 * Created by kuyun on 2017/3/26.
 */
@Controller
@RequestMapping(value = "/comment")
public class CommentController extends BaseController {

    private static Logger _log = LoggerFactory.getLogger(CommentController.class);

    @Autowired
    private CmsCommentService cmsCommentService;

    @RequiresPermissions("cms:comment:create")
    @RequestMapping(value = "/create/{articleId}", method = RequestMethod.POST)
    @ResponseBody
    public Object create(@PathVariable("articleId") int articleId, CmsComment cmsComment, HttpServletRequest request) {
        long time = System.currentTimeMillis();
        cmsComment.setCtime(time);
        cmsComment.setArticleId(articleId);
        cmsComment.setUserId(1);
        cmsComment.setStatus((byte) 1);
        cmsComment.setIp(RequestUtil.getIpAddr(request));
        cmsComment.setAgent(request.getHeader("User-Agent"));
        int count = cmsCommentService.insertSelective(cmsComment);
        return new CmsResult(CmsResultConstant.SUCCESS, count);
    }

}