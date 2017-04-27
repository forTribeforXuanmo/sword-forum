package com.sword.mapper;

import com.sword.model.Manage;
import com.baomidou.mybatisplus.mapper.AutoMapper;
import com.sword.model.VO.ChartVo;

import java.util.List;

/**
 *
 * Manage 表数据库控制层接口
 *
 */
public interface ManageMapper extends AutoMapper<Manage> {
    //获取帖子数量
    List<ChartVo> getTopicChartByWeek(String year);
    List<ChartVo> getTopicChartByMonth(String year);
    //获取评论数量
    List<ChartVo> getCommentChartByWeek(String year);
    List<ChartVo> getCommentChartByMonth(String year);
    //用户注册量
    List<ChartVo> getRegisterChartByWeek(String year);
    List<ChartVo> getRegisterChartByMonth(String year);
}