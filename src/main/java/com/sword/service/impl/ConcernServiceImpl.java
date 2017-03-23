package com.sword.service.impl;

import org.springframework.stereotype.Service;

import com.sword.mapper.ConcernMapper;
import com.sword.model.Concern;
import com.sword.service.IConcernService;
import com.baomidou.framework.service.impl.SuperServiceImpl;

/**
 *
 * Concern 表数据服务层接口实现类
 *
 */
@Service
public class ConcernServiceImpl extends SuperServiceImpl<ConcernMapper, Concern> implements IConcernService {


}