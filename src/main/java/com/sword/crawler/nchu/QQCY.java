package com.sword.crawler.nchu;

import com.sword.mapper.TopicMapper;
import com.sword.model.Topic;
import edu.uci.ics.crawler4j.crawler.Page;
import edu.uci.ics.crawler4j.crawler.WebCrawler;
import edu.uci.ics.crawler4j.parser.HtmlParseData;
import edu.uci.ics.crawler4j.url.WebURL;
import org.apache.commons.lang.StringEscapeUtils;
import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.ConcurrentHashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * author: lishengzhu
 * eamil:530735771@qq.com
 * date:2017/5/31
 * time:16:28
 */

public class QQCY extends WebCrawler{
    private final static Pattern FILTERS = Pattern
            .compile(".*(\\.(css|js" + "|tiff?|mid|mp2|mp3|mp4" + "|wav|avi|mov|mpeg|ram|m4v|pdf" + "|rm|smil|wmv|swf|wma|zip|rar|gz))$");
    private static String prefix1="http://news.nchu.edu.cn/NewsList.aspx?ClassName=";
    private   static String prefix2="http://news.nchu.edu.cn/newsDetail.aspx?ClassName=";
    public static ConcurrentHashMap<Long,Topic> topicConcurrentHashMap= new ConcurrentHashMap<Long, Topic>();
    private final static Pattern ID_PATTERN=Pattern.compile("id=(\\d*)");
    private static volatile int times=0;

    /**
     * 获取clssname是参数
     * @param urlstr
     * @return
     * @throws MalformedURLException
     */
    public String getClassName(String urlstr) throws MalformedURLException, UnsupportedEncodingException {
        URL url=new URL(urlstr);
        String urlQuery=url.getQuery().toLowerCase();
        if(urlQuery.toLowerCase().contains("classname")){
            String classname=urlQuery.split("&")[0];
            String name=classname.split("=")[1];
            return URLDecoder.decode(name,"gb2312");
        }
        return null;
    }


    @Override
    public boolean shouldVisit(Page referringPage, WebURL url ){
        System.out.println(referringPage.getWebURL().getURL()+" "+referringPage.getContentEncoding()+" "+referringPage.getRedirectedToUrl());
        String href=url.getURL();
        if(FILTERS.matcher(href.toLowerCase()).matches()||!href.startsWith("http://news.nchu.edu.cn/")){
            return false;
        }else {
            return true;
        }


    }
    @Override
    public  void  visit(Page  page){


        String url=page.getWebURL().getURL();
        String name= null;
        try {
            name = getClassName(url);
            if(!name.equals("菁菁校园")){
                return;
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }


        if(page.getParseData() instanceof HtmlParseData){
            HtmlParseData htmlParseData= (HtmlParseData) page.getParseData();
            String html=htmlParseData.getHtml();
            org.jsoup.nodes.Document doc= Jsoup.parse(html);
            Matcher match=ID_PATTERN.matcher(url);
            if(match.find()){
                Long id= Long.valueOf(match.group(1));
                String topic=doc.select("#ctl00_ctl00_ContentPlaceHolder1_ContentPlaceHolder2_lblNewTitle").text();
                String content=doc.select("#Zoom").html();
                String time=doc.select("#ctl00_ctl00_ContentPlaceHolder1_ContentPlaceHolder2_lblNewPostTime").text();
                SimpleDateFormat sdf=new SimpleDateFormat("YYYY/MM/DD hh:mm:ss");
                Date date= null;
                try {
                    date = sdf.parse(time);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                Topic t=new Topic();
                t.setTid(id);
                t.setTsid(100);
                t.setTuid(1L);
                t.setTtopic(topic);
                t.setTcontent(content);
                t.setTtime(date);
                System.out.println(t.toString());
                /** 最原始方式 **/
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/sword","root","1234");
                    Statement statement=con.createStatement();
                    String contentEscape =StringEscapeUtils.escapeHtml(content);
                    String sql="insert into topic(tid,tsid,tuid,ttopic,tcontent,ttime) values(" +id+",100"+",1,'"+topic+"','"+content+"','"+time+
                            "')";
                    logger.debug(sql);
                    statement.executeUpdate(sql);
                    if(!con.isClosed()){
                        con.close();
                    }

                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            }
        }
    }

}
