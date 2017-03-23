package com.sword.service.impl;

import org.springframework.stereotype.Service;

import com.sword.mapper.CommentMapper;
import com.sword.model.Comment;
import com.sword.service.ICommentService;
import com.baomidou.framework.service.impl.SuperServiceImpl;

/**
 *
 * Comment 表数据服务层接口实现类
 *
 */
@Service
public class CommentServiceImpl extends SuperServiceImpl<CommentMapper, Comment> implements ICommentService {


}