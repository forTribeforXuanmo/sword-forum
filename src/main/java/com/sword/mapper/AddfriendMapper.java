package com.sword.mapper;

import com.sword.model.Addfriend;
import com.baomidou.mybatisplus.mapper.AutoMapper;
import org.apache.ibatis.annotations.Param;

/**
 *
 * Addfriend 表数据库控制层接口
 *
 */
public interface AddfriendMapper extends AutoMapper<Addfriend> {
    /**对我加别人的信息反馈进行确认 就是更新，表示完成下次不再查询**/
    int finishAddFriend(@Param("fromuid") long fromuid, @Param("touid") long touid);
    /**接受添加好友请求**/
    int acceptAddFriend(@Param("fromuid")long fromuid,@Param("touid")long touid);
    /**拒绝添加好友请求**/
    int rejectAddFriend(@Param("fromui")long fromuid,@Param("touid")long touid);

}