package com.sword.util;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

/**
 * Created by Administrator on 2016/11/21.
 */
public class HtmlUtil {
    public static final int  NOTFILTER  = -1;
    public static String getTextFromTHML(String htmlStr,int len) {
        if(len==NOTFILTER){
            return htmlStr;
        }else {
        Document doc = Jsoup.parse(htmlStr);
        String text = doc.text();
        // remove extra white space
        StringBuilder builder = new StringBuilder(text);
        int index = 0;
        while(builder.length()>index){
            char tmp = builder.charAt(index);
            if(Character.isSpaceChar(tmp) || Character.isWhitespace(tmp)){
                builder.setCharAt(index, ' ');
            }
            index++;
        }
        text=fullWidth2halfWidth(builder.toString().trim());
        if(text.length()>len){
            text=text.substring(0,len)+"..";

        }else{
           text=text+"<p>&nbsp;</p>";
        }
            System.out.println(text);
        return text;
        }
    }

    /**
     * 全角字符串转换半角字符串
     *
     * @param fullWidthStr
     *            非空的全角字符串
     * @return 半角字符串
     */
    private static String fullWidth2halfWidth(String fullWidthStr) {
        if (null == fullWidthStr || fullWidthStr.length() <= 0) {
            return "";
        }
        char[] charArray = fullWidthStr.toCharArray();
        //对全角字符转换的char数组遍历
        for (int i = 0; i < charArray.length; ++i) {
            int charIntValue = (int) charArray[i];
            //如果符合转换关系,将对应下标之间减掉偏移量65248;如果是空格的话,直接做转换
            if (charIntValue >= 65281 && charIntValue <= 65374) {
                charArray[i] = (char) (charIntValue - 65248);
            }
//            else if (charIntValue == 12288) {
//                charArray[i] = (char) 32;
//            }
        }
        return new String(charArray);
    }
    public static String filter(String message) {

        if (message == null)
            return (null);

        char content[] = new char[message.length()];
        message.getChars(0, message.length(), content, 0);
        StringBuffer result = new StringBuffer(content.length + 50);
        for (int i = 0; i < content.length; i++) {
            switch (content[i]) {
                case '<':
                    result.append("&lt;");
                    break;
                case '>':
                    result.append("&gt;");
                    break;
                case '&':
                    result.append("&amp;");
                    break;
                case '"':
                    result.append("&quot;");
                    break;
                default:
                    result.append(content[i]);
            }
        }
        return (result.toString());
    }
}
