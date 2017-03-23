package com.sword.service.impl;

import org.springframework.stereotype.Service;

import com.sword.mapper.ManageMapper;
import com.sword.model.Manage;
import com.sword.service.IManageService;
import com.baomidou.framework.service.impl.SuperServiceImpl;

/**
 *
 * Manage 表数据服务层接口实现类
 *
 */
@Service
public class ManageServiceImpl extends SuperServiceImpl<ManageMapper, Manage> implements IManageService {


}