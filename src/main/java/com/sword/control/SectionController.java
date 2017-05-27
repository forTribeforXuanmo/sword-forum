package com.sword.control;

import com.sword.listen.Online;
import com.sword.mapper.SectionMapper;
import com.sword.model.Section;
import com.sword.model.VO.SectionVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 *
 * Section 控制层
 *
 */
@Controller
public class SectionController {
    @Resource
    private SectionMapper sectionMapper;
    @RequestMapping("/sectionmenu")
    public String sectionMenu(Map map){
        List<String> parentName=sectionMapper.getParentName();
        List<SectionVo> sectionVoList=new ArrayList<>(parentName.size());
        for(int i=0;i<parentName.size();i++){
            Map<String, Object> mapWhere=new HashMap<String,Object>();
            mapWhere.put("sparentname",parentName.get(i));
            List<Section> par_sections=sectionMapper.selectByMap(mapWhere);
            SectionVo sectionVo=new SectionVo();
            sectionVo.setSparentname(parentName.get(i));
            sectionVo.setSections(par_sections);
            sectionVoList.add(sectionVo);
        }
        map.put("sectionvos",sectionVoList);
        Long maxsid=sectionMapper.selectMaxClickSid();
        map.put("maxsid",maxsid);
        return "index";
    }
    @RequestMapping("/tocatalog")
    public String toCatalog(Map map){
        System.out.println("进来了");
        List<Section> sectionList=sectionMapper.selectAll();
        Long sumOfTopic=sectionMapper.selectAllTopicSum();
        map.put("sectionlist",sectionList);
        map.put("sumoftopic",sumOfTopic);
        map.put("onlineCount", Online.getCount());
        return "forum_main";
    }
    @RequestMapping("/getsection")
    @ResponseBody
    public List<Section> getSection(){
        List<Section> sectionList=sectionMapper.selectAll();
        return  sectionList;
    }
}