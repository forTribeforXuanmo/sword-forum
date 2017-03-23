package com.sword.util;

import com.sun.xml.internal.org.jvnet.mimepull.MIMEMessage;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.*;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.ResourceBundle;

/**
 * Created by Administrator on 2016/11/28.
 */
public class MailUtil {
    private   String username=null;
    private  String password=null;
    private  String host=null;
    private String protocol=null;
    public  void readPro(){
        ResourceBundle resource=ResourceBundle.getBundle("mail");
         username=resource.getString("from");
         password=resource.getString("password");
         host=resource.getString("host");
         protocol=resource.getString("protocol");
    }
    public  void sendSimpleMail(String email,String subject,String context){
        readPro();
        Properties props=new Properties();
        //开启debug
        props.setProperty("mail.debug","true");
        //需要身份验证
        props.setProperty("mail.smtp.auth","true");
        //设置邮件服务器主机名
        props.setProperty("mail.host",host);
        //发送邮件协议名称
        props.setProperty("mail.transport.protocol",protocol);
        //设置环境
        Session session=Session.getInstance(props);
        try {
            //根据session得到transport对象
            Transport ts=session.getTransport();
            ts.connect(host,username,password);
            //创建邮件
            Message msg=createSimpleMail(session,email,subject,context);
            //发送邮件
            ts.sendMessage(msg,msg.getAllRecipients());
            ts.close();
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    /**
     * 创建只包含文本邮件
     * @param session
     * @return
     */
    public  MimeMessage createSimpleMail(Session session,String email,String subject,String context) throws MessagingException {
        MimeMessage msg=new MimeMessage(session);
        //发件人
        msg.setFrom(new InternetAddress(username));
        //收件人
        msg.setRecipient(Message.RecipientType.TO,new InternetAddress(email));
        //标题
        msg.setSubject(subject);
        //文本内容
        msg.setContent(context,"text/html;charset=utf-8");
        //返回邮件对象
        return msg;
    }
    public  MimeMessage createImageMail(Session session,String email,String subject,String content,String imgpath) throws MessagingException, IOException {
        MimeMessage msg=new MimeMessage(session);
        //发件人
        msg.setFrom(new InternetAddress(username));
        //收件人
        msg.setRecipient(Message.RecipientType.TO,new InternetAddress(email));
        //标题
        msg.setSubject(subject);
        //邮件数据
        MimeBodyPart text=new MimeBodyPart();
        text.setContent(content,"text/html;charset=utf-8");
        //准备图片数据
        MimeBodyPart image=new MimeBodyPart();
        DataHandler dh=new DataHandler(new FileDataSource(imgpath));
        image.setDataHandler(dh);
        image.setContentID("xxx.jpg");
        //描述数据关系
        MimeMultipart mm=new MimeMultipart();
        mm.addBodyPart(text);
        mm.addBodyPart(image);
        mm.setSubType("related");

        msg.setContent(mm);
        msg.saveChanges();
        //创建好的邮件写到E盼以文件形式进行保存
        //msg.writeTo(new FileOutputStream("E:\\邮件发送\\email.eml"));
        //返回邮件
        return msg;
    }
}
