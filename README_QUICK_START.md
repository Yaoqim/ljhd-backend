# LJHD 后端项目 - 快速启动指南

## 📋 项目初始化完成清单

✅ **已完成**

- [x] 核心开发规则文档 (`核心开发规则.md`)
- [x] 项目目录结构说明 (`项目目录结构详细说明.md`)
- [x] 完整目录结构创建
- [x] 主要 pom.xml 配置
- [x] 项目结构指南 (`PROJECT_STRUCTURE.md`)

❌ **待完成**（参考 `PROJECT_STRUCTURE.md` 中的模板）

- [ ] gateway、common-log、common-swagger、common-oauth、common-redis 的 pom.xml
- [ ] 各模块的 Application.java 启动类
- [ ] application.yml 配置文件
- [ ] 通用工具类实现
- [ ] system 模块的框架代码

---

## 📚 关键文档

### 1. **核心开发规则.md** ⭐⭐⭐ 必读

详细的开发规范，涵盖：

- 代码分层职责（Controller、Service、Mapper）
- Entity、DTO、VO 规范
- 接口命名规范
- 多表查询规范
- 用户信息和时间字段规范
- 事务管理规范

**开发前必须阅读！**

### 2. 项目目录结构详细说明.md

项目架构和模块设计文档

### 3. PROJECT_STRUCTURE.md

完整的项目结构指南和初始化步骤

---

## 🚀 项目结构概览

```
ljhd-backend/
├── auth/                    # 认证模块
├── gateway/                 # 网关模块
├── system/                  # 后台管理模块
│   ├── system-db/          # 数据库访问层
│   └── system-web/         # HTTP API 层
├── common/                  # 通用模块
│   ├── util/               # 工具库
│   ├── log/                # 日志模块
│   ├── swagger/            # API 文档
│   ├── oauth/              # 认证授权
│   └── redis/              # 缓存
└── business/               # 业务模块（示例）
```

---

## 🔑 核心规范速查

### ❌ 红线规范（严禁违反）

| 规范                    | 说明                            |
| ----------------------- | ------------------------------- |
| Controller 中有业务逻辑 | ❌ 禁止，所有业务放在 Service   |
| 多表查询用 Java 代码    | ❌ 禁止，必须用 Mapper.xml JOIN |
| 用户信息由前端传入      | ❌ 禁止，从登录信息获取         |
| 时间字段由前端传入      | ❌ 禁止，服务器自动生成         |

### ✅ 绿线规范（必须遵守）

| 规范                      | 说明                                           |
| ------------------------- | ---------------------------------------------- |
| Service 层 @Transactional | ✅ 所有修改操作必须                            |
| Entity 仅数据库字段       | ✅ 禁止业务属性                                |
| VO 继承 Entity            | ✅ 用于响应数据                                |
| DTO 最多 2 个             | ✅ SearchDto + Dto                             |
| 接口命名规范              | ✅ /list、/page、/add、/update、/{id}、/delete |

---

## 📖 接口命名规范

所有 RESTful 接口必须遵循以下规范：

```
GET    /system/user/list           # 查询全部（不分页）
POST   /system/user/page           # 分页查询
GET    /system/user/{id}           # 根据 ID 查询
POST   /system/user/add            # 新增
POST   /system/user/update         # 修改
POST   /system/user/{id}           # 删除（POST）
POST   /system/user/delete         # 批量删除
```

**绝对禁止随意命名！**

---

## 🏗️ 代码分层职责

### Controller 层

```java
@RestController
@RequestMapping("/system/user")
public class UserController {

    // ✅ 正确：仅接收请求、参数校验、调用 Service
    @PostMapping("/add")
    public BaseResult<Void> add(@Valid @RequestBody UserDto userDto) {
        userService.createUser(userDto);  // 业务逻辑在 Service
        return BaseResult.succeed();
    }
}
```

### Service 层

```java
@Service
public class UserServiceImpl implements UserService {

    // ✅ 正确：包含业务逻辑和事务管理
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void createUser(UserDto userDto) {
        // 从登录信息获取用户
        LoginAppUser currentUser = CurrentUserUtil.getCurrentLoginUser();

        // 业务逻辑实现
        User user = new User();
        user.setUserName(userDto.getUserName());
        user.setCreateUserId(currentUser.getUserId());
        user.setCreateTime(LocalDateTime.now());  // 服务器时间

        userMapper.insert(user);
    }
}
```

### Mapper 层（多表查询示例）

```xml
<!-- ✅ 正确：在 XML 中实现 JOIN -->
<select id="selectUserWithDepartment" resultType="UserVO">
    SELECT
        u.id,
        u.user_name,
        d.department_name
    FROM user u
    LEFT JOIN department d ON u.dept_id = d.id
    WHERE u.is_deleted = 0
</select>
```

---

## 📦 技术栈版本

| 组件         | 版本     |
| ------------ | -------- |
| Java         | 8        |
| Spring Boot  | 2.7.10   |
| Spring Cloud | 2021.0.7 |
| MySQL        | 8.0      |
| MyBatis-Plus | 3.5.3.1  |
| Nacos        | 2.2.0    |

---

## 🎯 项目模块依赖关系

```
业务服务
    ↓ 依赖
system-web (Web 接口层)
    ↓ 依赖
system-db (业务逻辑层)
    ↓ 依赖
通用模块 (util, log, oauth, redis, swagger)

auth (认证模块)
    ↓ 依赖
system-db + 通用模块

gateway (网关)
    ↓ 依赖
通用模块
```

---

## ⚠️ 常见错误示例

### ❌ 错误 1：业务逻辑在 Controller

```java
@PostMapping("/add")
public BaseResult<Void> add(@RequestBody UserDto userDto) {
    // ❌ 错误：业务逻辑不应该在这里
    User user = new User();
    user.setUserName(userDto.getUserName());

    if (user.getUserName().length() > 50) {
        return BaseResult.failed("...", "...");
    }

    userMapper.insert(user);  // ❌ 错误：不应该直接访问 Mapper
    return BaseResult.succeed();
}
```

### ❌ 错误 2：多表查询用 Java 代码（N+1 问题）

```java
// ❌ 错误
List<User> users = userMapper.selectList(null);  // 1 次查询
for (User user : users) {
    Department dept = deptMapper.selectById(user.getDeptId());  // N 次查询
    // 手动组装...
}
```

### ❌ 错误 3：用户信息由前端传入

```java
@Data
public class UserDto {
    private String userName;
    private Long createUserId;  // ❌ 错误：不应该由前端传入
    private LocalDateTime createTime;  // ❌ 错误：不应该由前端传入
}
```

---

## ✅ 正确做法

```java
// ✅ 正确：Service 中处理所有业务逻辑和时间用户信息
@Override
@Transactional(rollbackFor = Exception.class)
public void createUser(UserDto userDto) {
    // 从登录信息获取当前用户
    LoginAppUser currentUser = CurrentUserUtil.getCurrentLoginUser();

    User user = new User();
    user.setUserName(userDto.getUserName());
    user.setCreateUserId(currentUser.getUserId());  // ✅ 自动设置
    user.setCreateTime(LocalDateTime.now());        // ✅ 自动设置

    userMapper.insert(user);
}

// ✅ 正确：多表查询在 Mapper.xml 中实现
List<UserVO> users = userMapper.selectUserWithDepartment();  // 一次查询，JOIN 在 XML 中
```

---

## 📞 需要帮助？

1. **查看核心规范**：阅读 `核心开发规则.md`
2. **查看项目结构**：查看 `PROJECT_STRUCTURE.md`
3. **参考架构设计**：查看 `项目目录结构详细说明.md`

---

**项目启动日期**：2025-12-29
**更新日期**：2025-12-29
**版本**：1.0.0
