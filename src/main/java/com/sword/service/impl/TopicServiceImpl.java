package com.sword.service.impl;

import org.springframework.stereotype.Service;

import com.sword.mapper.TopicMapper;
import com.sword.model.Topic;
import com.sword.service.ITopicService;
import com.baomidou.framework.service.impl.SuperServiceImpl;

/**
 *
 * Topic 表数据服务层接口实现类
 *
 */
@Service
public class TopicServiceImpl extends SuperServiceImpl<TopicMapper, Topic> implements ITopicService {


}