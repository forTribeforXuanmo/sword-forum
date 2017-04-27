import com.baomidou.mybatisplus.annotations.IdType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.ConfigGenerator;
import org.junit.Test;
import org.omg.CORBA.portable.InputStream;

/**
 * Created by Administrator on 2016/11/16.
 */
public class Shengcheng {
    @Test
    public void test1(){
        ConfigGenerator cg=new ConfigGenerator();
        cg.setDbDriverName("com.mysql.jdbc.Driver");
        cg.setDbUser("lsz");
        cg.setDbPassword("1234");
        cg.setDbUrl("jdbc:mysql://127.0.0.1:3306/sword?characterEncoding=utf-8");

        cg.setEntityPackage("com.sword.model");
        cg.setMapperPackage("com.sword.mapper");
        cg.setServicePackage("com.sword.service");
        cg.setControllerPackage("com.sword.control");
        cg.setXmlPackage("mybatis");
        cg.setServiceImplName("com.sword.service.impl");
        cg.setIdType(IdType.AUTO);


        cg.setSaveDir("C:\\sword1");
        AutoGenerator.run(cg);
    }
    @Test
    public void test2(){
        System.out.println("°¢Ë¹´ïËù");
    }
}
