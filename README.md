# 仗剑论坛Sword `version 1.0`
## a java forum
### 核心功能
1. 登录注册
2. 用户发布帖子，查询及删除所发布的帖子
3. 参与帖子的下评论，评论仿qq空间，除了直接在帖子下评论还可以对帖子下其他人回复
4. 查看个人信息和他人个人信息
5. 修改个人资料及密码修改（email验证）
6. 关注其他用户，当进入自己个人空间时会展示你所关注人的最近发布的帖子
7. 及时提示未读消息（未读评论与私信和添加好友的反馈通知）
8. 私信
9. 爬虫获取知名网站新闻（有待实现）
10. 响应式布局支持  
### 技术选型
**后端**  
- IOC容器Spring
- Web容器SpringMVC
- Orm框架MyBatis(使用`青苗`大神的[MyBatisPlus](http://mp.baomidou.com/#/))
- 视图模板Jsp/Jstl
- 长连接spring-websocket
- 其他 Jsoup,fastjson等

**前端**  
- JQuery js框架
- Bootstrap 响应式框架
- Summernote编辑器
- Cropper裁剪图片
- font-wesome字体
- layer 弹出层 

**支持浏览器**
- chrome/firfox/ie9+
