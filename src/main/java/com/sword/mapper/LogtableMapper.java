package com.sword.mapper;

import com.sword.model.Logtable;
import com.baomidou.mybatisplus.mapper.AutoMapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;

/**
 *
 * Logtable 表数据库控制层接口
 *
 */
public interface LogtableMapper extends AutoMapper<Logtable> {
    /** 查询当前用户今日已经登陆过几次 **/
    int todayLoginCount(@Param("uid")long uid, @Param("date")Date date);

    /** 查询今日发布了多少条文章 **/
    int todayTopicCount(@Param("uid")long uid,@Param("date")Date date);

}