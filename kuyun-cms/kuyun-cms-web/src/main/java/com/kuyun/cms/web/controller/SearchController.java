package com.kuyun.cms.web.controller;

import com.kuyun.cms.dao.model.CmsArticle;
import com.kuyun.cms.dao.model.CmsArticleExample;
import com.kuyun.cms.dao.model.CmsTag;
import com.kuyun.cms.dao.model.CmsTagExample;
import com.kuyun.cms.rpc.api.CmsArticleService;
import com.kuyun.cms.rpc.api.CmsTagService;
import com.kuyun.common.base.BaseController;
import com.kuyun.common.util.Paginator;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 搜索控制器
 * Created by kuyun on 2017/3/26.
 */
@Controller
@RequestMapping(value = "/search")
public class SearchController extends BaseController {

	private static Logger _log = LoggerFactory.getLogger(SearchController.class);

	@Autowired
	private CmsArticleService cmsArticleService;

	@RequestMapping(value = "/{keyword}", method = RequestMethod.GET)
	public String index(@PathVariable("keyword") String keyword,
						@RequestParam(required = false, defaultValue = "1", value = "page") int page,
						@RequestParam(required = false, defaultValue = "orders", value = "sort") String sort,
						@RequestParam(required = false, defaultValue = "desc", value = "order") String order,
						HttpServletRequest request,
						Model model) {
		// 该关键字文章列表
		int rows = 10;
		CmsArticleExample cmsArticleExample = new CmsArticleExample();
		cmsArticleExample.createCriteria()
				.andStatusEqualTo((byte) 1)
				.andTitleLike(keyword);
		cmsArticleExample.setOffset((page - 1) * rows);
		cmsArticleExample.setLimit(rows);
		if (!StringUtils.isBlank(sort) && !StringUtils.isBlank(order)) {
			cmsArticleExample.setOrderByClause(sort + " " + order);
		}
		List<CmsArticle> articles = cmsArticleService.selectByExample(cmsArticleExample);
		model.addAttribute("articles", articles);
		// 文章总数
		long total = cmsArticleService.countByExample(cmsArticleExample);
		// 分页
		Paginator paginator = new Paginator(total, page, rows, request);
		model.addAttribute("paginator", paginator);
		return thymeleaf("/search/index");
	}

}