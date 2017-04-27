package com.sword.util;

/**
 * Created by asus on 2017/4/25.
 */
public class LevelUtil {
    /**
     * 积分转等级
     * @param point
     * @return
     */
    public static int point2Level(int point){
        if(point>=0&&point<=80){
            return 1;
        }else if(point>=81&&point<=250){
            return 2;
        }else if(point>=251&&point<=600){
            return 3;
        }else if(point>=601&&point<=900){
            return 4;
        }else if(point>=901&&point<=1500){
            return 5;
        }else if(point>=1501&&point<=4000){
            return 6;
        }else if(point>=4001&&point<=10000){
            return 7;
        }else {
            return 8;
        }
    }
}
