package com.sword.util;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang.time.DateUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2016/11/21.
 */
public class DateUtil {
    private final static String DATE_FORMAT = "yyyy-MM-dd";
    private final static String DATE_FORMAT_CN = "yyyy年MM月dd日";
    private final static String TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
    private final static String TIME_FORMAT_CN = "yyyy年MM月dd日 HH:mm:ss";
    private final static String MONTH_FORMAT = "yyyy-MM";
    private final static String DAY_FORMAT = "yyyyMMdd";
    public static String date(final Date createDate,int flag){
        if(flag==0) {
            Date now = new Date();
            long interval = now.getTime() - createDate.getTime();
            if ((interval / 1000) < 60) {
                return interval / 1000 + "秒";
            } else if (interval / 60000 < 60) {
                return interval / 60000 + "分";
            } else if (interval / 3600000 < 24) {
                return interval / 3600000 + "时";
            } else if (interval / 3600000 / 24 < 365) {
                return interval / 3600000 / 24 + "天";
            } else {
                return interval / 1000 / 60 / 60 / 60 / 365 + "年";
            }

        }else if(flag==1){
            return toCh_Formate(createDate);
        }

        return "";

    }
    public static String toCh_Formate(final Date createDate){
        return   DateFormatUtils.format(createDate,TIME_FORMAT_CN);
    }
    public static String toDay_Format(final Date createDate){
        String data=DateFormatUtils.format(createDate,"yyyyMMddHHmmss");
        return data;
    }
    public static Date toDate_Formate(String date){
        SimpleDateFormat sdf=new SimpleDateFormat(DATE_FORMAT);
        Date d=null;
        try {
            d=sdf.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return d;
    }

}
