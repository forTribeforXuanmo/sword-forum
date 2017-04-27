package com.sword.model.VO;

/**
 * Created by asus on 2017/4/11.
 */
public class ChartVo {
    private String xstr;
    private Long  ynum;

    public String getXstr() {
        return xstr;
    }

    public void setXstr(String xstr) {
        this.xstr = xstr;
    }

    public Long getYnum() {
        return ynum;
    }

    public void setYnum(Long ynum) {
        this.ynum = ynum;
    }

    @Override
    public String toString() {
        return "ChartVo{" +
                "xstr='" + xstr + '\'' +
                ", ynum=" + ynum +
                '}';
    }
}
