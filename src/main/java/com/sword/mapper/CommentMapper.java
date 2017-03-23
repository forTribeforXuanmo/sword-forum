package com.sword.mapper;

import com.baomidou.mybatisplus.plugins.Page;
import com.sword.model.Comment;
import com.baomidou.mybatisplus.mapper.AutoMapper;
import com.sword.model.VO.UnreadComm;

import java.util.List;
import java.util.Map;

/**
 *
 * Comment 表数据库控制层接口
 *
 */
public interface CommentMapper extends AutoMapper<Comment> {
    /*****查询根评论下的非直接评论*******/
    List<Comment> selectNdirect(Map<String,Object> map);
    /**未读评论数量**/
    int unreadCount(long uid);
    /**未读评论**/
    List<UnreadComm> unreadComment(Page page, long uid);
    /**更新未读为已读**/
    int updateRead(long tid);
}