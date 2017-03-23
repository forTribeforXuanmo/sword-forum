package com.sword.service.impl;

import org.springframework.stereotype.Service;

import com.sword.mapper.UserMapper;
import com.sword.model.User;
import com.sword.service.IUserService;
import com.baomidou.framework.service.impl.SuperServiceImpl;

/**
 *
 * User 表数据服务层接口实现类
 *
 */
@Service
public class UserServiceImpl extends SuperServiceImpl<UserMapper, User> implements IUserService {


}