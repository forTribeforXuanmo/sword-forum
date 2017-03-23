package com.sword.control;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.sword.mapper.ConcernMapper;
import com.sword.mapper.UserMapper;
import com.sword.model.Concern;
import com.sword.model.User;
import com.sword.model.VO.ConVo;
import com.sword.util.toVoUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * Concern 控制层
 *
 */
@Controller
public class ConcernController {
    @Resource
    private UserMapper userMapper;
    @Resource
    private ConcernMapper concernMapper;
    @RequestMapping("/iConcern")
    @ResponseBody
    public Map iConcern(@RequestParam("pagenumber")int current,
                        @RequestParam("pagesize")int pagesize,
                        @RequestParam(value = "search",required = false)String search,
                        HttpServletRequest request){
        User me= (User) request.getSession().getAttribute("user");
        Map<String,Object> map=new HashMap<String,Object>();
        Page page=new Page(current,pagesize);
        List<ConVo> conVoList=null;
        if(search!=null && !search.trim().equals("")){
            conVoList=concernMapper.iConcernSearch(page,me.getUid(),"%"+search+"%");
        }else {
            conVoList=concernMapper.iConcernSearch(page,me.getUid(),null);
        }
        map.put("total",page.getTotal());
        map.put("rows",conVoList);
        return map;
    }

    @RequestMapping("/concernI")
    @ResponseBody
    public Map concernI(@RequestParam("pagenumber")int current,
                        @RequestParam("pagesize")int pagesize,
                        @RequestParam(value = "search",required = false)String search,
                        HttpServletRequest request){
        User me= (User) request.getSession().getAttribute("user");
        Map<String,Object> map=new HashMap<String,Object>();
        Page page=new Page(current,pagesize);
        List<ConVo> conVoList=null;
        if(search!=null && !search.trim().equals("")){
            conVoList=concernMapper.concernISearch(page,me.getUid(),"%"+search+"%");
        }else {
            conVoList=concernMapper.concernISearch(page,me.getUid(),null);
        }
        map.put("total",page.getTotal());
        map.put("rows",conVoList);
        return map;
    }
    @RequestMapping("/deleteConcern")
    public void deleteIConcern(@RequestParam("conid")long conid, HttpServletResponse response){
        int i=concernMapper.deleteById(conid);
        PrintWriter pw=null;
        if(i==1){
            try {
                pw= response.getWriter();
                pw.write("ok");
            } catch (IOException e) {
                e.printStackTrace();
            }finally {
                if(pw!=null){
                    pw.close();
                }
            }
        }
    }
    @RequestMapping("/cancelConcern")
    public void cancelConcern(@RequestParam("hisuid")long hisuid,HttpServletResponse response,HttpServletRequest request){
        User me= (User) request.getSession().getAttribute("user");
        Map<String,Object>map=new HashMap<String,Object>(2);
        map.put("confromuid",me.getUid());
        map.put("contouid",hisuid);
        int i=concernMapper.deleteByMap(map);
        if(i==1){
            try {
                PrintWriter pw=response.getWriter();
                pw.write("ok");
                pw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else {
            try {
                PrintWriter pw=response.getWriter();
                pw.write("err");
                pw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    @RequestMapping("/addConcern")
    public void addConcern(@RequestParam("hisuid")long hisuid,HttpServletResponse response,HttpServletRequest request){
        User me= (User) request.getSession().getAttribute("user");
        Concern concern=new Concern();
        concern.setConfromuid(me.getUid());
        concern.setContouid(hisuid);
        concernMapper.insert(concern);
        PrintWriter pw=null;
        try {
            pw=response.getWriter();
            pw.write("ok");
        } catch (IOException e) {
            e.printStackTrace();
        }
        if(pw!=null){
            pw.close();
        }
    }

}