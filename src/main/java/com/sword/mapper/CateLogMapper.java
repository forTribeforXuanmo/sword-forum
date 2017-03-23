package com.sword.mapper;

import com.baomidou.mybatisplus.plugins.Page;
import com.sword.model.Topic;

import java.util.List;

/**
 * Created by Administrator on 2016/11/21.
 */
public interface CateLogMapper {
    //查询某个的版块的回帖数
    int sectionReply(int sectionid);
    //查询某个版块下的未被封的帖子  倒序倒序
    List<Topic> sectionTopic(Page<Topic> page, int sectionid);
}
