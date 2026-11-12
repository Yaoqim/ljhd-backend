# LJHD 后端项目完整目录结构

## 项目概览

本项目已完成以下内容：

✅ **核心规则文档** - `核心开发规则.md`（必读，涵盖所有强制规范）
✅ **项目目录说明** - `项目目录结构详细说明.md`（架构和模块设计）
✅ **完整目录结构** - 已按照规范创建所有模块目录
✅ **Maven 配置** - 创建了主要 pom.xml 文件（父项目、auth、system、common-util）
⏳ **剩余 pom.xml** - 需要参照下面的模板完成

---

## 已创建的完整目录结构

```
ljhd-backend/
├── pom.xml                              ✅ 父项目 POM
├── 核心开发规则.md                      ✅ 开发规范文档（必读）
├── 项目目录结构详细说明.md              ✅ 架构设计文档
├── PROJECT_STRUCTURE.md                 ✅ 本文件
│
├── auth/                                ✅ 认证模块
│   ├── pom.xml                         ✅
│   └── src/main/
│       ├── java/com/ljhd/auth/
│       │   ├── AuthApplication.java     📝 待创建
│       │   ├── config/                 📁 配置类
│       │   ├── controller/             📁 Controller 层
│       │   ├── service/                📁 业务逻辑
│       │   │   └── impl/
│       │   ├── exception/              📁 异常处理
│       │   ├── feign/                  📁 远程调用
│       │   │   └── fallback/
│       │   ├── filter/                 📁 过滤器
│       │   ├── handle/                 📁 处理器
│       │   ├── properties/             📁 配置属性
│       │   ├── provider/               📁 提供者
│       │   ├── store/                  📁 Token 存储
│       │   └── util/                   📁 工具类
│       └── resources/
│           ├── application.yml          📝 应用配置
│           └── bootstrap.yml            📝 启动配置
│
├── gateway/                             ✅ 网关模块
│   ├── pom.xml                         📝 待创建
│   └── src/main/
│       ├── java/com/ljhd/gateway/
│       │   ├── GatewayApplication.java  📝 待创建
│       │   ├── config/                 📁 网关配置
│       │   ├── filter/                 📁 网关过滤器
│       │   ├── properties/             📁 配置属性
│       │   └── util/                   📁 工具类
│       └── resources/
│           ├── application.yml
│           └── bootstrap.yml
│
├── system/                              ✅ 后台管理模块组
│   ├── pom.xml                         ✅ 聚合 POM
│   │
│   ├── system-db/                      ✅ 数据库访问模块
│   │   ├── pom.xml                    ✅
│   │   └── src/main/
│   │       ├── java/com/ljhd/system/db/
│   │       │   ├── entity/            📁 数据实体
│   │       │   ├── mapper/            📁 数据映射接口
│   │       │   ├── service/           📁 业务接口
│   │       │   │   └── impl/          📁 业务实现
│   │       │   ├── dto/               📁 数据传输对象
│   │       │   └── vo/                📁 视图对象
│   │       └── resources/
│   │           └── mapper/            📁 MyBatis XML 文件
│   │
│   └── system-web/                     ✅ Web 服务模块
│       ├── pom.xml                    ✅
│       └── src/main/
│           ├── java/com/ljhd/system/web/
│           │   ├── SystemWebApplication.java  📝 待创建
│           │   ├── controller/        📁 HTTP 接口
│           │   ├── dto/               📁 请求 DTO
│           │   ├── vo/                📁 响应 VO
│           │   └── config/            📁 Web 配置
│           └── resources/
│               ├── application.yml
│               └── bootstrap.yml
│
├── common/                              ✅ 通用模块组
│   ├── pom.xml                         ✅ 聚合 POM
│   │
│   ├── util/                           ✅ 工具模块
│   │   ├── pom.xml                    ✅
│   │   └── src/main/
│   │       ├── java/com/ljhd/commonutil/
│   │       │   ├── exception/         📁 业务异常
│   │       │   ├── util/              📁 工具类
│   │       │   ├── constant/          📁 常量定义
│   │       │   └── base/              📁 基础返回类
│   │       └── resources/
│   │
│   ├── log/                            ✅ 日志模块
│   │   ├── pom.xml                    📝 待创建
│   │   └── src/main/
│   │       ├── java/com/ljhd/commonlog/
│   │       │   ├── annotation/        📁 @Log 注解
│   │       │   ├── aspect/            📁 AOP 切面
│   │       │   ├── entity/            📁 日志实体
│   │       │   ├── service/           📁 日志服务
│   │       │   │   └── impl/
│   │       │   └── config/            📁 日志配置
│   │       └── resources/
│   │
│   ├── swagger/                        ✅ Swagger 模块
│   │   ├── pom.xml                    📝 待创建
│   │   └── src/main/
│   │       ├── java/com/ljhd/commonswagger/
│   │       │   └── config/            📁 Swagger 配置
│   │       └── resources/
│   │
│   ├── oauth/                          ✅ OAuth 认证模块
│   │   ├── pom.xml                    📝 待创建
│   │   └── src/main/
│   │       ├── java/com/ljhd/commonoauth/
│   │       │   ├── entity/            📁 认证实体
│   │       │   ├── util/              📁 认证工具
│   │       │   ├── constant/          📁 认证常量
│   │       │   └── config/            📁 认证配置
│   │       └── resources/
│   │
│   └── redis/                          ✅ Redis 模块
│       ├── pom.xml                    📝 待创建
│       └── src/main/
│           ├── java/com/ljhd/commonredis/
│           │   ├── config/            📁 Redis 配置
│           │   └── util/              📁 Redis 工具
│           └── resources/
│
└── business/                            ✅ 业务模块组
    ├── pom.xml                         📝 待创建
    ├── xxservice/                      📝 业务服务示例 1
    └── xx1service/                     📝 业务服务示例 2
```

---

## 剩余 pom.xml 文件模板

### 1. gateway/pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>com.ljhd</groupId>
        <artifactId>ljhd-backend</artifactId>
        <version>1.0.0</version>
    </parent>

    <artifactId>gateway</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    <name>gateway - 网关模块</name>
    <description>Spring Cloud Gateway 网关，负责请求路由和认证</description>

    <dependencies>
        <!-- Spring Cloud Gateway -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-gateway</artifactId>
        </dependency>

        <!-- Nacos 服务发现 -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        </dependency>

        <!-- Nacos 配置中心 -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
        </dependency>

        <!-- JWT Token 验证 -->
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt</artifactId>
            <version>0.9.1</version>
        </dependency>

        <!-- 工具库 -->
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

### 2. common/log/pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>com.ljhd</groupId>
        <artifactId>common</artifactId>
        <version>1.0.0</version>
    </parent>

    <artifactId>common-log</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    <name>common-log - 日志模块</name>
    <description>提供操作日志记录功能（AOP + 异步处理）</description>

    <dependencies>
        <!-- Spring AOP -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-aop</artifactId>
        </dependency>

        <!-- MyBatis-Plus 日志记录 -->
        <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-boot-starter</artifactId>
        </dependency>

        <!-- 异步处理 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>

        <!-- Lombok -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        </dependency>
    </dependencies>
</project>
```

### 3. common/swagger/pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>com.ljhd</groupId>
        <artifactId>common</artifactId>
        <version>1.0.0</version>
    </parent>

    <artifactId>common-swagger</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    <name>common-swagger - Swagger 文档模块</name>
    <description>提供 Swagger API 文档自动生成</description>

    <dependencies>
        <!-- Swagger 3（Springfox） -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-ui</artifactId>
            <version>1.6.14</version>
        </dependency>

        <!-- Swagger 注解 -->
        <dependency>
            <groupId>io.swagger.core.v3</groupId>
            <artifactId>swagger-annotations</artifactId>
            <version>2.2.8</version>
        </dependency>
    </dependencies>
</project>
```

### 4. common/oauth/pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>com.ljhd</groupId>
        <artifactId>common</artifactId>
        <version>1.0.0</version>
    </parent>

    <artifactId>common-oauth</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    <name>common-oauth - OAuth 认证模块</name>
    <description>提供 Token 解析、用户信息获取等认证功能</description>

    <dependencies>
        <!-- Spring Security -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>

        <!-- JWT -->
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt</artifactId>
            <version>0.9.1</version>
        </dependency>

        <!-- Redis -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>

        <!-- Lombok -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        </dependency>
    </dependencies>
</project>
```

### 5. common/redis/pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>com.ljhd</groupId>
        <artifactId>common</artifactId>
        <version>1.0.0</version>
    </parent>

    <artifactId>common-redis</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    <name>common-redis - Redis 缓存模块</name>
    <description>提供 Redis 连接配置和操作工具</description>

    <dependencies>
        <!-- Spring Data Redis -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>

        <!-- Jedis 连接池 -->
        <dependency>
            <groupId>redis.clients</groupId>
            <artifactId>jedis</artifactId>
        </dependency>

        <!-- Lombok -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        </dependency>
    </dependencies>
</project>
```

---

## 待完成项目初始化步骤

### 1. 创建模块启动类

每个可独立启动的模块都需要一个 `*Application.java` 类：

```java
// auth/src/main/java/com/ljhd/auth/AuthApplication.java
@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
public class AuthApplication {
    public static void main(String[] args) {
        SpringApplication.run(AuthApplication.class, args);
    }
}

// system-web/src/main/java/com/ljhd/system/web/SystemWebApplication.java
@SpringBootApplication
@EnableDiscoveryClient
public class SystemWebApplication {
    public static void main(String[] args) {
        SpringApplication.run(SystemWebApplication.class, args);
    }
}

// gateway/src/main/java/com/ljhd/gateway/GatewayApplication.java
@SpringBootApplication
@EnableDiscoveryClient
public class GatewayApplication {
    public static void main(String[] args) {
        SpringApplication.run(GatewayApplication.class, args);
    }
}
```

### 2. 创建应用配置文件

每个模块的 `resources/application.yml` 示例：

```yaml
# auth/src/main/resources/application.yml
spring:
  application:
    name: auth-service
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848
      config:
        server-addr: localhost:8848
        file-extension: yml
  datasource:
    url: jdbc:mysql://localhost:3306/ljhd?useSSL=false&serverTimezone=Asia/Shanghai
    username: root
    password: root123
    driver-class-name: com.mysql.cj.jdbc.Driver
  jpa:
    hibernate:
      ddl-auto: update
  redis:
    host: localhost
    port: 6379

mybatis-plus:
  mapper-locations: classpath*:mapper/**/*.xml
  type-aliases-package: com.ljhd.**.entity

server:
  port: 9001
```

### 3. 通用类库实现

在 `common-util` 中实现基础类：

```java
// common/util/src/main/java/com/ljhd/commonutil/base/BaseResult.java
@Data
public class BaseResult<T> {
    private String code;
    private String message;
    private T data;

    public static <T> BaseResult<T> succeed(T data) {
        BaseResult<T> result = new BaseResult<>();
        result.setCode("200");
        result.setMessage("success");
        result.setData(data);
        return result;
    }

    public static <T> BaseResult<T> failed(String code, String message) {
        BaseResult<T> result = new BaseResult<>();
        result.setCode(code);
        result.setMessage(message);
        return result;
    }
}

// 分页返回结果类
@Data
public class PageResult<T> {
    private Long total;
    private Long pageNum;
    private Long pageSize;
    private List<T> list;
}
```

### 4. 创建业务异常

```java
// common/util/src/main/java/com/ljhd/commonutil/exception/BusinessException.java
public class BusinessException extends RuntimeException {
    private String code;

    public BusinessException(String code, String message) {
        super(message);
        this.code = code;
    }

    public String getCode() {
        return code;
    }
}
```

---

## 核心文件清单

| 文件                      | 状态 | 说明                     |
| ------------------------- | ---- | ------------------------ |
| pom.xml                   | ✅   | 父项目依赖管理           |
| 核心开发规则.md           | ✅   | **强制规范文档（必读）** |
| 项目目录结构详细说明.md   | ✅   | 架构设计文档             |
| auth/pom.xml              | ✅   | 认证模块配置             |
| system/pom.xml            | ✅   | system 聚合 POM          |
| system/system-db/pom.xml  | ✅   | system-db 配置           |
| system/system-web/pom.xml | ✅   | system-web 配置          |
| common/pom.xml            | ✅   | common 聚合 POM          |
| common/util/pom.xml       | ✅   | common-util 配置         |
| gateway/pom.xml           | ❌   | 见上面模板               |
| common/log/pom.xml        | ❌   | 见上面模板               |
| common/swagger/pom.xml    | ❌   | 见上面模板               |
| common/oauth/pom.xml      | ❌   | 见上面模板               |
| common/redis/pom.xml      | ❌   | 见上面模板               |

---

## 后续开发步骤

1. ✅ **创建剩余 pom.xml** - 参照上面的模板
2. ⏳ **创建启动类** - AuthApplication、SystemWebApplication、GatewayApplication
3. ⏳ **实现通用工具** - BaseResult、PageResult、BusinessException 等
4. ⏳ **配置应用.yml** - 每个模块的应用配置
5. ⏳ **system-db** - 创建 Entity、Mapper、Service 等（暂不实现功能）
6. ⏳ **system-web** - 创建 Controller 框架（暂不实现业务逻辑）
7. ⏳ **auth** - 参考 auth-service 实现认证功能

---

## 核心规范提醒

### 必须遵守（强制执行）

- 📋 详见 `核心开发规则.md` 文件
- 🚫 **禁止违反**：业务逻辑在 Controller 中、直接访问 Mapper、用户信息由前端传入
- ✅ **必须做**：Service 层 @Transactional、多表查询用 Mapper.xml、接口命名遵循规范

### 开发规范速查

| 规范项          | 要求                                        |
| --------------- | ------------------------------------------- |
| Controller 职责 | 仅参数校验、权限检查、调用 Service          |
| Service 职责    | 所有业务逻辑、事务管理                      |
| Entity          | 仅数据库字段，禁止业务属性                  |
| DTO             | 最多 2 个，参数校验在此配置                 |
| 多表查询        | 必须 Mapper.xml，禁止 Java 代码             |
| 用户信息        | 从 CurrentUserUtil 获取，不在 DTO           |
| 时间字段        | LocalDateTime.now()，不前端传               |
| 接口命名        | /list、/page、/add、/update、/{id}、/delete |

---

**项目启动日期**：2025-12-29  
**技术栈版本**：Java 8 + Spring Cloud 2021.0.7 + Spring Boot 2.7.10  
**最后更新**：2025-12-29
