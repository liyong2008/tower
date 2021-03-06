### dao 实现

+ 实现标准

	+ 配置必须动态加载
	+ 应用配置与资源配置分离
	
	+ memcached

		+ 实现类 com.#{company}.service.common.datasource.DynamicDataSource
	
+ ... 

+配置
	
	+ 应用配置
		+ 保存在#{artifactId}-dao/src/main/resource/META-INF/config/spring
		+ spring-db.xml
	+ 资源&开关配置
		+ 资源文件默认保存在/config目录,当没有找到时，程序会从tsl-dao/src/main/resource/META-INF/config/local中读取配置信息
		+ database.properties
		
+ dao操作扩展实现
	
	+ 1,在相应的对象数据访问层接口定义接口 aa
	+ 2,在map接口上定义相关接口 aa
	+ 3,在map文件上定义sql实现 id 为 aa [注意：parameterType必须为"java.util.Map"，表名必须采用‘${t#{company}TabName}’替换]
	+ 4,在数据访问层定义实现，实现代码如下
		
		```
		/**
	 	 * 
	 	 * @param tabNameSuffix 分表访问支持
	 	 * @param params 操作支持的参数
	     */
	     
	  pubic void aa(String tabNameSuffix,Map param){
	    
	    SqlSession session = SqlmapUtils.openSession(getMapQueryDataSource());
	    try{
    	    IMapper<EccOrderinfo> mapper = session.getMapper(getMapperClass());
    	    Map params = new HashMap();
    	    params.put("t#{company}TabName", this.get$T#{company}TabName(tabNameSuffix));//分表访问支持
    	    List<EccOrderinfo> returnList = mapper.aa(params);
	    } catch (Exception t) {
	      throw new DataAccessException(IBatisDAOException.MSG_2_0001, t);
	    } finally {
	      session.commit();
	      session.close();
	    }
	 }
		
		```