package com.sword.model.VO;

import com.sword.model.Addfriend;
import com.sword.model.User;

/**
 * author: lishengzhu
 * eamil:530735771@qq.com
 * date:2017/5/14
 * time:17:22
 */
public class AddFriendVo {
    private User user;
    private Addfriend addfriend;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Addfriend getAddfriend() {
        return addfriend;
    }

    public void setAddfriend(Addfriend addfriend) {
        this.addfriend = addfriend;
    }
}
