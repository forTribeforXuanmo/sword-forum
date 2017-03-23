package com.sword.model.VO;

import java.util.List;

/**
 * Created by Administrator on 2016/11/22.
 */
public class CommentVoS {
    private CommentVo rootcomment;      //直接根评论
    private List<CommentVo> root_directcomment;     //根评论下的直接评论
    private List<CommentVo> root_Ndirectcomment;       //根评论下直接评论的评论

    public CommentVo getRootcomment() {
        return rootcomment;
    }

    public void setRootcomment(CommentVo rootcomment) {
        this.rootcomment = rootcomment;
    }

    public List<CommentVo> getRoot_directcomment() {
        return root_directcomment;
    }

    public void setRoot_directcomment(List<CommentVo> root_directcomment) {
        this.root_directcomment = root_directcomment;
    }

    public List<CommentVo> getRoot_Ndirectcomment() {
        return root_Ndirectcomment;
    }

    public void setRoot_Ndirectcomment(List<CommentVo> root_Ndirectcomment) {
        this.root_Ndirectcomment = root_Ndirectcomment;
    }
}
