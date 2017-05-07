package com.sword.control;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.sun.istack.internal.Nullable;
import com.sun.mail.imap.Utility;
import com.sword.mapper.ManageMapper;
import com.sword.mapper.SectionMapper;
import com.sword.mapper.TopicMapper;
import com.sword.mapper.UserMapper;
import com.sword.model.Manage;
import com.sword.model.Section;
import com.sword.model.User;
import com.sword.model.VO.ChartVo;
import com.sword.util.DateUtil;
import com.sword.util.LevelUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Manage 控制层
 */
@Controller

public class ManageController {
    @Resource
    private ManageMapper manageMapper;
    @Resource
    private UserMapper userMapper;
    @Resource
    private SectionMapper sectionMapper;
    @Resource
    private TopicMapper topicMapper;

    /**
     * 登录到后台
     **/
    @RequestMapping("/mloginback")
    public String loginback(String username, String password, HttpServletRequest request) {
        Manage manage = new Manage();
        manage.setMname(username);
        manage.setMpassword(password);
        @Nullable
        Manage me = manageMapper.selectOne(manage);
        if (me == null) {
            return "redirect:../login2.html?logininfo=err";
        } else {
            request.getSession().setAttribute("admin", me);
            return "manage";
        }
    }

    /**
     * 图表显示
     **/
    @RequestMapping("/mtoChart")
    public String tochart() {
        return "chart";
    }

    @RequestMapping("/mtopictcount")
    @ResponseBody
    public Map topicCount(@RequestParam("type") String type, @RequestParam("year") String year) {
        List<ChartVo> chartVos = null;
        if ("week".equals(type)) {
            chartVos = manageMapper.getTopicChartByWeek(year);
        } else if ("month".equals(type)) {
            chartVos = manageMapper.getTopicChartByMonth(year);
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("topicchart", chartVos);
        return map;
    }

    @RequestMapping("/mcommentcount")
    @ResponseBody
    public Map commentCount(@RequestParam("type") String type, @RequestParam("year") String year) {
        List<ChartVo> chartVos = null;
        if ("week".equals(type)) {
            chartVos = manageMapper.getCommentChartByWeek(year);
        } else if ("month".equals(type)) {
            chartVos = manageMapper.getCommentChartByMonth(year);
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("commentchart", chartVos);
        return map;
    }

    @RequestMapping("/mregistercount")
    @ResponseBody
    public Map registerCount(@RequestParam("type") String type, @RequestParam("year") String year) {
        List<ChartVo> chartVos = null;
        if ("week".equals(type)) {
            chartVos = manageMapper.getRegisterChartByWeek(year);
        } else if ("month".equals(type)) {
            chartVos = manageMapper.getRegisterChartByMonth(year);
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("registerchart", chartVos);
        return map;
    }

    /**
     * 用户管理
     **/
    @RequestMapping("/mtomanusers")
    public String toManUsersJsp() {
        return "manusers";
    }

    @RequestMapping("/manlistusers")
    @ResponseBody
    public List<User> manListUsers() {
        ArrayList<User> userList = (ArrayList<User>) userMapper.selectList(new EntityWrapper<User>(new User()));
        for (User user : userList) {
            System.out.println(user.getUnickname() + " " + user.getUpassword());
        }
        return userList.size() == 0 ? null : userList;
    }

    @RequestMapping("/mtoedituser")
    public String mToEditUser(@RequestParam("uid") long uid, Map<String, Object> map) {
        System.out.println("选择的用户id" + uid);
        User user = userMapper.selectById(uid);
        if (user == null) {
            return "redirect:/404 .html";
        }
        map.put("selectUser", user);
        return "edituser";
    }

    //修改更新用户信息
    @RequestMapping("/meditupdateuser")
    public void mEditUpdateUser(@RequestParam("uid") long uid, @RequestParam("uemail") String uemail,
                                @RequestParam("unickname") String unickname, @RequestParam("upassword") String upassword,
                                @RequestParam("usex") int usex, @RequestParam("ubirthday") String ubirthdaystr,
                                @RequestParam("ustatement") String ustatement, @RequestParam("ustate") int ustate,
                                @RequestParam("upoint") int upoint, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Date birthday = DateUtil.toDate_Formate(ubirthdaystr);
        Pattern pattern2 = Pattern.compile("^[\\w]{6,12}$");
        Matcher matcher2 = pattern2.matcher(upassword.trim());
        PrintWriter pw = response.getWriter();
        if (matcher2.matches() && ustate >= -1 && upoint >= 0 && (usex == 0 || usex == 1)) {
            HttpSession session = request.getSession(false);
            Manage manage = null;
            if (session != null) {
                manage = (Manage) session.getAttribute("admin");
            }
            if (manage != null) {
                int level = LevelUtil.point2Level(upoint);
                User user = new User();
                user.setUid(uid);
                user.setUnickname(unickname);
                user.setUpassword(upassword);
                user.setUsex(usex);
                user.setUbirthday(birthday);
                user.setUstatement(ustatement);
                user.setUstate(ustate);
                user.setUlevel(level);
                user.setUpoint(upoint);
                userMapper.updateSelectiveById(user);
                pw.write("success");
                pw.close();
            }else {
                pw.write("sessionout");
                pw.close();
            }

        } else {
            pw.write("err");
            pw.close();
        }

    }

    /**
     * 到达adduser页面
     * @return
     */
    @RequestMapping("/mtoadduser")
    public String addUserJsp(){
        return "adduser";
    }

    /**
     * 增加用户
     * @param uemail
     * @param unickname
     * @param upassword
     * @param usex
     * @param ubirthdaystr
     * @param ustatement
     * @param ustate
     * @param upoint
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/madduser")
    public void addUser(@RequestParam("uemail") String uemail,
                        @RequestParam("unickname") String unickname, @RequestParam("upassword") String upassword,
                        @RequestParam("usex") int usex, @RequestParam("ubirthday") String ubirthdaystr,
                        @RequestParam("ustatement") String ustatement, @RequestParam("ustate") int ustate,
                        @RequestParam("upoint") int upoint, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Date birthday = DateUtil.toDate_Formate(ubirthdaystr);
        int level = LevelUtil.point2Level(upoint);
        Pattern pattern2 = Pattern.compile("^[\\w]{6,12}$");
        Matcher matcher2 = pattern2.matcher(upassword.trim());
        Pattern pattern1 = Pattern.compile("^(\\w-*\\.*)+@(\\w-?)+(\\.\\w{2,})+$");
        Matcher matcher1 = pattern1.matcher(uemail.trim());
        PrintWriter pw = response.getWriter();
        if (matcher1.matches()&&matcher2.matches() && ustate >= -1 && upoint >= 0 && (usex == 0 || usex == 1)) {
            HttpSession session = request.getSession(false);
            Manage manage = null;
            if (session != null) {
                manage = (Manage) session.getAttribute("admin");
            }
            if (manage != null) {
                Map<String, Object> mapwhere = new HashMap<String, Object>(1);
                mapwhere.put("uemail", uemail);
                List<User> user = userMapper.selectByMap(mapwhere);
                if (user == null || user.size() == 0) {
                    User newuser = new User();
                    newuser.setUemail(uemail);
                    newuser.setUnickname(unickname);
                    newuser.setUpassword(upassword);
                    newuser.setUsex(usex);
                    newuser.setUbirthday(birthday);
                    newuser.setUstatement(ustatement);
                    newuser.setUstate(ustate);
                    newuser.setUlevel(level);
                    newuser.setUpoint(upoint);
                   int i= userMapper.insert(newuser);
                /*插入数据，同步防止数据库出现多条邮箱一样的*/
                    if (i == 1) {
                        pw.write("success");
                    } else {
                        pw.write("busy");   //并发现象 繁忙
                    }
                } else {
                    pw.write("has");        //用户已被注册
                }
                pw.close();
            }else {
                pw.write("sessionout");
                pw.close();
            }
        } else {
            pw.write("err");
            pw.close();
        }
    }
    /**板块管理**/
    @RequestMapping("/mtomansections")
    public String toManSections(){
        return "mansections";
    }
    @RequestMapping("/manlistsections")
    @ResponseBody
    public List manListSections(){
        List<Section> sectionList=sectionMapper.selectList(new EntityWrapper<>(new Section()));
        return  sectionList;
    }
    @RequestMapping("/mtoeditsection")
    public String mToEditSection(@RequestParam("sid") int sid,Map<String,Object>map){
        Section section=sectionMapper.selectById(sid);
        map.put("selectSection",section);
        return "editsection";
    }
    @RequestMapping("meditupdatesection")
    public void mEditUpdateSection(@RequestParam("sid")int sid,@RequestParam("sname")String sname,
                                   @RequestParam("sstatement")String sstatement,@RequestParam("sshortsm")String sshortsm,
                                   @RequestParam("smasterid")long smasterid,HttpServletResponse response) throws IOException {
        Section section=sectionMapper.selectById(sid);
        PrintWriter pw=response.getWriter();
        if(section==null){
            pw.write("nosection");
        }else {
            if(sname.trim()==""||sstatement.trim()==""||sshortsm.trim()==""){
                pw.write("hasnull");
            }else{
                User user=userMapper.selectById(smasterid);
                if(user==null){
                    pw.write("smsternotexist");
                }else {
                    section.setSname(sname);
                    section.setSstatement(sstatement);
                    section.setSshortsm(sshortsm);
                    section.setSmasterid(smasterid);
                    sectionMapper.updateSelectiveById(section);
                    pw.write("success");
                }
            }
        }
    }
}
