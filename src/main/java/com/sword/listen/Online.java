package com.sword.listen;

/**
 * Created by asus on 2017/4/11.
 */
public class Online {
    private Online(){
    }
    private static long count=0;
    public static long getCount() {
        return count;
    }
    public static void add(){
        count++;
    }
    public static void delete(){
        count--;
    }
}
