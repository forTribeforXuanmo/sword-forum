package com.sword.util;

import java.util.Random;

/**
 * Created by Administrator on 2016/11/28.
 */
public class RandomUtil {
    //产生随机4位验证码
    public static final char arry[]= { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
            'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
            'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
    public static String getyzm(int len){
        Random random=new Random();
        StringBuilder sb=new StringBuilder();
        for (int i = 0; i <len ; i++) {
            String strRand= String.valueOf(arry[random.nextInt(36)]);
            sb.append(strRand);
        }
        System.out.println(sb.toString());
        return sb.toString();

    }

}
