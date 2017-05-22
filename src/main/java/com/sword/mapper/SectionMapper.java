package com.sword.mapper;

import com.sword.model.Section;
import com.baomidou.mybatisplus.mapper.AutoMapper;

import java.util.List;

/**
 *
 * Section 表数据库控制层接口
 *
 */
public interface SectionMapper extends AutoMapper<Section> {
     List<Section> selectAll();
     List<String> getParentName();
}