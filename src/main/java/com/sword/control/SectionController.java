package com.sword.control;

import com.sword.mapper.SectionMapper;
import com.sword.model.Section;
import com.sword.model.VO.SectionVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
        return "index";
    }

}