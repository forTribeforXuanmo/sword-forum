package com.sword.mapper;

import com.baomidou.mybatisplus.plugins.Page;
import com.sword.model.Concern;
import com.baomidou.mybatisplus.mapper.AutoMapper;
import com.sword.model.Topic;
import com.sword.model.VO.ConVo;
import com.sword.model.VO.TopicCatalogVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 *
 * Concern 表数据库控制层接口
 *
 */
public interface ConcernMapper extends AutoMapper<Concern> {
 List<ConVo> iConcernSearch(Page page, @Param("meuid")long meuid,@Param("search")String search);
 List<ConVo> iConcern(Page page,long fromuid);
 List<Topic> concernTopic(long fromuid);
 List<ConVo> concernISearch(Page page,@Param("meuid")long meuid,@Param("search")String search);
}