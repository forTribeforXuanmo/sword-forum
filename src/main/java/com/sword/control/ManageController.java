package com.sword.control;

import com.sun.istack.internal.Nullable;
import com.sword.mapper.ManageMapper;
import com.sword.model.Manage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * Manage 控制层
 *
 */
@Controller
@RequestMapping("/man")
public class ManageController {
    @Resource
    private ManageMapper manageMapper;
    @RequestMapping("/loginback")
    public String loginback(String username, String password, HttpServletRequest request){
        Manage manage=new Manage();
        manage.setMname(username);
        manage.setMpassword(password);
        @Nullable
        Manage  me=manageMapper.selectOne(manage);
        if(me==null){
            return "redirect:../login2.html?logininfo=err";
     }else {
            request.getSession().setAttribute("admin",me);
            return "manage";
        }
}

}