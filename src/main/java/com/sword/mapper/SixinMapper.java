package com.sword.mapper;

import com.sword.model.Sixin;
import com.baomidou.mybatisplus.mapper.AutoMapper;
import com.sword.model.VO.GroupByIdVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *
 * Sixin 表数据库控制层接口
 *
 */
public interface SixinMapper extends AutoMapper<Sixin> {
    List<GroupByIdVo> unReadSixinCount(long uid);
    //查询与某人聊天记录前n条
    List<Sixin>     selectLimitSixin(@Param("hisuid")long hisuid,@Param("meuid")long meuid,@Param("n")int n);
    int updateHaveRead(@Param("hisuid")long hisuid,@Param("meuid")long meuid);
}