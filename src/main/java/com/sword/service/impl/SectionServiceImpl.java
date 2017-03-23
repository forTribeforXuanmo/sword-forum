package com.sword.service.impl;

import org.springframework.stereotype.Service;

import com.sword.mapper.SectionMapper;
import com.sword.model.Section;
import com.sword.service.ISectionService;
import com.baomidou.framework.service.impl.SuperServiceImpl;

/**
 *
 * Section 表数据服务层接口实现类
 *
 */
@Service
public class SectionServiceImpl extends SuperServiceImpl<SectionMapper, Section> implements ISectionService {


}