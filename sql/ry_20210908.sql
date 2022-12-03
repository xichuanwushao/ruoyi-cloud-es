SET NAMES utf8mb4;

-- ----------------------------
-- 1、部门表
-- ----------------------------
drop table if exists sys_dept;
create table sys_dept (
  dept_id           bigint(20)      not null auto_increment    comment '部门id',
  parent_id         bigint(20)      default 0                  comment '父部门id',
  ancestors         varchar(50)     default ''                 comment '祖级列表',
  dept_name         varchar(30)     default ''                 comment '部门名称',
  order_num         int(4)          default 0                  comment '显示顺序',
  leader            varchar(20)     default null               comment '负责人',
  phone             varchar(11)     default null               comment '联系电话',
  email             varchar(50)     default null               comment '邮箱',
  status            char(1)         default '0'                comment '部门状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time 	    datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  primary key (dept_id)
) engine=innodb auto_increment=200 comment = '部门表';

-- ----------------------------
-- 初始化-部门表数据
-- ----------------------------
insert into sys_dept values(100,  0,   '0',          '若依科技',   0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(101,  100, '0,100',      '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(102,  100, '0,100',      '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(103,  101, '0,100,101',  '研发部门',   1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(104,  101, '0,100,101',  '市场部门',   2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(105,  101, '0,100,101',  '测试部门',   3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(106,  101, '0,100,101',  '财务部门',   4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(107,  101, '0,100,101',  '运维部门',   5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(108,  102, '0,100,102',  '市场部门',   1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate(), '', null);
insert into sys_dept values(109,  102, '0,100,102',  '财务部门',   2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', sysdate(), '', null);


-- ----------------------------
-- 2、用户信息表
-- ----------------------------
drop table if exists sys_user;
create table sys_user (
  user_id           bigint(20)      not null auto_increment    comment '用户ID',
  dept_id           bigint(20)      default null               comment '部门ID',
  user_name         varchar(30)     not null                   comment '用户账号',
  nick_name         varchar(30)     not null                   comment '用户昵称',
  user_type         varchar(2)      default '00'               comment '用户类型（00系统用户）',
  email             varchar(50)     default ''                 comment '用户邮箱',
  phonenumber       varchar(11)     default ''                 comment '手机号码',
  sex               char(1)         default '0'                comment '用户性别（0男 1女 2未知）',
  avatar            varchar(100)    default ''                 comment '头像地址',
  password          varchar(100)    default ''                 comment '密码',
  status            char(1)         default '0'                comment '帐号状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  login_ip          varchar(128)    default ''                 comment '最后登录IP',
  login_date        datetime                                   comment '最后登录时间',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (user_id)
) engine=innodb auto_increment=100 comment = '用户信息表';

-- ----------------------------
-- 初始化-用户信息表数据
-- ----------------------------
insert into sys_user values(1,  103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), 'admin', sysdate(), '', null, '管理员');
insert into sys_user values(2,  105, 'ry',    '若依', '00', 'ry@qq.com',  '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), 'admin', sysdate(), '', null, '测试员');


-- ----------------------------
-- 3、岗位信息表
-- ----------------------------
drop table if exists sys_post;
create table sys_post
(
  post_id       bigint(20)      not null auto_increment    comment '岗位ID',
  post_code     varchar(64)     not null                   comment '岗位编码',
  post_name     varchar(50)     not null                   comment '岗位名称',
  post_sort     int(4)          not null                   comment '显示顺序',
  status        char(1)         not null                   comment '状态（0正常 1停用）',
  create_by     varchar(64)     default ''                 comment '创建者',
  create_time   datetime                                   comment '创建时间',
  update_by     varchar(64)     default ''			       comment '更新者',
  update_time   datetime                                   comment '更新时间',
  remark        varchar(500)    default null               comment '备注',
  primary key (post_id)
) engine=innodb comment = '岗位信息表';

-- ----------------------------
-- 初始化-岗位信息表数据
-- ----------------------------
insert into sys_post values(1, 'ceo',  '董事长',    1, '0', 'admin', sysdate(), '', null, '');
insert into sys_post values(2, 'se',   '项目经理',  2, '0', 'admin', sysdate(), '', null, '');
insert into sys_post values(3, 'hr',   '人力资源',  3, '0', 'admin', sysdate(), '', null, '');
insert into sys_post values(4, 'user', '普通员工',  4, '0', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 4、角色信息表
-- ----------------------------
drop table if exists sys_role;
create table sys_role (
  role_id              bigint(20)      not null auto_increment    comment '角色ID',
  role_name            varchar(30)     not null                   comment '角色名称',
  role_key             varchar(100)    not null                   comment '角色权限字符串',
  role_sort            int(4)          not null                   comment '显示顺序',
  data_scope           char(1)         default '1'                comment '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  menu_check_strictly  tinyint(1)      default 1                  comment '菜单树选择项是否关联显示',
  dept_check_strictly  tinyint(1)      default 1                  comment '部门树选择项是否关联显示',
  status               char(1)         not null                   comment '角色状态（0正常 1停用）',
  del_flag             char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by            varchar(64)     default ''                 comment '创建者',
  create_time          datetime                                   comment '创建时间',
  update_by            varchar(64)     default ''                 comment '更新者',
  update_time          datetime                                   comment '更新时间',
  remark               varchar(500)    default null               comment '备注',
  primary key (role_id)
) engine=innodb auto_increment=100 comment = '角色信息表';

-- ----------------------------
-- 初始化-角色信息表数据
-- ----------------------------
insert into sys_role values('1', '超级管理员',  'admin',  1, 1, 1, 1, '0', '0', 'admin', sysdate(), '', null, '超级管理员');
insert into sys_role values('2', '普通角色',    'common', 2, 2, 1, 1, '0', '0', 'admin', sysdate(), '', null, '普通角色');


-- ----------------------------
-- 5、菜单权限表
-- ----------------------------
drop table if exists sys_menu;
create table sys_menu (
  menu_id           bigint(20)      not null auto_increment    comment '菜单ID',
  menu_name         varchar(50)     not null                   comment '菜单名称',
  parent_id         bigint(20)      default 0                  comment '父菜单ID',
  order_num         int(4)          default 0                  comment '显示顺序',
  path              varchar(200)    default ''                 comment '路由地址',
  component         varchar(255)    default null               comment '组件路径',
  query             varchar(255)    default null               comment '路由参数',
  is_frame          int(1)          default 1                  comment '是否为外链（0是 1否）',
  is_cache          int(1)          default 0                  comment '是否缓存（0缓存 1不缓存）',
  menu_type         char(1)         default ''                 comment '菜单类型（M目录 C菜单 F按钮）',
  visible           char(1)         default 0                  comment '菜单状态（0显示 1隐藏）',
  status            char(1)         default 0                  comment '菜单状态（0正常 1停用）',
  perms             varchar(100)    default null               comment '权限标识',
  icon              varchar(100)    default '#'                comment '菜单图标',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default ''                 comment '备注',
  primary key (menu_id)
) engine=innodb auto_increment=2000 comment = '菜单权限表';

-- ----------------------------
-- 初始化-菜单信息表数据
-- ----------------------------
-- 一级菜单
insert into sys_menu values('1', '系统管理', '0', '1', 'system',           null, '', 1, 0, 'M', '0', '0', '', 'system',   'admin', sysdate(), '', null, '系统管理目录');
insert into sys_menu values('2', '系统监控', '0', '2', 'monitor',          null, '', 1, 0, 'M', '0', '0', '', 'monitor',  'admin', sysdate(), '', null, '系统监控目录');
insert into sys_menu values('3', '系统工具', '0', '3', 'tool',             null, '', 1, 0, 'M', '0', '0', '', 'tool',     'admin', sysdate(), '', null, '系统工具目录');
insert into sys_menu values('4', '若依官网', '0', '4', 'http://ruoyi.vip', null, '', 0, 0, 'M', '0', '0', '', 'guide',    'admin', sysdate(), '', null, '若依官网地址');
-- 二级菜单
insert into sys_menu values('100',  '用户管理',       '1',   '1', 'user',       'system/user/index',                 '', 1, 0, 'C', '0', '0', 'system:user:list',        'user',          'admin', sysdate(), '', null, '用户管理菜单');
insert into sys_menu values('101',  '角色管理',       '1',   '2', 'role',       'system/role/index',                 '', 1, 0, 'C', '0', '0', 'system:role:list',        'peoples',       'admin', sysdate(), '', null, '角色管理菜单');
insert into sys_menu values('102',  '菜单管理',       '1',   '3', 'menu',       'system/menu/index',                 '', 1, 0, 'C', '0', '0', 'system:menu:list',        'tree-table',    'admin', sysdate(), '', null, '菜单管理菜单');
insert into sys_menu values('103',  '部门管理',       '1',   '4', 'dept',       'system/dept/index',                 '', 1, 0, 'C', '0', '0', 'system:dept:list',        'tree',          'admin', sysdate(), '', null, '部门管理菜单');
insert into sys_menu values('104',  '岗位管理',       '1',   '5', 'post',       'system/post/index',                 '', 1, 0, 'C', '0', '0', 'system:post:list',        'post',          'admin', sysdate(), '', null, '岗位管理菜单');
insert into sys_menu values('105',  '字典管理',       '1',   '6', 'dict',       'system/dict/index',                 '', 1, 0, 'C', '0', '0', 'system:dict:list',        'dict',          'admin', sysdate(), '', null, '字典管理菜单');
insert into sys_menu values('106',  '参数设置',       '1',   '7', 'config',     'system/config/index',               '', 1, 0, 'C', '0', '0', 'system:config:list',      'edit',          'admin', sysdate(), '', null, '参数设置菜单');
insert into sys_menu values('107',  '通知公告',       '1',   '8', 'notice',     'system/notice/index',               '', 1, 0, 'C', '0', '0', 'system:notice:list',      'message',       'admin', sysdate(), '', null, '通知公告菜单');
insert into sys_menu values('108',  '日志管理',       '1',   '9', 'log',        '',                                  '', 1, 0, 'M', '0', '0', '',                        'log',           'admin', sysdate(), '', null, '日志管理菜单');
insert into sys_menu values('109',  '在线用户',       '2',   '1', 'online',     'monitor/online/index',              '', 1, 0, 'C', '0', '0', 'monitor:online:list',     'online',        'admin', sysdate(), '', null, '在线用户菜单');
insert into sys_menu values('110',  '定时任务',       '2',   '2', 'job',        'monitor/job/index',                 '', 1, 0, 'C', '0', '0', 'monitor:job:list',        'job',           'admin', sysdate(), '', null, '定时任务菜单');
insert into sys_menu values('111',  'Sentinel控制台', '2',   '3', 'http://localhost:8718',        '',                '', 0, 0, 'C', '0', '0', 'monitor:sentinel:list',   'sentinel',      'admin', sysdate(), '', null, '流量控制菜单');
insert into sys_menu values('112',  'Nacos控制台',    '2',   '4', 'http://localhost:8848/nacos',  '',                '', 0, 0, 'C', '0', '0', 'monitor:nacos:list',      'nacos',         'admin', sysdate(), '', null, '服务治理菜单');
insert into sys_menu values('113',  'Admin控制台',    '2',   '5', 'http://localhost:9100/login',  '',                '', 0, 0, 'C', '0', '0', 'monitor:server:list',     'server',        'admin', sysdate(), '', null, '服务监控菜单');
insert into sys_menu values('114',  '表单构建',       '3',   '1', 'build',      'tool/build/index',                  '', 1, 0, 'C', '0', '0', 'tool:build:list',         'build',         'admin', sysdate(), '', null, '表单构建菜单');
insert into sys_menu values('115',  '代码生成',       '3',   '2', 'gen',        'tool/gen/index',                    '', 1, 0, 'C', '0', '0', 'tool:gen:list',           'code',          'admin', sysdate(), '', null, '代码生成菜单');
insert into sys_menu values('116',  '系统接口',       '3',   '3', 'http://localhost:8080/swagger-ui/index.html', '', '', 0, 0, 'C', '0', '0', 'tool:swagger:list',       'swagger',       'admin', sysdate(), '', null, '系统接口菜单');
-- 三级菜单
insert into sys_menu values('500',  '操作日志', '108', '1', 'operlog',    'system/operlog/index',    '', 1, 0, 'C', '0', '0', 'system:operlog:list',    'form',          'admin', sysdate(), '', null, '操作日志菜单');
insert into sys_menu values('501',  '登录日志', '108', '2', 'logininfor', 'system/logininfor/index', '', 1, 0, 'C', '0', '0', 'system:logininfor:list', 'logininfor',    'admin', sysdate(), '', null, '登录日志菜单');
-- 用户管理按钮
insert into sys_menu values('1001', '用户查询', '100', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1002', '用户新增', '100', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1003', '用户修改', '100', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1004', '用户删除', '100', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1005', '用户导出', '100', '5',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:export',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1006', '用户导入', '100', '6',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:import',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1007', '重置密码', '100', '7',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd',       '#', 'admin', sysdate(), '', null, '');
-- 角色管理按钮
insert into sys_menu values('1008', '角色查询', '101', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1009', '角色新增', '101', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1010', '角色修改', '101', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1011', '角色删除', '101', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1012', '角色导出', '101', '5',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:export',         '#', 'admin', sysdate(), '', null, '');
-- 菜单管理按钮
insert into sys_menu values('1013', '菜单查询', '102', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1014', '菜单新增', '102', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1015', '菜单修改', '102', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1016', '菜单删除', '102', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove',         '#', 'admin', sysdate(), '', null, '');
-- 部门管理按钮
insert into sys_menu values('1017', '部门查询', '103', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1018', '部门新增', '103', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1019', '部门修改', '103', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1020', '部门删除', '103', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove',         '#', 'admin', sysdate(), '', null, '');
-- 岗位管理按钮
insert into sys_menu values('1021', '岗位查询', '104', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1022', '岗位新增', '104', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1023', '岗位修改', '104', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1024', '岗位删除', '104', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1025', '岗位导出', '104', '5',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:export',         '#', 'admin', sysdate(), '', null, '');
-- 字典管理按钮
insert into sys_menu values('1026', '字典查询', '105', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1027', '字典新增', '105', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1028', '字典修改', '105', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1029', '字典删除', '105', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1030', '字典导出', '105', '5', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export',         '#', 'admin', sysdate(), '', null, '');
-- 参数设置按钮
insert into sys_menu values('1031', '参数查询', '106', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query',        '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1032', '参数新增', '106', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1033', '参数修改', '106', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1034', '参数删除', '106', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1035', '参数导出', '106', '5', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export',       '#', 'admin', sysdate(), '', null, '');
-- 通知公告按钮
insert into sys_menu values('1036', '公告查询', '107', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query',        '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1037', '公告新增', '107', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1038', '公告修改', '107', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1039', '公告删除', '107', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove',       '#', 'admin', sysdate(), '', null, '');
-- 操作日志按钮
insert into sys_menu values('1040', '操作查询', '500', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:operlog:query',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1041', '操作删除', '500', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:operlog:remove',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1042', '日志导出', '500', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:operlog:export',      '#', 'admin', sysdate(), '', null, '');
-- 登录日志按钮
insert into sys_menu values('1043', '登录查询', '501', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:query',    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1044', '登录删除', '501', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:remove',   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1045', '日志导出', '501', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:export',   '#', 'admin', sysdate(), '', null, '');
-- 在线用户按钮
insert into sys_menu values('1046', '在线查询', '109', '1', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1047', '批量强退', '109', '2', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1048', '单条强退', '109', '3', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', sysdate(), '', null, '');
-- 定时任务按钮
insert into sys_menu values('1049', '任务查询', '110', '1', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1050', '任务新增', '110', '2', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1051', '任务修改', '110', '3', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1052', '任务删除', '110', '4', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1053', '状态修改', '110', '5', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus',   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1054', '任务导出', '110', '7', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export',         '#', 'admin', sysdate(), '', null, '');
-- 代码生成按钮
insert into sys_menu values('1055', '生成查询', '115', '1', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1056', '生成修改', '115', '2', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit',              '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1057', '生成删除', '115', '3', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1058', '导入代码', '115', '2', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1059', '预览代码', '115', '4', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1060', '生成代码', '115', '5', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code',              '#', 'admin', sysdate(), '', null, '');

INSERT INTO `sys_menu` VALUES (1061, '文章资讯', 3, 1, 'article', 'news/article/index', NULL, 1, 0, 'C', '0', '0', 'news:article:list', '#', 'admin', '2022-10-18 22:05:42', '', NULL, '文章资讯菜单');
INSERT INTO `sys_menu` VALUES (1062, '文章资讯查询', 1061, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'news:article:query', '#', 'admin', '2022-10-18 22:05:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1063, '文章资讯新增', 1061, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'news:article:add', '#', 'admin', '2022-10-18 22:05:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1064, '文章资讯修改', 1061, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'news:article:edit', '#', 'admin', '2022-10-18 22:05:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1065, '文章资讯删除', 1061, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'news:article:remove', '#', 'admin', '2022-10-18 22:05:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1066, '文章资讯导出', 1061, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'news:article:export', '#', 'admin', '2022-10-18 22:05:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1067, '我的首页', 3, 1, 'pageone', 'news/pageone/index', NULL, 1, 0, 'C', '0', '0', 'news:article:list', '#', 'admin', '2022-10-19 00:13:02', '', NULL, '首页菜单');
INSERT INTO `sys_menu` VALUES (1074, '房屋信息', 3, 1, 'house', 'news/house/index', NULL, 1, 0, 'C', '0', '0', 'news:house:list', '#', 'admin', '2022-10-31 19:41:02', '', NULL, '房屋信息菜单');
INSERT INTO `sys_menu` VALUES (1075, '房屋信息查询', 1074, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'news:house:query', '#', 'admin', '2022-10-31 19:41:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1076, '房屋信息新增', 1074, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'news:house:add', '#', 'admin', '2022-10-31 19:41:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1077, '房屋信息修改', 1074, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'news:house:edit', '#', 'admin', '2022-10-31 19:41:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1078, '房屋信息删除', 1074, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'news:house:remove', '#', 'admin', '2022-10-31 19:41:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1079, '房屋信息导出', 1074, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'news:house:export', '#', 'admin', '2022-10-31 19:41:02', '', NULL, '');


-- ----------------------------
-- 6、用户和角色关联表  用户N-1角色
-- ----------------------------
drop table if exists sys_user_role;
create table sys_user_role (
  user_id   bigint(20) not null comment '用户ID',
  role_id   bigint(20) not null comment '角色ID',
  primary key(user_id, role_id)
) engine=innodb comment = '用户和角色关联表';

-- ----------------------------
-- 初始化-用户和角色关联表数据
-- ----------------------------
insert into sys_user_role values ('1', '1');
insert into sys_user_role values ('2', '2');


-- ----------------------------
-- 7、角色和菜单关联表  角色1-N菜单
-- ----------------------------
drop table if exists sys_role_menu;
create table sys_role_menu (
  role_id   bigint(20) not null comment '角色ID',
  menu_id   bigint(20) not null comment '菜单ID',
  primary key(role_id, menu_id)
) engine=innodb comment = '角色和菜单关联表';

-- ----------------------------
-- 初始化-角色和菜单关联表数据
-- ----------------------------
insert into sys_role_menu values ('2', '1');
insert into sys_role_menu values ('2', '2');
insert into sys_role_menu values ('2', '3');
insert into sys_role_menu values ('2', '4');
insert into sys_role_menu values ('2', '100');
insert into sys_role_menu values ('2', '101');
insert into sys_role_menu values ('2', '102');
insert into sys_role_menu values ('2', '103');
insert into sys_role_menu values ('2', '104');
insert into sys_role_menu values ('2', '105');
insert into sys_role_menu values ('2', '106');
insert into sys_role_menu values ('2', '107');
insert into sys_role_menu values ('2', '108');
insert into sys_role_menu values ('2', '109');
insert into sys_role_menu values ('2', '110');
insert into sys_role_menu values ('2', '111');
insert into sys_role_menu values ('2', '112');
insert into sys_role_menu values ('2', '113');
insert into sys_role_menu values ('2', '114');
insert into sys_role_menu values ('2', '115');
insert into sys_role_menu values ('2', '116');
insert into sys_role_menu values ('2', '500');
insert into sys_role_menu values ('2', '501');
insert into sys_role_menu values ('2', '1000');
insert into sys_role_menu values ('2', '1001');
insert into sys_role_menu values ('2', '1002');
insert into sys_role_menu values ('2', '1003');
insert into sys_role_menu values ('2', '1004');
insert into sys_role_menu values ('2', '1005');
insert into sys_role_menu values ('2', '1006');
insert into sys_role_menu values ('2', '1007');
insert into sys_role_menu values ('2', '1008');
insert into sys_role_menu values ('2', '1009');
insert into sys_role_menu values ('2', '1010');
insert into sys_role_menu values ('2', '1011');
insert into sys_role_menu values ('2', '1012');
insert into sys_role_menu values ('2', '1013');
insert into sys_role_menu values ('2', '1014');
insert into sys_role_menu values ('2', '1015');
insert into sys_role_menu values ('2', '1016');
insert into sys_role_menu values ('2', '1017');
insert into sys_role_menu values ('2', '1018');
insert into sys_role_menu values ('2', '1019');
insert into sys_role_menu values ('2', '1020');
insert into sys_role_menu values ('2', '1021');
insert into sys_role_menu values ('2', '1022');
insert into sys_role_menu values ('2', '1023');
insert into sys_role_menu values ('2', '1024');
insert into sys_role_menu values ('2', '1025');
insert into sys_role_menu values ('2', '1026');
insert into sys_role_menu values ('2', '1027');
insert into sys_role_menu values ('2', '1028');
insert into sys_role_menu values ('2', '1029');
insert into sys_role_menu values ('2', '1030');
insert into sys_role_menu values ('2', '1031');
insert into sys_role_menu values ('2', '1032');
insert into sys_role_menu values ('2', '1033');
insert into sys_role_menu values ('2', '1034');
insert into sys_role_menu values ('2', '1035');
insert into sys_role_menu values ('2', '1036');
insert into sys_role_menu values ('2', '1037');
insert into sys_role_menu values ('2', '1038');
insert into sys_role_menu values ('2', '1039');
insert into sys_role_menu values ('2', '1040');
insert into sys_role_menu values ('2', '1041');
insert into sys_role_menu values ('2', '1042');
insert into sys_role_menu values ('2', '1043');
insert into sys_role_menu values ('2', '1044');
insert into sys_role_menu values ('2', '1045');
insert into sys_role_menu values ('2', '1046');
insert into sys_role_menu values ('2', '1047');
insert into sys_role_menu values ('2', '1048');
insert into sys_role_menu values ('2', '1049');
insert into sys_role_menu values ('2', '1050');
insert into sys_role_menu values ('2', '1051');
insert into sys_role_menu values ('2', '1052');
insert into sys_role_menu values ('2', '1053');
insert into sys_role_menu values ('2', '1054');
insert into sys_role_menu values ('2', '1055');
insert into sys_role_menu values ('2', '1056');
insert into sys_role_menu values ('2', '1057');
insert into sys_role_menu values ('2', '1058');
insert into sys_role_menu values ('2', '1059');
insert into sys_role_menu values ('2', '1060');

-- ----------------------------
-- 8、角色和部门关联表  角色1-N部门
-- ----------------------------
drop table if exists sys_role_dept;
create table sys_role_dept (
  role_id   bigint(20) not null comment '角色ID',
  dept_id   bigint(20) not null comment '部门ID',
  primary key(role_id, dept_id)
) engine=innodb comment = '角色和部门关联表';

-- ----------------------------
-- 初始化-角色和部门关联表数据
-- ----------------------------
insert into sys_role_dept values ('2', '100');
insert into sys_role_dept values ('2', '101');
insert into sys_role_dept values ('2', '105');


-- ----------------------------
-- 9、用户与岗位关联表  用户1-N岗位
-- ----------------------------
drop table if exists sys_user_post;
create table sys_user_post
(
  user_id   bigint(20) not null comment '用户ID',
  post_id   bigint(20) not null comment '岗位ID',
  primary key (user_id, post_id)
) engine=innodb comment = '用户与岗位关联表';

-- ----------------------------
-- 初始化-用户与岗位关联表数据
-- ----------------------------
insert into sys_user_post values ('1', '1');
insert into sys_user_post values ('2', '2');


-- ----------------------------
-- 10、操作日志记录
-- ----------------------------
drop table if exists sys_oper_log;
create table sys_oper_log (
  oper_id           bigint(20)      not null auto_increment    comment '日志主键',
  title             varchar(50)     default ''                 comment '模块标题',
  business_type     int(2)          default 0                  comment '业务类型（0其它 1新增 2修改 3删除）',
  method            varchar(100)    default ''                 comment '方法名称',
  request_method    varchar(10)     default ''                 comment '请求方式',
  operator_type     int(1)          default 0                  comment '操作类别（0其它 1后台用户 2手机端用户）',
  oper_name         varchar(50)     default ''                 comment '操作人员',
  dept_name         varchar(50)     default ''                 comment '部门名称',
  oper_url          varchar(255)    default ''                 comment '请求URL',
  oper_ip           varchar(128)    default ''                 comment '主机地址',
  oper_location     varchar(255)    default ''                 comment '操作地点',
  oper_param        varchar(2000)   default ''                 comment '请求参数',
  json_result       varchar(2000)   default ''                 comment '返回参数',
  status            int(1)          default 0                  comment '操作状态（0正常 1异常）',
  error_msg         varchar(2000)   default ''                 comment '错误消息',
  oper_time         datetime                                   comment '操作时间',
  primary key (oper_id)
) engine=innodb auto_increment=100 comment = '操作日志记录';


-- ----------------------------
-- 11、字典类型表
-- ----------------------------
drop table if exists sys_dict_type;
create table sys_dict_type
(
  dict_id          bigint(20)      not null auto_increment    comment '字典主键',
  dict_name        varchar(100)    default ''                 comment '字典名称',
  dict_type        varchar(100)    default ''                 comment '字典类型',
  status           char(1)         default '0'                comment '状态（0正常 1停用）',
  create_by        varchar(64)     default ''                 comment '创建者',
  create_time      datetime                                   comment '创建时间',
  update_by        varchar(64)     default ''                 comment '更新者',
  update_time      datetime                                   comment '更新时间',
  remark           varchar(500)    default null               comment '备注',
  primary key (dict_id),
  unique (dict_type)
) engine=innodb auto_increment=100 comment = '字典类型表';

insert into sys_dict_type values(1,  '用户性别', 'sys_user_sex',        '0', 'admin', sysdate(), '', null, '用户性别列表');
insert into sys_dict_type values(2,  '菜单状态', 'sys_show_hide',       '0', 'admin', sysdate(), '', null, '菜单状态列表');
insert into sys_dict_type values(3,  '系统开关', 'sys_normal_disable',  '0', 'admin', sysdate(), '', null, '系统开关列表');
insert into sys_dict_type values(4,  '任务状态', 'sys_job_status',      '0', 'admin', sysdate(), '', null, '任务状态列表');
insert into sys_dict_type values(5,  '任务分组', 'sys_job_group',       '0', 'admin', sysdate(), '', null, '任务分组列表');
insert into sys_dict_type values(6,  '系统是否', 'sys_yes_no',          '0', 'admin', sysdate(), '', null, '系统是否列表');
insert into sys_dict_type values(7,  '通知类型', 'sys_notice_type',     '0', 'admin', sysdate(), '', null, '通知类型列表');
insert into sys_dict_type values(8,  '通知状态', 'sys_notice_status',   '0', 'admin', sysdate(), '', null, '通知状态列表');
insert into sys_dict_type values(9,  '操作类型', 'sys_oper_type',       '0', 'admin', sysdate(), '', null, '操作类型列表');
insert into sys_dict_type values(10, '系统状态', 'sys_common_status',   '0', 'admin', sysdate(), '', null, '登录状态列表');

-- ----------------------------
-- 12、字典数据表
-- ----------------------------
drop table if exists sys_dict_data;
create table sys_dict_data
(
  dict_code        bigint(20)      not null auto_increment    comment '字典编码',
  dict_sort        int(4)          default 0                  comment '字典排序',
  dict_label       varchar(100)    default ''                 comment '字典标签',
  dict_value       varchar(100)    default ''                 comment '字典键值',
  dict_type        varchar(100)    default ''                 comment '字典类型',
  css_class        varchar(100)    default null               comment '样式属性（其他样式扩展）',
  list_class       varchar(100)    default null               comment '表格回显样式',
  is_default       char(1)         default 'N'                comment '是否默认（Y是 N否）',
  status           char(1)         default '0'                comment '状态（0正常 1停用）',
  create_by        varchar(64)     default ''                 comment '创建者',
  create_time      datetime                                   comment '创建时间',
  update_by        varchar(64)     default ''                 comment '更新者',
  update_time      datetime                                   comment '更新时间',
  remark           varchar(500)    default null               comment '备注',
  primary key (dict_code)
) engine=innodb auto_increment=100 comment = '字典数据表';

insert into sys_dict_data values(1,  1,  '男',       '0',       'sys_user_sex',        '',   '',        'Y', '0', 'admin', sysdate(), '', null, '性别男');
insert into sys_dict_data values(2,  2,  '女',       '1',       'sys_user_sex',        '',   '',        'N', '0', 'admin', sysdate(), '', null, '性别女');
insert into sys_dict_data values(3,  3,  '未知',     '2',       'sys_user_sex',        '',   '',        'N', '0', 'admin', sysdate(), '', null, '性别未知');
insert into sys_dict_data values(4,  1,  '显示',     '0',       'sys_show_hide',       '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '显示菜单');
insert into sys_dict_data values(5,  2,  '隐藏',     '1',       'sys_show_hide',       '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '隐藏菜单');
insert into sys_dict_data values(6,  1,  '正常',     '0',       'sys_normal_disable',  '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(7,  2,  '停用',     '1',       'sys_normal_disable',  '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '停用状态');
insert into sys_dict_data values(8,  1,  '正常',     '0',       'sys_job_status',      '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(9,  2,  '暂停',     '1',       'sys_job_status',      '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '停用状态');
insert into sys_dict_data values(10, 1,  '默认',     'DEFAULT', 'sys_job_group',       '',   '',        'Y', '0', 'admin', sysdate(), '', null, '默认分组');
insert into sys_dict_data values(11, 2,  '系统',     'SYSTEM',  'sys_job_group',       '',   '',        'N', '0', 'admin', sysdate(), '', null, '系统分组');
insert into sys_dict_data values(12, 1,  '是',       'Y',       'sys_yes_no',          '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '系统默认是');
insert into sys_dict_data values(13, 2,  '否',       'N',       'sys_yes_no',          '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '系统默认否');
insert into sys_dict_data values(14, 1,  '通知',     '1',       'sys_notice_type',     '',   'warning', 'Y', '0', 'admin', sysdate(), '', null, '通知');
insert into sys_dict_data values(15, 2,  '公告',     '2',       'sys_notice_type',     '',   'success', 'N', '0', 'admin', sysdate(), '', null, '公告');
insert into sys_dict_data values(16, 1,  '正常',     '0',       'sys_notice_status',   '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(17, 2,  '关闭',     '1',       'sys_notice_status',   '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '关闭状态');
insert into sys_dict_data values(18, 1,  '新增',     '1',       'sys_oper_type',       '',   'info',    'N', '0', 'admin', sysdate(), '', null, '新增操作');
insert into sys_dict_data values(19, 2,  '修改',     '2',       'sys_oper_type',       '',   'info',    'N', '0', 'admin', sysdate(), '', null, '修改操作');
insert into sys_dict_data values(20, 3,  '删除',     '3',       'sys_oper_type',       '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '删除操作');
insert into sys_dict_data values(21, 4,  '授权',     '4',       'sys_oper_type',       '',   'primary', 'N', '0', 'admin', sysdate(), '', null, '授权操作');
insert into sys_dict_data values(22, 5,  '导出',     '5',       'sys_oper_type',       '',   'warning', 'N', '0', 'admin', sysdate(), '', null, '导出操作');
insert into sys_dict_data values(23, 6,  '导入',     '6',       'sys_oper_type',       '',   'warning', 'N', '0', 'admin', sysdate(), '', null, '导入操作');
insert into sys_dict_data values(24, 7,  '强退',     '7',       'sys_oper_type',       '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '强退操作');
insert into sys_dict_data values(25, 8,  '生成代码', '8',       'sys_oper_type',       '',   'warning', 'N', '0', 'admin', sysdate(), '', null, '生成操作');
insert into sys_dict_data values(26, 9,  '清空数据', '9',       'sys_oper_type',       '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '清空操作');
insert into sys_dict_data values(27, 1,  '成功',     '0',       'sys_common_status',   '',   'primary', 'N', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(28, 2,  '失败',     '1',       'sys_common_status',   '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '停用状态');


-- ----------------------------
-- 13、参数配置表
-- ----------------------------
drop table if exists sys_config;
create table sys_config (
  config_id         int(5)          not null auto_increment    comment '参数主键',
  config_name       varchar(100)    default ''                 comment '参数名称',
  config_key        varchar(100)    default ''                 comment '参数键名',
  config_value      varchar(500)    default ''                 comment '参数键值',
  config_type       char(1)         default 'N'                comment '系统内置（Y是 N否）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (config_id)
) engine=innodb auto_increment=100 comment = '参数配置表';

insert into sys_config values(1, '主框架页-默认皮肤样式名称',     'sys.index.skinName',       'skin-blue',     'Y', 'admin', sysdate(), '', null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow' );
insert into sys_config values(2, '用户管理-账号初始密码',         'sys.user.initPassword',    '123456',        'Y', 'admin', sysdate(), '', null, '初始化密码 123456' );
insert into sys_config values(3, '主框架页-侧边栏主题',           'sys.index.sideTheme',      'theme-dark',    'Y', 'admin', sysdate(), '', null, '深色主题theme-dark，浅色主题theme-light' );
insert into sys_config values(4, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false',         'Y', 'admin', sysdate(), '', null, '是否开启注册用户功能（true开启，false关闭）');


-- ----------------------------
-- 14、系统访问记录
-- ----------------------------
drop table if exists sys_logininfor;
create table sys_logininfor (
  info_id        bigint(20)     not null auto_increment   comment '访问ID',
  user_name      varchar(50)    default ''                comment '用户账号',
  ipaddr         varchar(128)   default ''                comment '登录IP地址',
  status         char(1)        default '0'               comment '登录状态（0成功 1失败）',
  msg            varchar(255)   default ''                comment '提示信息',
  access_time    datetime                                 comment '访问时间',
  primary key (info_id)
) engine=innodb auto_increment=100 comment = '系统访问记录';


-- ----------------------------
-- 15、定时任务调度表
-- ----------------------------
drop table if exists sys_job;
create table sys_job (
  job_id              bigint(20)    not null auto_increment    comment '任务ID',
  job_name            varchar(64)   default ''                 comment '任务名称',
  job_group           varchar(64)   default 'DEFAULT'          comment '任务组名',
  invoke_target       varchar(500)  not null                   comment '调用目标字符串',
  cron_expression     varchar(255)  default ''                 comment 'cron执行表达式',
  misfire_policy      varchar(20)   default '3'                comment '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  concurrent          char(1)       default '1'                comment '是否并发执行（0允许 1禁止）',
  status              char(1)       default '0'                comment '状态（0正常 1暂停）',
  create_by           varchar(64)   default ''                 comment '创建者',
  create_time         datetime                                 comment '创建时间',
  update_by           varchar(64)   default ''                 comment '更新者',
  update_time         datetime                                 comment '更新时间',
  remark              varchar(500)  default ''                 comment '备注信息',
  primary key (job_id, job_name, job_group)
) engine=innodb auto_increment=100 comment = '定时任务调度表';

insert into sys_job values(1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams',        '0/10 * * * * ?', '3', '1', '1', 'admin', sysdate(), '', null, '');
insert into sys_job values(2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')',  '0/15 * * * * ?', '3', '1', '1', 'admin', sysdate(), '', null, '');
insert into sys_job values(3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)',  '0/20 * * * * ?', '3', '1', '1', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 16、定时任务调度日志表
-- ----------------------------
drop table if exists sys_job_log;
create table sys_job_log (
  job_log_id          bigint(20)     not null auto_increment    comment '任务日志ID',
  job_name            varchar(64)    not null                   comment '任务名称',
  job_group           varchar(64)    not null                   comment '任务组名',
  invoke_target       varchar(500)   not null                   comment '调用目标字符串',
  job_message         varchar(500)                              comment '日志信息',
  status              char(1)        default '0'                comment '执行状态（0正常 1失败）',
  exception_info      varchar(2000)  default ''                 comment '异常信息',
  create_time         datetime                                  comment '创建时间',
  primary key (job_log_id)
) engine=innodb comment = '定时任务调度日志表';


-- ----------------------------
-- 17、通知公告表
-- ----------------------------
drop table if exists sys_notice;
create table sys_notice (
  notice_id         int(4)          not null auto_increment    comment '公告ID',
  notice_title      varchar(50)     not null                   comment '公告标题',
  notice_type       char(1)         not null                   comment '公告类型（1通知 2公告）',
  notice_content    longblob        default null               comment '公告内容',
  status            char(1)         default '0'                comment '公告状态（0正常 1关闭）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(255)    default null               comment '备注',
  primary key (notice_id)
) engine=innodb auto_increment=10 comment = '通知公告表';

-- ----------------------------
-- 初始化-公告信息表数据
-- ----------------------------
insert into sys_notice values('1', '温馨提醒：2018-07-01 若依新版本发布啦', '2', '新版本内容', '0', 'admin', sysdate(), '', null, '管理员');
insert into sys_notice values('2', '维护通知：2018-07-01 若依系统凌晨维护', '1', '维护内容',   '0', 'admin', sysdate(), '', null, '管理员');


-- ----------------------------
-- 18、代码生成业务表
-- ----------------------------
drop table if exists gen_table;
create table gen_table (
  table_id          bigint(20)      not null auto_increment    comment '编号',
  table_name        varchar(200)    default ''                 comment '表名称',
  table_comment     varchar(500)    default ''                 comment '表描述',
  sub_table_name    varchar(64)     default null               comment '关联子表的表名',
  sub_table_fk_name varchar(64)     default null               comment '子表关联的外键名',
  class_name        varchar(100)    default ''                 comment '实体类名称',
  tpl_category      varchar(200)    default 'crud'             comment '使用的模板（crud单表操作 tree树表操作）',
  package_name      varchar(100)                               comment '生成包路径',
  module_name       varchar(30)                                comment '生成模块名',
  business_name     varchar(30)                                comment '生成业务名',
  function_name     varchar(50)                                comment '生成功能名',
  function_author   varchar(50)                                comment '生成功能作者',
  gen_type          char(1)         default '0'                comment '生成代码方式（0zip压缩包 1自定义路径）',
  gen_path          varchar(200)    default '/'                comment '生成路径（不填默认项目路径）',
  options           varchar(1000)                              comment '其它生成选项',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time 	    datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (table_id)
) engine=innodb auto_increment=1 comment = '代码生成业务表';


-- ----------------------------
-- 19、代码生成业务表字段
-- ----------------------------
drop table if exists gen_table_column;
create table gen_table_column (
  column_id         bigint(20)      not null auto_increment    comment '编号',
  table_id          varchar(64)                                comment '归属表编号',
  column_name       varchar(200)                               comment '列名称',
  column_comment    varchar(500)                               comment '列描述',
  column_type       varchar(100)                               comment '列类型',
  java_type         varchar(500)                               comment 'JAVA类型',
  java_field        varchar(200)                               comment 'JAVA字段名',
  is_pk             char(1)                                    comment '是否主键（1是）',
  is_increment      char(1)                                    comment '是否自增（1是）',
  is_required       char(1)                                    comment '是否必填（1是）',
  is_insert         char(1)                                    comment '是否为插入字段（1是）',
  is_edit           char(1)                                    comment '是否编辑字段（1是）',
  is_list           char(1)                                    comment '是否列表字段（1是）',
  is_query          char(1)                                    comment '是否查询字段（1是）',
  query_type        varchar(200)    default 'EQ'               comment '查询方式（等于、不等于、大于、小于、范围）',
  html_type         varchar(200)                               comment '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  dict_type         varchar(200)    default ''                 comment '字典类型',
  sort              int                                        comment '排序',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time 	    datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  primary key (column_id)
) engine=innodb auto_increment=1 comment = '代码生成业务表字段';



-- ----------------------------
-- Table structure for chu_article
-- ----------------------------
DROP TABLE IF EXISTS `chu_article`;
CREATE TABLE `chu_article`  (
                                `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章标题',
                                `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章内容，长度不超过9999，需要在前后端判断',
                                `category_id` int(2) NOT NULL COMMENT '文章所属分类id',
                                `article_type` int(1) NOT NULL COMMENT '文章类型，1：图文（1张封面），2：纯文字',
                                `article_cover` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文章封面图，article_type=1 的时候展示',
                                `is_appoint` int(1) NOT NULL COMMENT '是否是预约定时发布的文章，1：预约（定时）发布，0：即时发布    在预约时间到点的时候，把1改为0，则发布',
                                `article_status` int(1) NOT NULL COMMENT '文章状态，1：审核中（用户已提交），2：机审结束，等待人工审核，3：审核通过（已发布），4：审核未通过；5：文章撤回（已发布的情况下才能撤回和删除）',
                                `publish_user_id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发布者用户id',
                                `publish_time` datetime(0) NOT NULL COMMENT '文章发布时间（也是预约发布的时间）',
                                `read_counts` int(11) NOT NULL DEFAULT 0 COMMENT '用户累计点击阅读数（喜欢数）（点赞） - 放redis',
                                `comment_counts` int(11) NOT NULL DEFAULT 0 COMMENT '文章评论总数。评论防刷，距离上次评论需要间隔时间控制几秒',
                                `mongo_file_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                `is_delete` int(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除状态，非物理删除，1：删除，0：未删除',
                                `create_time` datetime(0) NOT NULL COMMENT '文章的创建时间',
                                `update_time` datetime(0) NOT NULL COMMENT '文章的修改时间',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章资讯表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chu_article
-- ----------------------------
INSERT INTO `chu_article` VALUES ('2006116Y18X1Z7R4', '<b style=\"color:red\">非HTTP状态下</b>开启web视频的临时方案', '<strong>引子</strong>新版本的chrome在调用摄像头的时候，会有安全警告，所以调用摄像头的js方法就无法使用了，如下：<img src=\"\" />意思是保证安全，你要在HTTPS的情况下，才能调用浏览器摄像头。但是我们平时开发的时候，本地环境往往没有HTTPS，如何解决呢？<strong>禁用浏览器默认安全模式</strong>复制如下命令到浏览器的地址栏：chrome://flags/#unsafely-treat-insecure-origin-as-secure如下图，找到黄色部分，然后enabled开启，并且把你自己本地模拟的域名放进去，如此就增加了白名单。设置好需要重启浏览器。<img src=\"\" />回到浏览器测试视频，结果OK，如下：<img src=\"\" />电脑上的绿色点表示摄像头打开。<img src=\"\" />', 2, 2, '', 0, 4, 'ed1924', '2020-06-11 09:42:37', 0, 0, NULL, 0, '2020-06-11 09:42:37', '2022-10-18 14:47:47');
INSERT INTO `chu_article` VALUES ('2006116Z3MAP8SW0', 'GEO地理位置直播视频与文字版记录', '<p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><br class=\"Apple-interchange-newline\">视频已经由慕课网上传至B站，免费高清，地址为：<a href=\"https://www.bilibili.com/video/BV1Lz411b7cN%E3%80%82%E4%BB%A5%E4%B8%8B%E9%83%BD%E6%98%AF%E6%96%87%E5%AD%97%E7%89%88%E7%AC%94%E8%AE%B0%E3%80%82\" style=\"color: rgb(70, 70, 70);\">https://www.bilibili.com/video/BV1Lz411b7cN。以下都是文字版笔记。</a></p><h2 id=\"toc_1\" style=\"font-size: 21px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\">《Elasticsearch极速入门与基于百度地图的geo地理位置搜索》</h2><h3 id=\"toc_2\" style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\">1. es介绍</h3><ul style=\"list-style: none; margin-right: 0px; margin-bottom: 0px; margin-left: 30px; padding: 0px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><li style=\"list-style-type: disc;\"><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\"><code>互动</code>：什么是搜索：</p><ul style=\"list-style: none; margin-right: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: circle;\">百度谷歌，都是搜索引擎。</li><li style=\"list-style-type: circle;\">垂直搜索，站内，比如淘宝京东站内搜索商品。</li></ul></li><li style=\"list-style-type: disc;\"><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">什么是ES：<br>Elasticsearch 是一个分布式可扩展的实时搜索和分析引擎，底层基于lucene。</p><ul style=\"list-style: none; margin-right: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: circle;\">可以存储文档，用于海量数据检索</li><li style=\"list-style-type: circle;\">可以近实时的分析数据</li><li style=\"list-style-type: circle;\">可扩展性（几百个节点甚至上千）相当强大。</li><li style=\"list-style-type: circle;\">结合ELK，实现日志收集<code>（架构师课程里有）</code></li><li style=\"list-style-type: circle;\">地理位置geo信息搜索与监控和分析（常用于社交平台，物流快递，地图等场景）</li></ul></li><li style=\"list-style-type: disc;\"><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\"><code>可以互动</code>：为什么要使用es</p><ul style=\"list-style: none; margin-right: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: circle;\"><code>如果用普通数据库，单表可以存多少数据比较合适？这个主要看自己自身业务，一般来说，1000万左右，但是6-700万的样子就可以开始逐步计划做数据库优化分库分表等</code>。普通搜索基于数据库，数据库单表存储能力有限，数据量越多，搜索性能越低下</li><li style=\"list-style-type: circle;\">数据库支持模糊搜索，全表扫描遍历（es基于倒排索引，根据词汇直接把对应的文档id搜索到然后把对应的数据查询出来），不支持高亮搜索<ul style=\"list-style: none; margin-right: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: circle;\">我在慕课网这个网站搜索<code>spring 短视频</code></li><li style=\"list-style-type: circle;\">词条：spring 短视频</li><li style=\"list-style-type: circle;\">数据库不支持分词搜索，es（搜索引擎）支持</li><li style=\"list-style-type: circle;\">db搜索不如专业的搜索引擎靠谱</li></ul></li></ul></li></ul><h3 id=\"toc_3\" style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\">简单聊一聊倒排索引</h3><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/04/03/15833935162304.jpg\" alt=\"-w760\" style=\"height: auto; max-width: 100%; margin: 10px;\"></p><h3 id=\"toc_4\" style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\">2. es的核心术语与数据结构</h3><ul style=\"list-style: none; margin-right: 0px; margin-bottom: 0px; margin-left: 30px; padding: 0px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><li style=\"list-style-type: disc;\">核心术语<ul style=\"list-style: none; margin-right: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: circle;\">ES --&gt; 数据库（1）</li><li style=\"list-style-type: circle;\">索引index --&gt; 表（2）</li><li style=\"list-style-type: circle;\">文档 document --&gt; 行（记录）（3）</li><li style=\"list-style-type: circle;\">字段 fields --&gt; 列（4）</li><li style=\"list-style-type: circle;\"><del>类型type</del>&nbsp;过期，也能作为表&nbsp;<img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/04/03/15830320950982.jpg\" alt=\"-w619\" style=\"height: auto; max-width: 100%;\"><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/04/03/15830321329817.jpg\" alt=\"-w385\" style=\"height: auto; max-width: 100%;\"></li></ul></li></ul><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/04/03/15830321681137.jpg\" alt=\"-w1276\" style=\"height: auto; max-width: 100%; margin: 10px;\"></p><ul style=\"list-style: none; margin-right: 0px; margin-bottom: 0px; margin-left: 30px; padding: 0px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><li style=\"list-style-type: disc;\">数据结构，数据库表记录，对应es：&nbsp;<img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/04/03/15830323628199.jpg\" alt=\"-w451\" style=\"height: auto; max-width: 100%;\"></li></ul><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><br></p><h3 id=\"toc_5\" style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\">3. es和head插件安装见慕课网手记</h3><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><a href=\"https://github.com/mobz/elasticsearch-head#running-with-built-in-server\" style=\"color: rgb(70, 70, 70);\">https://github.com/mobz/elasticsearch-head#running-with-built-in-server</a></p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><a href=\"https://www.imooc.com/article/286936\" style=\"color: rgb(70, 70, 70);\">https://www.imooc.com/article/286936</a><br>这个基于centos6，架构师课程基于centos7</p><h3 id=\"toc_6\" style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\">4. head插件，索引index创建与映射mappings创建</h3><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">索引名: friends<br><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/04/03/15830449480378.jpg\" alt=\"-w616\" style=\"height: auto; max-width: 100%; margin: 10px;\"></p><h3 id=\"toc_7\" style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\">分片与集群，健康度</h3><h6 id=\"toc_8\" style=\"font-size: 11px; font-weight: bold; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\">*简称（附）</h6><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">shard = primary shard（主分片）<br>replica = replica shard（副本分片）</p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">演示使用head来进行索引的创建</p><ul style=\"list-style: none; margin-right: 0px; margin-bottom: 0px; margin-left: 30px; padding: 0px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><li style=\"list-style-type: disc;\"><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">主分片（shard）：把索引库拆分为多份，分别放在不同的节点上，比如有3个节点，3个节点的所有数据内容加在一起是一个完整的索引库。分别保存到三个节点上，目的为了水平扩展，提高吞吐量。也可以做到故障转移。ES自动管理和组织分片, 并在必要的时候对分片数据进行再平衡分配, 所以用户基本上无需担心分片的相关处理细节</p></li><li style=\"list-style-type: disc;\"><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">副本分片（replica）：每个shard的备份。也可以称之为副本，ES默认为一个索引创建5个主分片, 并分别为其创建一个副本分片。意思就是说每个索引都由5个主分片（shard）形成，而每个主分片都相应的有一个备份（replica）。</p></li><li style=\"list-style-type: disc;\"><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">分片机制<br>每个索引可以被分片，就相当于吃披萨的时候被切了好几块，然后分给不同的人吃，如下图所示：<br><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/04/03/15760315077964.jpg\" alt=\"\" style=\"height: auto; max-width: 100%; margin: 10px;\"></p><ul style=\"list-style: none; margin-right: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: circle;\">索引my_doc只有一个主分片；</li><li style=\"list-style-type: circle;\">索引shop有3个主分片；</li><li style=\"list-style-type: circle;\">索引shop2有5个主分片。</li><li style=\"list-style-type: circle;\">每个主分片都包含索引的数据，由于目前是单机，所以副本分片是没有的，这个时候集群健康值显示为黄色。</li><li style=\"list-style-type: circle;\">副本分片是主分片的备份，主挂了，备份还是可以访问，这就需要用到集群了。</li><li style=\"list-style-type: circle;\">同一个分片的主与副本是不会放在同一个服务器里的，因为一旦宕机，这个分片就没了</li><li style=\"list-style-type: circle;\">我不知道大家有没有玩过nas，这个数据存储有点像raid机制。</li></ul></li></ul><h3 id=\"toc_9\" style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\">es 健康度</h3><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">不同的颜色表示es不同的健康程度</p><ol style=\"padding-left: 40px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><li style=\"list-style-type: decimal;\">绿色：集群健康，所有主分片和副本分片都是可用状态。</li><li style=\"list-style-type: decimal;\">黄色：亚健康，所有的主分片可用，但是副本分片部分不可用。</li><li style=\"list-style-type: decimal;\">红色：不健康，主分片部分不可用。</li></ol>', 3, 1, 'http://127.0.0.1:65535/huoyan/c647b9c91f234ad6a13a1623ca7b7021.png', 0, 3, 'ed1924', '2020-06-11 09:45:52', 0, 0, NULL, 0, '2020-06-11 09:45:52', '2020-06-11 09:45:52');
INSERT INTO `chu_article` VALUES ('2006116ZH9536PBC', '[涨姿势]Chrome 谷歌浏览器原生截长图命令', '<h3 id=\"toc_0\" style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\">截长图技能GET</h3><ol style=\"padding-left: 40px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><li style=\"list-style-type: decimal;\"><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">按<code>F12</code>，拉出控制台<br><img src=\"https://img2020.cnblogs.com/blog/841496/202003/841496-20200326150153376-754832260.jpg\" alt=\"\" style=\"height: auto; max-width: 100%; margin: 10px; width: 1869px;\"></p></li><li style=\"list-style-type: decimal;\"><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\"><code>commond</code>&nbsp;+&nbsp;<code>shift</code>&nbsp;+&nbsp;<code>p</code>，拉出命令行<br><img src=\"https://img2020.cnblogs.com/blog/841496/202003/841496-20200326150153319-1762053761.jpg\" alt=\"\" style=\"height: auto; max-width: 100%; margin: 10px; width: 827px;\"></p></li><li style=\"list-style-type: decimal;\"><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">然后搜索&nbsp;<code>CAP</code>&nbsp;开头的，就是CAP定里那个CAP，点击红框中的，就能截取长图了，这样有时候在和产品交流或者给老板图解的时候回很方便的哈<br><img src=\"https://img2020.cnblogs.com/blog/841496/202003/841496-20200326150153325-431421744.jpg\" alt=\"\" style=\"height: auto; max-width: 100%; margin: 10px; width: 750px;\"></p></li><li style=\"list-style-type: decimal;\"><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">最终效果</p></li></ol><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/03/26/blogitzixicomp47.png\" alt=\"\" width=\"3744\" height=\"12230\" style=\"height: auto; max-width: 100%; margin: 10px;\"></p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">&nbsp;</p>', 2, 1, 'http://127.0.0.1:65535/huoyan/c647b9c91f234ad6a13a1623ca7b7021.png', 0, 3, 'ed1924', '2020-06-11 09:47:14', 0, 0, NULL, 0, '2020-06-11 09:47:14', '2020-06-11 09:47:14');
INSERT INTO `chu_article` VALUES ('2006116ZRZXPP46W', '人人都要关注的分布式系统中的CAP理论', '<strong>分布式系统</strong>相信大家看过我的文章或者视频的，都应该知道什么是分布式系统，分布式系统就是一个系统由多个组成部分共同构成，用户的一个请求可能会经过多个不同的计算机节点之后，通过运算才会把结果响应给用户，那么这个请求所经过的不同的几个系统就是分布式系统。对于用户来讲，你是不是分布式系统，对他来讲是透明的。参考如下图：<img src=\"\" />图中就表示一个用户在经历下单过程会经过多个系统，他们是分布式的，共同组成一个整体。<strong>CAP 概念</strong>在分布式系统中，必定会遇到CAP，如下：C（Consistency）：一致性在分布式系统中，所有的计算机节点的数据在同一时刻都是相同的，数据都是一致的。不能因为分布式导致不同系统拿到的数据不一致。也就是说，用户在某一个节点写了数据，在其他节点获得该数据的值是最新的；如若是更新操作，那么所有用户看到的也是更新后的新的值，不论哪个节点，不论集群，不论主备，获得的数据都是相同的。如下图：共有5个节点，往A节点去写，那么其他节点的数据在同一时间都是相同的，其他用户读取的时候也都是相同的，数据的一致性很强。&nbsp;<img src=\"\" />A（Availability）：可用性保证你的系统可用，也就是说无论任何时候，系统都可以被用户访问到，用户可以获得正常的响应结果。比如做好集群啊，做好主备啊等等，这个就是高可用。如下图：集群是一个整体，不论是否有节点宕机，那么作为整体，他还是可以继续对外提供服务的，保证了系统的可用性。&nbsp;<img src=\"\" />P（Partition tolerance）：分区容错性在整个分布式系统中，我们都是部署在不同的节点上，或者是不同的机房甚至是不同的地域，部署的时候会有一些子网，某一些服务会部署在不同的子网，每个子网就是一个区，也就是网络分区，分区和分区之间的通信也有可能出现通信故障。某个节点或者网络或者地域（分区）出现问题，整体整个系统还是照样能够提供一致性和可用性的服务。也就是说部分系统故障不会影响整体。为什么会这样，主要是因为有程序bug，计算机硬件问题，网络问题，网线被挖断了等等造成的综合因素。所以呢，我们的诉求就是即使小部分出问题，也要保全整体。并且对于任何分布式系统来讲，都需要去考虑分区容错的问题。附，以腾讯云为例，图中就有两处不同分区，第一个是在上海这个地域有不同的区域，不同区域通信走公网，可能有通信故障。其次就是私有网络，也就是子网络，他可以创建很多个，自己去定义不同的网段ip。&nbsp;<img src=\"\" /><strong>CAP 无法同时满足</strong>如果从理论上来讲，以上三点C/A/P都应该满足吧，但是系统是人开发的，那肯定会或多或少有各种各样的问题。在分布式系统中同时满足这三点是不可能的。所以对于CAP来讲，只能满足其中两者，要么AP，要么CP，要么CA。如下图：<img src=\"\" />为什么会这样呢？我们举一个例子，来看一下CAP能不能同时满足，如下图：<img src=\"\" />上图中，ABCDE这5个节点都是分别部署在不同地域的机房的节点，假设现在我们的分区容错性P做的很好，保证不会出现网络方面的故障，这个时候我们来看一下一致性C和可用性A。现在有一个请求把数据写入到了A节点，随后用户的下一个请求要访问B节点，那么由于他们之间在不同的地域，数据同步需要有时间延迟，可能几百毫秒可能1-2秒。那么读请求要请求到一致的数据，就会被阻塞，阻塞的时候当前这个系统就不可用了，因为数据同步需要时间，所以此时的可用性A就无法满足，只能满足CP；那么再来看，假设要满足系统可用性，那么请求读到的数据，在节点同步的过程中就会是一个老的数据，数据就不能达到一致性C，所以这个时候就是AP。OK不？那么我们平时开发系统倒是在C和A之间取其一来搭配P的<strong>组合搭配</strong>那么 CP,AP,CA，这三种，哪个好呢？CP：满足一致性和分区容错的系统，性能不会很高，因为一致性是时时保持的。就比如说我提交一个订单，这个订单的数据要同步到各个系统，保证强一致性。那么这样用户请求大多都会被阻塞。需要耗时等待。redis，mongodb，hbase都是CP。（redis集群如果一个主节点挂了，那么slave成为master，他会有一个时间段导致不可用，A不满足）CA：满足一致性，满足可用性，一般来说都是以单体存在的集群架构，可扩展性不高。一般都是关系型数据库。AP：满足可用性和分区容错，那么这样就不是一致性了，往往会采用弱一致性，或者最终一致性。这也是通常用的最多的。 我们平时开发的系统就是以AP来展开工作的。对于我们平时开发的时候，分区容错P是一定要满足的，因为我们在部署的时候往往都都是多节点集群部署，设置异地互备，比如北京机房和机房都提供服务 ，所以，一定要容错。那么接下来我们要抉择一致性还是可用性呢？一般来说，往往我们在大家网站架构的时候，我们都会采用AP，主流的互联网公司也是如此，也就是数据的弱一致性，因为要保证系统的整体的高可用性以及容错性。啥叫弱一致性，比如我们经常看头条，头条的点赞数评论数或者微博粉丝数，具体的数值每个人浏览的时候可能不一样，这个其实无所谓的，这就是弱一致性。而像Redis啊MongoDB这样的中间件，是CP，也就是要保证数据的一致性，因为毕竟要为网站提供数据服务的，一致性必须满足。<strong>关于弱一致性</strong>其实现在的互联网环境里，很多项目都不会采用强一致性，因为很难做，而往往采用弱一致性，因为用户可以接受。比如双11或者618的时候，订单蹭蹭蹭的海量增加，我们只需要关注订单下单成功就行，具体多少订单，具体多少金额，我们不会去实时的统计计算的，因为没必要，会在高峰期过后逐步去统计，慢慢的实现一致性。那么这个就是目前主流的做法。但是一定要注意，数据层面的交互，关系型数据库，redis，mongodb等，他们肯定是强一致性，因为需要提供给你的网站数据服务。其实呢，我们在互联网环境里，往往会采用BASE理论，Base = Basically Available Soft-state Eventually-Consistent也就是达到基本可用软状态的最终一致性。它是比较平衡了CAP后得到的结论，这也是绝大多数互联网系统实践后的一个结果，他主要的核心思想就是忽略强一致性，使用弱一致性来达到最终一致。', 2, 1, 'http://127.0.0.1:65535/huoyan/c647b9c91f234ad6a13a1623ca7b7021.png', 0, 3, 'ed1924', '2020-06-11 09:47:50', 0, 0, NULL, 0, '2020-06-11 09:47:50', '2022-10-18 14:47:55');
INSERT INTO `chu_article` VALUES ('2006117034WDKR8H', '疫情风险下的项目管理与紧急预案策略', '<h3 style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\">引子</h3><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">相信大家都经历了疫情，在疫情之下，企业推迟复工，多地封城封路，各行各业都收到了冲击，甚至很多企业都因此倒闭，那么在企业项目管理中，有一点我们需要把控的就是风险管理，遇到风险如何更好的去调控，把损失降低。<br><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/03/16/15843495928674.jpg\" alt=\"-w677\" style=\"height: auto; max-width: 100%; margin: 10px;\"></p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">作为项目经理，应该如何面对，如何处理，如何协调资源，这些都是作为一名PM所需要去考虑的。</p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">当各个企业收到延长春节并延迟复工的消息以后，很多企业的项目都停止了，无法正常运作，尤其是一些传统企业收到的打击最大，比如线下物流，工厂等，而互联网企业相对好一些，项目都是在线的，而且大家可以在家远程办公就能整合到一起。（像我们的线下物流就完全停了，对接的工厂端也完全停了，工厂停了，环境监测系统也用不着了，一连串的连带效应）<br><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/03/16/15843496113076.jpg\" alt=\"-w638\" style=\"height: auto; max-width: 100%; margin: 10px;\"></p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">其实不论线上还是线下，项目进度肯定会延期，资源成本提升，这么一来很多项目都是亏本的，甚至还会因为合同而赔钱。那么这个时候项目就应该不能按照原计划进行，而需要适当进行变更，因为这是外部的不可抗力的因素。项目经理首先最要考虑的就是干系人管理，尤其是你的客户，管理客户，打好招呼，伺候好，维护好现有关系，那么项目上的后续事宜可以更好的开展。</p><h3 style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\"><a name=\"toc_1\" style=\"color: rgb(70, 70, 70);\"></a>认清风险</h3><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">一般项目初期在规划项目编撰合同的时候，相关的风险都应该去有所考虑以及有应对的预案，举几个最简单的例子：</p><ul style=\"list-style: none; margin-right: 0px; margin-bottom: 0px; margin-left: 30px; padding: 0px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><li style=\"list-style-type: disc;\">项目开展过程中人员流动或者疾病风险<ul style=\"list-style: none; margin-right: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: circle;\">招储备人员（外包公司叫做on bench）</li><li style=\"list-style-type: circle;\">激励政策，也就是TeamBuilding，团队融洽度，每月一次TB，每季度一次项目分红（我们是1500/人）</li></ul></li><li style=\"list-style-type: disc;\">服务器/硬件设备风险<ul style=\"list-style: none; margin-right: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: circle;\">自建机房要有容灾预案</li><li style=\"list-style-type: circle;\">云服务器要有多地主备</li></ul></li><li style=\"list-style-type: disc;\">成本风险<ul style=\"list-style: none; margin-right: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: circle;\">项目中涉及到的采购供应，成本管理需要做好，预算多少，会否超支，有没有可能因为投入越来越多而导致项目亏损，或者盈利不多，需要提前规划和准备。</li></ul></li><li style=\"list-style-type: disc;\">第三方风险<ul style=\"list-style: none; margin-right: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: circle;\">一个项目中可能会有20%-40%甚至更多的内容会外包给第三方公司，第三方有没有可能跑路？资质够不够？可以多找几家对比，或者额外找一家做备胎。又或者找两三家一起合作，不把鸡蛋放在一个篮子里。并且要定期验收，定期检查质量。&nbsp;<img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/03/16/15843496291926.jpg\" alt=\"-w911\" style=\"height: auto; max-width: 100%;\"></li></ul></li></ul><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">那么像这次疫情，不能归类为普通的风险，应该定性为<code>不可抗力风险</code>，因为你预测不到，而且有时候政府的一个突发性政策就会导致项目无法进行（比如我们的物流项目，和政策息息相关，所以我们很多高层每个季度都要去相关部门参加各种培训，甚至一些资质认证的考试。从而伪实时的跟着政策走）。所以应该纳入免责条款，所以合同里应该要写清，如果不写清除，会有后期的各种纠纷。就比如你公司被人炸了，被陨石击中了，这些都是外部的不可抗力，一般人还真遇不到。像N年前，有个哥们车子被陨石击中，保险公司不赔，为啥，因为这是不可抗力因素呀！<br><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/03/16/15843496433035.jpg\" alt=\"-w799\" style=\"height: auto; max-width: 100%; margin: 10px;\"></p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">如果是平时的风险，一般来说PM或者PMO能去把控或者承担风险责任，但是想这次疫情对所有企业的袭击，就会上升到企业层面，由企业来承当整个公司的风险后果，所有高层都应该出来协调各方项目资源、项目整合、与项目管理。为什么要这么做，这个其实就是统一整合式管理，因为所有的项目全部受影响，就需要统一的整合了，保证一致性。<br><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/03/16/15843496546451.jpg\" alt=\"-w764\" style=\"height: auto; max-width: 100%; margin: 10px;\"></p><h3 style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\"><a name=\"toc_2\" style=\"color: rgb(70, 70, 70);\"></a>审查风险</h3><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">分析在这次风险中的各个环节，对比原有计划所存在的出入点。比如：</p><ul style=\"list-style: none; margin-right: 0px; margin-bottom: 0px; margin-left: 30px; padding: 0px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><li style=\"list-style-type: disc;\">特殊物流运输会减少流量<ul style=\"list-style: none; margin-right: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: circle;\">工厂需求减少</li><li style=\"list-style-type: circle;\">大型物流车停滞所产生的消耗费（一天不开车，每辆亏损上千）</li></ul></li><li style=\"list-style-type: disc;\">交通管制导致原有特殊导航系统不可用，油费额外增多</li><li style=\"list-style-type: disc;\">员工需要自我14天隔离的费用</li><li style=\"list-style-type: disc;\">每日口罩成本损耗</li><li style=\"list-style-type: disc;\">远程办公可能会带来的额外成本<ul style=\"list-style: none; margin-right: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: circle;\">微信视频会议等都免费</li><li style=\"list-style-type: circle;\">国外的一些团队协作工具收费&nbsp;<img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/03/16/15843496657408.jpg\" alt=\"-w600\" style=\"height: auto; max-width: 100%;\"></li></ul></li></ul><h3 style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px; color: rgb(0, 0, 0); font-family: 微软雅黑, 宋体, Arial;\"><a name=\"toc_3\" style=\"color: rgb(70, 70, 70);\"></a>应对风险</h3><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">不管遇到任何风险，第一个要做的就是上报，注意，不要越级上报，你是PM，你上面有PMO，所要先汇报给PMO，如果没有PMO就汇报给你的直属经理，比如部门经理或者部门总监。在这个过程中，要响应政府号召，比如排查啊隔离啥的，每日体温测量，人员动向，如果有异常情况，也要及时上报。那么作为项目经理，就需要根据实际情况来适当调整原项目进度计划，适当延后，和参与的相关干系人讨论方案，与客户协调沟通。<br><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/03/16/15843496759816.jpg\" alt=\"-w701\" style=\"height: auto; max-width: 100%; margin: 10px;\"></p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">随后，你要看风险是否可控，是否可以规避，常规的你的下属要离职，那么你就去谈谈，能不能挽留，能不能协调公司资源给他涨薪，了解其诉求，解决其诉求。如果是一些额外成本费用，那么可能还是需要通过上报批准，当然如果小成本你要自己解决也行。像这次疫情，对于一些不可继续的项目，只能停止复工，往后延期延迟，硬着头皮偷偷上一旦被查会承担一些法律责任。比如我们有很多车队因为交通管制无法上路，每天每辆车的停车费用有很多，需要和司机和管理处协调，谈判能否降低停车成本，降低企业成本。<br><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/03/16/15843496892846.jpg\" alt=\"-w679\" style=\"height: auto; max-width: 100%; margin: 10px;\"></p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">第三，转移风险，降低风险影响，一般来说就是弥补，最常见的就是保险业务。我们每辆车都投了巨大的保额，为啥？因为全国这么多车，一旦发生车祸，人员伤亡，你都处理不过来，这个时候就需要有保险的介入，以此把风险转移给保险公司，以最小的时间人力成本来降低风险。那么对于这次疫情，作为PM，需要回顾一下所有的实体资源，看看是否有一些保险可以弥补一定的损失。我们审查以后，对于司机的健康保险是可以有一定的弥补的，有总比没有好。<br><img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/03/16/15843497052573.jpg\" alt=\"-w603\" style=\"height: auto; max-width: 100%; margin: 10px;\"></p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">第四，主动降低风险，这个其实很简单，就是响应号召，戴口罩，少出门，勤洗手，多消毒，降低自身感染病毒的风险。</p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">第五，接受风险，这个分为主动和被动之分：</p><ul style=\"list-style: none; margin-right: 0px; margin-bottom: 0px; margin-left: 30px; padding: 0px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><li style=\"list-style-type: disc;\">主动：实行远程办公，线上的一些项目都可以采取这种方式，互联网企业是较多的，还有一些自媒体啥的，这些完全可以在家里办公，而且可以利用远程协作工具来开展团队管理。但是也要注意，PM要每天定时跟踪每位团队成员的健康度，比如测量体温，观察身体异常。</li><li style=\"list-style-type: disc;\">被动：这个就没办法了，线下的传统企业几乎都栽进去了，我们必须响应号召，延迟复工，工厂不得开，要开也要得报备审查。如果不行只能停止运作。&nbsp;<img src=\"https://lee-blog.oss-cn-shanghai.aliyuncs.com/2020/03/16/15843497175683.jpg\" alt=\"-w683\" style=\"height: auto; max-width: 100%;\"></li></ul><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\">第六，要提交应急风险变更通知，因为项目整体肯定会受到影响，所以原计划是肯定要做出变动的，比如最大的成本开支，以及预算，都要跟着市场资源做变动，变动了才能有效调控。如果资源没有，或者成本实在太高，影响项目利润，那么就只能暂缓延迟。</p>', 5, 1, 'http://127.0.0.1:65535/huoyan/c647b9c91f234ad6a13a1623ca7b7021.png', 0, 3, 'ed1924', '2020-06-11 09:48:49', 0, 0, NULL, 0, '2020-06-11 09:48:49', '2020-06-11 09:48:49');
INSERT INTO `chu_article` VALUES ('200611716SZ4Z9AW', 'Hystrix 简单聊聊断路器/熔断器', '<strong>什么是Hystrix</strong>Hystrix 在SpringCloud中负责服务熔断服务降级的作用。Hystrix 存在的目的也是为了防止过多超时导致系统瘫痪。比如多个服务之间的相互调用，如下图：<img src=\"\" alt=\"\" />订单-&gt;商品-&gt;积分-&gt;日志订单-&gt;支付-&gt;日志商品-&gt;风控-&gt;日志服务之间相互调用，假设某个链路上的某个服务比如日志服务超时了，不可被调用，那么其他的服务全部卡死，导致崩溃。举一个生活中的例子：<img src=\"\" alt=\"\" />在家里，我开了很多电器，这个时候如果没有一个保护装置的话，由于某个电器过载，最终会导致整个电路断掉，那么每户人家肯定会有一个装置叫做保险丝，那么Hystrix断路器就起到了保险丝的作用，他可以保护整个系统。Hystrix在分布式系统或者微服务中，一旦出现了超时或者依赖服务不可用调用失败异常等情况，他能够保证整个系统不会整体宕机崩溃，从而提高整个系统的健壮性。Hystrix的原理就是当某一个服务发生故障的时候，这个时候是不会有任何的正常响应的，但是通过Hystrix可以返回一个备用响应，也就是所谓的backup，如此一来，发生异常的系统就不会造成不必要的超时等异常现象，这就好比打篮球，上场必须要5人，但是如果有人受伤要下场，这个时候就必须要有backup球员，如果没有，这个球队很难进行比赛了。简单一句话总结，就是Hystrix可以保证在众多微服务中一个服务出现了问题不会引发整体系统奔溃的一个开源组件。<strong>服务熔断</strong>熔断是一种微服务链路的保护机制，当某个服务（依赖）不可用/宕机/超时/异常的时候，会进行服务的熔断（是一个开关，会开启），这个发生故障的节点就被熔断了也就是不可用，不会再让用户调用到，那么此时就需要降级，来直接会返回一个错误的异常响应信息。当这个节点OK恢复了，hystrix会检测到，然后再把他恢复到整个链路。熔断机制在很多行业里都有，比如股市，金融行业，都是为了更好更有效的控制，把损失控制在一定的范围内。<strong>代码演示</strong>pom 中加入依赖\n启动类开启熔断器@EnableCircuitBreaker\n编写错误的controller测试：如果正常访问，显示&nbsp;Hello hystrix~发生异常熔断，则展示：<img src=\"\" alt=\"\" /><strong>服务器降级</strong>当某个服务资源不够的时候，可以启用降级处理。举一个例子，如下图：<img src=\"\" alt=\"\" />假设我们家里用很多电器，其他电器正在使用中并且占用的电流啊电压啥的很大，空调我这个时候可以不用，把资源给到其他的电器，这时我们是直接把空调插头拔出，区别于熔断，熔断的话是发生异常后和谐的响应信息，而降级是我把这个服务关停了，随后在响应给用户。需要注意，由于服务关闭了，所以响应是发生在调用方的，也就是客户端，比如图中的电热水壶和微波炉。当电压电流恢复后，我们再把空调插头插上即可，那么这就是降级的一种方式。那么熔断和降级的异同点是啥呢？相同点：都是为了提升系统的可靠性都为了正确的返回响应给用户不同点：熔断：被调用的服务方（下游）发生故障导致降级：全局整体服务负载过高，有效调动资源服务，由调用方（上游）控制<strong>熔断解耦分离</strong>当使用@HystrixCommand的时候，每有一个controller的接口api，就会有一个熔断方法，这是成倍的增长的，数量会很多，维护不方便，所以需要解耦开来。而且，当我们关闭不用的微服务时，上游还是会调用下游，所以我们需要在上游服务这块，去增加降级的方法，如果服务无法调用，则调用上游服务中的降级方法即可。并且下游服务如果被我们关闭，上游的调用还是可以有响应给用户的。<strong>简单总结一下</strong>熔断：当一个服务发生故障异常，这个时候熔断当前整个服务，把这个服务变的不可被访问，而不是客户端请求这个服务的时候一直处于超时。降级：当服务熔断后，我们需要提供新的一个兜底接口返回响应数据，如此一来，客户端能够友好的接受到响应消息。', 2, 1, 'http://127.0.0.1:65535/huoyan/c647b9c91f234ad6a13a1623ca7b7021.png', 0, 3, 'ed1924', '2020-06-11 09:52:13', 0, 0, NULL, 0, '2020-06-11 09:52:13', '2022-10-18 14:50:21');
INSERT INTO `chu_article` VALUES ('20061171HKPGC3XP', '大白话告诉你倒排索引是个啥', '<div id=\"cnblogs_post_body\" class=\"blogpost-body cnblogs-markdown\" style=\"margin-bottom: 20px; word-break: break-word; font-family: 微软雅黑, 宋体, Arial; font-size: 15px;\"><h3 id=\"引子\" style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px;\">引子</h3><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">很多搜索引擎都是基于倒排索引，比如luncene，solr以及elasticsearch</p><h3 id=\"正排索引\" style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px;\">正排索引</h3><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">聊倒排搜索之前先来看看正排索引，正排其实就是数据库表，他通过id和数据进行关联，如下：</p><table style=\"border: 1px solid rgb(223, 223, 223); word-break: break-word;\"><thead><tr><th style=\"background-color: rgb(250, 250, 250); border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">数据id</th><th style=\"background-color: rgb(250, 250, 250); border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">数据内容</th></tr></thead><tbody><tr><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">1001</td><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">苹果公司发布iPhone</td></tr><tr><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">1002</td><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">地球引力起源于苹果</td></tr><tr><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">1003</td><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">iPhone屏幕碎了</td></tr><tr><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">1004</td><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">我在苹果商店维修屏幕</td></tr><tr><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">1005</td><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">我刚刚吃了苹果</td></tr></tbody></table><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">我们可以通过搜索id，来获得相应的数据，也能删除数据。你买了一本书，书的目录其实也是正排搜索。</p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">假设现在我要搜<code style=\"line-height: 1.8; margin: 1px 5px; vertical-align: middle; display: inline-block; font-family: &quot;Courier New&quot;, sans-serif !important; font-size: 12px !important; background-color: rgb(245, 245, 245) !important; border: 1px solid rgb(204, 204, 204) !important; padding: 0px 5px !important; border-radius: 3px !important;\">苹果</code>俩字，那么他会对这张表格中每一行的数据做匹配，去查找一下，是否包含<code style=\"line-height: 1.8; margin: 1px 5px; vertical-align: middle; display: inline-block; font-family: &quot;Courier New&quot;, sans-serif !important; font-size: 12px !important; background-color: rgb(245, 245, 245) !important; border: 1px solid rgb(204, 204, 204) !important; padding: 0px 5px !important; border-radius: 3px !important;\">苹果</code>这两个字，从第一条匹配到最后一条，如果一张表中数据量不多，几万，十几万，那么问题不大，但是一旦数据量有上百万，上千万，那么全表扫描这种的搜索性能就会有影响。</p><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">其次，这个时候我想搜索<code style=\"line-height: 1.8; margin: 1px 5px; vertical-align: middle; display: inline-block; font-family: &quot;Courier New&quot;, sans-serif !important; font-size: 12px !important; background-color: rgb(245, 245, 245) !important; border: 1px solid rgb(204, 204, 204) !important; padding: 0px 5px !important; border-radius: 3px !important;\">苹果iPhone</code>，那么我们无法把这词汇拆开再到数据库去搜索。</p><ul style=\"list-style: none; margin-right: 0px; margin-bottom: 0px; margin-left: 30px; padding: 0px;\"><li style=\"list-style-type: disc;\">优点：使用起来方便，原理也简单，比较入门</li><li style=\"list-style-type: disc;\">缺点：检索效率低下，适合简单场景使用，比如传统项目，数据量较小的项目。不支持分词搜索。</li></ul><h3 id=\"倒排索引\" style=\"font-size: 16px; font-weight: bold; line-height: 1.5; margin-top: 10px; margin-right: 0px; margin-left: 0px;\">倒排索引</h3><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">与正排是反着来的，他会把文档内容进行分词，比如<code style=\"line-height: 1.8; margin: 1px 5px; vertical-align: middle; display: inline-block; font-family: &quot;Courier New&quot;, sans-serif !important; font-size: 12px !important; background-color: rgb(245, 245, 245) !important; border: 1px solid rgb(204, 204, 204) !important; padding: 0px 5px !important; border-radius: 3px !important;\">苹果公司发布iPhone</code>是一个文档数据，当我们把他存入到搜索引擎中去的时候，会有一个文档id，这个文档id就类似于数据库主键。但是这文档存储的时候和数据库不一样，他会进行一个分词，参照上面的表格，分词后的结果如下：</p><table style=\"border: 1px solid rgb(223, 223, 223); word-break: break-word;\"><thead><tr><th style=\"background-color: rgb(250, 250, 250); border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">文档数据</th><th style=\"background-color: rgb(250, 250, 250); border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">分词结果</th></tr></thead><tbody><tr><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">苹果公司发布iPhone</td><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">苹果，公司，发布，iPhone</td></tr><tr><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">地球引力起源于苹果</td><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">地球，引力，起源，于，苹果</td></tr><tr><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">iPhone屏幕碎了</td><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">iPhone，屏幕，碎了</td></tr><tr><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">我在苹果商店维修屏幕</td><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">我，在，苹果，商店，维修，屏幕</td></tr><tr><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">我刚刚吃了苹果</td><td style=\"border: 1px solid rgb(192, 192, 192); border-collapse: collapse; padding: 8px 14px; min-width: 50px;\">我，刚刚，吃了，苹果</td></tr></tbody></table><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\">每一个词汇都会和文档id关联起来，可以根据词汇来找到所有出现的id列表，如下：</p><br><p style=\"margin-top: 10px; margin-right: auto; margin-left: auto; line-height: 24px;\"><br></p><ul style=\"list-style: none; margin-right: 0px; margin-bottom: 0px; margin-left: 30px; padding: 0px;\"><li></li></ul></div>', 5, 1, 'http://127.0.0.1:65535/huoyan/c647b9c91f234ad6a13a1623ca7b7021.png', 0, 3, 'ed1924', '2020-06-11 09:53:16', 0, 0, NULL, 0, '2020-06-11 09:53:16', '2020-06-11 09:53:16');
INSERT INTO `chu_article` VALUES ('3HWrV2nh', '123', '123', 3, 1, NULL, 0, 1, '1', '2022-10-24 16:17:46', 0, 0, NULL, 0, '2022-10-24 16:17:46', '2022-10-24 16:17:46');
INSERT INTO `chu_article` VALUES ('43hZDYYl', 'qwe', 'qwe', 3, 1, NULL, 0, 1, '1', '2022-10-24 16:20:42', 0, 0, NULL, 0, '2022-10-24 16:20:37', '2022-10-24 16:20:42');
INSERT INTO `chu_article` VALUES ('4xjSUBN5', 'qwe', 'qwe', 3, 1, NULL, 0, 1, '1', '2022-10-25 14:03:19', 0, 0, NULL, 0, '2022-10-25 14:03:19', '2022-10-25 14:03:19');
INSERT INTO `chu_article` VALUES ('98qjwgw6', 'w', 'w', 6, 1, 'http://127.0.0.1:9300/statics/2022/10/24/QQ图片20220923095559_20221024171353A001.jpg', 0, 1, '1', '2022-10-24 17:13:55', 0, 0, NULL, 0, '2022-10-24 17:13:55', '2022-10-24 17:13:55');
INSERT INTO `chu_article` VALUES ('akMHRgGN', '“夺取新时代中国特色社会主义新胜利的政治宣言和行动纲领”——中共中央举行新闻发布会解读党的二十大报告', '新华社北京10月24日电&nbsp;<strong>题：“夺取新时代中国特色社会主义新胜利的政治宣言和行动纲领”——中共中央举行新闻发布会解读党的二十大报告</strong>新华社记者张研、董博婷10月24日上午，中共中央举行新闻发布会，介绍解读党的二十大报告。中央政法委秘书长陈一新，中央政策研究室主任江金权，中央改革办分管日常工作的副主任、国家发展改革委副主任穆虹，中央纪委国家监委宣传部部长王建新，中央办公厅副主任兼调研室主任唐方裕，中央宣传部副部长孙业礼等有关方面负责人解读党的二十大报告并回答记者关心的问题。<strong>新时代十年的伟大变革，是以习近平同志为核心的党中央坚强领导的结果，是全党全军全国各族人民团结奋斗、顽强拼搏的结果</strong>中央政策研究室主任江金权表示，中国共产党第二十次全国代表大会，是在全党全国各族人民迈上全面建设社会主义现代化国家新征程、向第二个百年奋斗目标进军的关键时刻召开的一次十分重要的大会，是一次高举旗帜、凝聚力量、团结奋进的大会。大会通过的报告，分析了国际国内形势，提出了大会主题，回顾总结了过去五年的工作和新时代十年的伟大变革，阐述了开辟马克思主义中国化时代化新境界、中国式现代化的中国特色和本质要求等重大问题，擘画了全面建成社会主义现代化强国的宏伟蓝图和实践路径，就未来五年党和国家事业发展制定了大政方针、作出了全面部署，是中国共产党团结带领全国各族人民夺取新时代中国特色社会主义新胜利的政治宣言和行动纲领，是一篇马克思主义的纲领性文献。江金权表示，党的二十大报告是充分发扬党内民主和全过程人民民主、集中全党全国人民智慧的结晶。党中央进行了两轮在党内一定范围征求意见，征求意见达到4700多人，并通过网络向社会公开征求意见，收集意见达850多万条，集中体现了新时代党和人民的实践经验和理论创新成果，凝聚了全党全社会的智慧，顺应了人民群众期待，必将对党团结带领人民全面建设社会主义现代化国家、全面推进中华民族伟大复兴产生重大而深远的影响，也必将有利于国际社会进一步了解中国共产党的执政理念、执政方式、执政能力。党的二十大报告从十六个方面总结概括了十年来的伟大变革，江金权认为最具标志性意义的有六个方面：一是取得了“两个确立”的重大政治成果，二是中国共产党在革命性锻造中更加坚强有力，三是胜利实现全面建成小康社会目标，四是维护国家安全能力显著提高，五是我国国际地位显著提升，六是我国制度优势更加彰显。“这些伟大变革，是以习近平同志为核心的党中央坚强领导的结果，是全党全军全国各族人民团结奋斗、顽强拼搏的结果，是党和人民一道拼出来、干出来、奋斗出来的，必将永载史册、光耀千秋。”江金权说。在回答记者提问时，江金权表示，新时代十年的伟大变革是全方位、根本性、格局性的，其影响是全局性、历史性的，所以称之为“伟大变革”。新时代十年的伟大变革具有里程碑意义：锻造了民族复兴伟业的坚强领导核心，推动中华民族伟大复兴进入了不可逆转的历史进程，使中国人民更加自信自立自强，为世界和平与发展注入了强大正能量，彰显了马克思主义的强大生命力。<strong>做到“两个结合”“六个必须坚持”，推进马克思主义中国化时代化</strong>党的二十大报告第二部分专门论述理论创新。中央宣传部副部长孙业礼表示，习近平新时代中国特色社会主义思想是当代中国马克思主义、二十一世纪马克思主义，是中华文化和中国精神的时代精华，实现了马克思主义中国化时代化新的飞跃。党的十九大、十九届六中全会对这一思想的主要内容作了概括，我们必须长期坚持并不断丰富发展。党的二十大报告展开论述了“两个结合”，即把马克思主义基本原理同中国具体实际相结合、同中华优秀传统文化相结合。孙业礼表示，这“两个结合”深化了我们党对坚持和发展马克思主义的规律性认识，也是我们理解和把握习近平新时代中国特色社会主义思想的关键。“第一个结合，同中国具体实际相结合，是我们党一直强调并坚持的，是中国共产党百年历史中最宝贵的经验，是党的事业不断成功的法宝。”孙业礼表示，习近平总书记在报告中强调“不能把马克思主义当成一成不变的教条”，强调“我们必须坚持解放思想、实事求是、与时俱进、求真务实，一切从实际出发”。这就是我们党思想路线的要义，习近平新时代中国特色社会主义思想就是遵循这一思想路线形成的，也必将遵循这一思想路线继续丰富、发展。“第二个结合，就是必须同中华优秀传统文化相结合。这是习近平总书记在建党百年庆祝大会上提出来的，党的二十大报告又作了深入阐述。这是对党的理论的又一重大创新，开创了我们党理论创新的新格局。”孙业礼表示，这是对历史的深刻总结，是对规律的深刻揭示，也是对未来理论发展的正确引领，代表了中国共产党人新的觉悟、新的认识高度，也体现了我们中国共产党和中国人民强烈的文化自信与文化自觉。党的二十大报告还阐述了习近平新时代中国特色社会主义思想的世界观和方法论，即“六个必须坚持”：坚持人民至上，坚持自信自立，坚持守正创新，坚持问题导向，坚持系统观念，坚持胸怀天下。“这深刻揭示了这一科学思想的理论品格和鲜明特质，我们学习、实践这一思想必须牢牢把握这些基本点，始终坚持这些基本点。”孙业礼说。在回答记者提问时，孙业礼表示，我们坚决反对其他国家将自己的发展模式强加给中国，也决不“输出”中国模式，不会要求别国“复制”中国的做法。每个国家自主探索符合本国国情的现代化道路的努力都应该受到尊重。<strong>把高质量发展作为全面建设社会主义现代化国家的首要任务，凸显发展质量的全局和长远意义</strong>党的二十大报告指出，高质量发展是全面建设社会主义现代化国家的首要任务，并强调这是中国式现代化的本质要求。中央改革办分管日常工作的副主任、国家发展改革委副主任穆虹表示，进入新时代，我国社会主要矛盾已经转化为人民日益增长的美好生活需要和不平衡不充分的发展之间的矛盾，发展中的矛盾和问题更多体现在发展质量上。“党中央强调，贯彻新发展理念、推动高质量发展，是关系现代化建设全局的一场深刻变革，不再简单以生产总值增长率论英雄，而是要实现创新成为第一动力、协调成为内生特点、绿色成为普遍形态、开放成为必由之路、共享成为根本目的的高质量发展。”穆虹表示，因此，党的二十大报告把发展质量摆在更突出的位置，经济、社会、文化、生态等各方面都体现了高质量发展的要求。“二十大报告把高质量发展明确作为全面建设社会主义现代化国家的首要任务，进一步凸显了发展质量的全局和长远意义。”穆虹介绍了党的二十大报告对推动高质量发展作出的战略部署：一是加快构建新发展格局，二是坚定实施创新驱动发展战略、向创新要动力，三是构建高水平社会主义市场经济体制、向改革要活力，四是全面推进乡村振兴，五是着力推进区域协调发展，六是推进高水平对外开放。<strong>把法治建设作为专章论述、专门部署，体现对全面依法治国的高度重视</strong>中央政法委秘书长陈一新表示，党的二十大报告首次单独把法治建设作为专章论述、专门部署，这充分体现了以习近平同志为核心的党中央对全面依法治国的高度重视。陈一新表示，从政治意义上看，这进一步宣示了我们党矢志不渝推进法治建设的坚定决心，彰显了我们党不仅是敢于革命、善于建设、勇于改革的政党，更是信仰法治、坚守法治、建设法治的政党，是我们党坚持全面依法治国的政治宣言。从理论意义上看，这进一步丰富和发展了习近平法治思想，深化了对中国共产党依法执政规律、社会主义法治建设规律、人类社会法治文明发展规律的认识，是我们党推进法治中国建设的纲领性文献。从实践意义上看，这进一步深化和拓展了新时代党和国家工作布局，表明了将全面推进国家各方面工作法治化，是我们党治国理政的重要治理方式。“关于法治建设地位作用、总体要求和重点工作，党的二十大报告作了全面阐述。”陈一新介绍：一是强调遵循法治之“纲”，这个“纲”就是报告提出的新时代法治建设总体要求。二是强调立好法治之“规”，这个“规”就是报告提出的完善以宪法为核心的中国特色社会主义法律体系。三是强调紧扣法治之“重”，这个“重”就是报告提出的扎实推进依法行政。四是强调凸显法治之“要”，这个“要”就是报告提出的严格公正司法。五是强调夯实法治之“基”，这个“基”就是报告提出的加快建设法治社会。<strong>部署深入推进新时代党的建设新的伟大工程，提出健全全面从严治党体系</strong>中央办公厅副主任兼调研室主任唐方裕表示，全面建设社会主义现代化国家、全面推进中华民族伟大复兴，关键在党，关键在党要管党、全面从严治党。完成新时代新征程党的使命任务，必须旗帜鲜明坚持和加强党的全面领导，深入推进新时代党的建设新的伟大工程。党的二十大报告单列一个部分，对“坚定不移全面从严治党，深入推进新时代党的建设新的伟大工程”作出部署，唐方裕介绍这部分内容的主要特点是“四个突出”：突出党的自我革命，突出全面从严治党体系，突出以党的政治建设为统领，突出思想建党和制度治党相结合。党的二十大综合各方面意见，顺应各级党组织和广大党员愿望，对党章作出适当修改。“修改后的党章充分体现马克思主义中国化时代化最新成果，充分体现党的十九大以来党中央提出的治国理政新理念新思想新战略，充分体现党的工作和党的建设的新鲜经验，对于深入推进新时代党的建设新的伟大工程具有重大意义。”唐方裕表示，对于党的二十大关于党的建设的论述和部署，需要把报告和党章结合起来学习理解。在回答记者提问时，唐方裕表示，党的二十大报告提出健全全面从严治党体系，这在党的全国代表大会报告中是首次。我们党作为长期执政的马克思主义政党和世界上第一大政党，党的远大目标和历史使命，党的队伍的庞大规模和广泛分布，党面临的重大风险和严峻挑战，都决定只有整体地而不是局部地、系统地而不是零碎地、持久地而不是短暂地、高标准地而不是一般化地全面从严治党，形成一个布局合理、内容科学、要素齐备、统一高效的全面从严治党体系，才能把我们党建设好。<strong>提出必须时刻保持解决大党独有难题的清醒和坚定，牢记全面从严治党永远在路上、党的自我革命永远在路上</strong>党的二十大报告指出：“全面建设社会主义现代化国家、全面推进中华民族伟大复兴，关键在党。我们党作为世界上最大的马克思主义执政党，要始终赢得人民拥护、巩固长期执政地位，必须时刻保持解决大党独有难题的清醒和坚定。”中央纪委国家监委宣传部部长王建新表示，党的二十大报告要求全党牢记，全面从严治党永远在路上、党的自我革命永远在路上。要围绕坚持党中央集中统一领导强化政治监督，完善党的自我革命制度规范体系，坚持以严的基调强化正风肃纪，坚决打赢反腐败斗争攻坚战持久战。在回答记者提问时，王建新表示，新时代十年，反腐败斗争历程波澜壮阔、成就举世瞩目，但形势依然严峻复杂，同腐败的较量是一场殊死搏斗，只能进、绝不能退，只能赢、绝不能输。必须坚决贯彻党的二十大战略部署，保持压倒性力量常在，不敢腐、不能腐、不想腐同时发力、同向发力、综合发力，坚决打赢反腐败斗争攻坚战持久战。', 2, 1, NULL, 0, 1, '1', '2022-10-25 11:20:19', 0, 0, NULL, 0, '2022-10-25 11:20:19', '2022-10-25 11:20:19');
INSERT INTO `chu_article` VALUES ('bOBETWjF', '二十大新闻中心举办首场记者招待会', '央广网北京10月18日消息（记者谭瑱 韩雪莹）据中央广播电视总台中国之声《新闻和报纸摘要》报道，二十大新闻中心17日举行两场记者招待会。在17日上午举行的首场记者招待会上，相关部门负责人介绍“贯彻新发展理念、构建新发展格局、推动高质量发展，以中国式现代化全面推进中华民族伟大复兴”有关情况，并回答记者提问。&nbsp;中国式现代化是人口规模巨大的现代化。作为拥有14亿多人口的大国，保障粮食安全对我国而言是个永恒的课题。国家发展改革委党组成员、国家粮食和物资储备局局长丛亮：我国粮食安全形势是好的，做到了把中国人的饭碗牢牢端在自己手中，而且里面主要装中国粮。未来，我们有基础、有条件、有能力、有信心，始终牢牢把住粮食安全的主动权，中国特色粮食安全之路必将越走越宽广。能源安全是关系国家经济社会发展的全局性、战略性问题，对国家繁荣发展、人民生活改善、社会长治久安至关重要。国家能源局党组成员、副局长任京东介绍，将守住能源安全底线，坚持立足国内多元供应保安全。任京东：我们将充分发挥煤炭的压舱石作用和煤电的基础性调节性作用，大力提升油气勘探开发力度，进一步建立健全煤炭、石油储备体系；全面构建风、光、水、核等清洁能源供应体系，扎实推动水电、核电重大工程建设。党的二十大报告指出，加快构建以国内大循环为主体、国内国际双循环相互促进的新发展格局。国家发展改革委党组成员、副主任赵辰昕：我们积极利用国内国外两个市场两种资源，为促进市场经济建设、丰富市场供给、带动产业结构转型升级、培育国际竞争新优势、全面提升综合国力创造了条件，有力改善了我国生产要素质量和配置水平，促进了国内大循环效率和质量提升。', 7, 1, NULL, 0, 1, '1', '2022-10-18 16:02:12', 0, 0, NULL, 0, '2022-10-18 16:02:12', '2022-10-18 16:02:12');
INSERT INTO `chu_article` VALUES ('dYVBxp6j', 'asd', 'asd', 9, 1, NULL, 0, 1, '1', '2022-10-25 15:08:25', 0, 0, NULL, 0, '2022-10-25 15:08:25', '2022-10-25 15:08:25');
INSERT INTO `chu_article` VALUES ('g14EHeUc', '越共中央总书记阮富仲将访华', '新华社北京10月25日电中共中央对外联络部发言人胡兆明10月25日宣布：应中共中央总书记、国家主席习近平邀请，越共中央总书记阮富仲将于10月30日至11月2日对中国进行正式访问。（完）', 6, 1, 'http://127.0.0.1:9300/statics/2022/10/25/responsedfgdgsf_20221025135543A001.jpg', 0, 1, '1', '2022-10-25 13:55:45', 0, 0, NULL, 0, '2022-10-25 13:55:45', '2022-10-25 13:55:45');
INSERT INTO `chu_article` VALUES ('HMFwFWSD', '1', '1', 6, 1, NULL, 0, 1, '1', '2022-10-25 14:01:40', 0, 0, NULL, 0, '2022-10-25 14:01:40', '2022-10-25 14:01:40');
INSERT INTO `chu_article` VALUES ('IKVDYFDl', 'qwer', 'qwer', 6, 1, NULL, 0, 1, '1', '2022-10-25 14:12:42', 0, 0, NULL, 0, '2022-10-25 14:12:42', '2022-10-25 14:12:42');
INSERT INTO `chu_article` VALUES ('nhttEMNQ', '“夺取新时代中国特色社会主义新胜利的政治宣言和行动纲领”——中共中央举行新闻发布会解读党的二十大报告', '新华社北京10月24日电&nbsp;<strong>题：“夺取新时代中国特色社会主义新胜利的政治宣言和行动纲领”——中共中央举行新闻发布会解读党的二十大报告</strong>新华社记者张研、董博婷10月24日上午，中共中央举行新闻发布会，介绍解读党的二十大报告。中央政法委秘书长陈一新，中央政策研究室主任江金权，中央改革办分管日常工作的副主任、国家发展改革委副主任穆虹，中央纪委国家监委宣传部部长王建新，中央办公厅副主任兼调研室主任唐方裕，中央宣传部副部长孙业礼等有关方面负责人解读党的二十大报告并回答记者关心的问题。<strong>新时代十年的伟大变革，是以习近平同志为核心的党中央坚强领导的结果，是全党全军全国各族人民团结奋斗、顽强拼搏的结果</strong>中央政策研究室主任江金权表示，中国共产党第二十次全国代表大会，是在全党全国各族人民迈上全面建设社会主义现代化国家新征程、向第二个百年奋斗目标进军的关键时刻召开的一次十分重要的大会，是一次高举旗帜、凝聚力量、团结奋进的大会。大会通过的报告，分析了国际国内形势，提出了大会主题，回顾总结了过去五年的工作和新时代十年的伟大变革，阐述了开辟马克思主义中国化时代化新境界、中国式现代化的中国特色和本质要求等重大问题，擘画了全面建成社会主义现代化强国的宏伟蓝图和实践路径，就未来五年党和国家事业发展制定了大政方针、作出了全面部署，是中国共产党团结带领全国各族人民夺取新时代中国特色社会主义新胜利的政治宣言和行动纲领，是一篇马克思主义的纲领性文献。江金权表示，党的二十大报告是充分发扬党内民主和全过程人民民主、集中全党全国人民智慧的结晶。党中央进行了两轮在党内一定范围征求意见，征求意见达到4700多人，并通过网络向社会公开征求意见，收集意见达850多万条，集中体现了新时代党和人民的实践经验和理论创新成果，凝聚了全党全社会的智慧，顺应了人民群众期待，必将对党团结带领人民全面建设社会主义现代化国家、全面推进中华民族伟大复兴产生重大而深远的影响，也必将有利于国际社会进一步了解中国共产党的执政理念、执政方式、执政能力。党的二十大报告从十六个方面总结概括了十年来的伟大变革，江金权认为最具标志性意义的有六个方面：一是取得了“两个确立”的重大政治成果，二是中国共产党在革命性锻造中更加坚强有力，三是胜利实现全面建成小康社会目标，四是维护国家安全能力显著提高，五是我国国际地位显著提升，六是我国制度优势更加彰显。“这些伟大变革，是以习近平同志为核心的党中央坚强领导的结果，是全党全军全国各族人民团结奋斗、顽强拼搏的结果，是党和人民一道拼出来、干出来、奋斗出来的，必将永载史册、光耀千秋。”江金权说。在回答记者提问时，江金权表示，新时代十年的伟大变革是全方位、根本性、格局性的，其影响是全局性、历史性的，所以称之为“伟大变革”。新时代十年的伟大变革具有里程碑意义：锻造了民族复兴伟业的坚强领导核心，推动中华民族伟大复兴进入了不可逆转的历史进程，使中国人民更加自信自立自强，为世界和平与发展注入了强大正能量，彰显了马克思主义的强大生命力。<strong>做到“两个结合”“六个必须坚持”，推进马克思主义中国化时代化</strong>党的二十大报告第二部分专门论述理论创新。中央宣传部副部长孙业礼表示，习近平新时代中国特色社会主义思想是当代中国马克思主义、二十一世纪马克思主义，是中华文化和中国精神的时代精华，实现了马克思主义中国化时代化新的飞跃。党的十九大、十九届六中全会对这一思想的主要内容作了概括，我们必须长期坚持并不断丰富发展。党的二十大报告展开论述了“两个结合”，即把马克思主义基本原理同中国具体实际相结合、同中华优秀传统文化相结合。孙业礼表示，这“两个结合”深化了我们党对坚持和发展马克思主义的规律性认识，也是我们理解和把握习近平新时代中国特色社会主义思想的关键。“第一个结合，同中国具体实际相结合，是我们党一直强调并坚持的，是中国共产党百年历史中最宝贵的经验，是党的事业不断成功的法宝。”孙业礼表示，习近平总书记在报告中强调“不能把马克思主义当成一成不变的教条”，强调“我们必须坚持解放思想、实事求是、与时俱进、求真务实，一切从实际出发”。这就是我们党思想路线的要义，习近平新时代中国特色社会主义思想就是遵循这一思想路线形成的，也必将遵循这一思想路线继续丰富、发展。“第二个结合，就是必须同中华优秀传统文化相结合。这是习近平总书记在建党百年庆祝大会上提出来的，党的二十大报告又作了深入阐述。这是对党的理论的又一重大创新，开创了我们党理论创新的新格局。”孙业礼表示，这是对历史的深刻总结，是对规律的深刻揭示，也是对未来理论发展的正确引领，代表了中国共产党人新的觉悟、新的认识高度，也体现了我们中国共产党和中国人民强烈的文化自信与文化自觉。党的二十大报告还阐述了习近平新时代中国特色社会主义思想的世界观和方法论，即“六个必须坚持”：坚持人民至上，坚持自信自立，坚持守正创新，坚持问题导向，坚持系统观念，坚持胸怀天下。“这深刻揭示了这一科学思想的理论品格和鲜明特质，我们学习、实践这一思想必须牢牢把握这些基本点，始终坚持这些基本点。”孙业礼说。在回答记者提问时，孙业礼表示，我们坚决反对其他国家将自己的发展模式强加给中国，也决不“输出”中国模式，不会要求别国“复制”中国的做法。每个国家自主探索符合本国国情的现代化道路的努力都应该受到尊重。<strong>把高质量发展作为全面建设社会主义现代化国家的首要任务，凸显发展质量的全局和长远意义</strong>党的二十大报告指出，高质量发展是全面建设社会主义现代化国家的首要任务，并强调这是中国式现代化的本质要求。中央改革办分管日常工作的副主任、国家发展改革委副主任穆虹表示，进入新时代，我国社会主要矛盾已经转化为人民日益增长的美好生活需要和不平衡不充分的发展之间的矛盾，发展中的矛盾和问题更多体现在发展质量上。“党中央强调，贯彻新发展理念、推动高质量发展，是关系现代化建设全局的一场深刻变革，不再简单以生产总值增长率论英雄，而是要实现创新成为第一动力、协调成为内生特点、绿色成为普遍形态、开放成为必由之路、共享成为根本目的的高质量发展。”穆虹表示，因此，党的二十大报告把发展质量摆在更突出的位置，经济、社会、文化、生态等各方面都体现了高质量发展的要求。“二十大报告把高质量发展明确作为全面建设社会主义现代化国家的首要任务，进一步凸显了发展质量的全局和长远意义。”穆虹介绍了党的二十大报告对推动高质量发展作出的战略部署：一是加快构建新发展格局，二是坚定实施创新驱动发展战略、向创新要动力，三是构建高水平社会主义市场经济体制、向改革要活力，四是全面推进乡村振兴，五是着力推进区域协调发展，六是推进高水平对外开放。<strong>把法治建设作为专章论述、专门部署，体现对全面依法治国的高度重视</strong>中央政法委秘书长陈一新表示，党的二十大报告首次单独把法治建设作为专章论述、专门部署，这充分体现了以习近平同志为核心的党中央对全面依法治国的高度重视。陈一新表示，从政治意义上看，这进一步宣示了我们党矢志不渝推进法治建设的坚定决心，彰显了我们党不仅是敢于革命、善于建设、勇于改革的政党，更是信仰法治、坚守法治、建设法治的政党，是我们党坚持全面依法治国的政治宣言。从理论意义上看，这进一步丰富和发展了习近平法治思想，深化了对中国共产党依法执政规律、社会主义法治建设规律、人类社会法治文明发展规律的认识，是我们党推进法治中国建设的纲领性文献。从实践意义上看，这进一步深化和拓展了新时代党和国家工作布局，表明了将全面推进国家各方面工作法治化，是我们党治国理政的重要治理方式。“关于法治建设地位作用、总体要求和重点工作，党的二十大报告作了全面阐述。”陈一新介绍：一是强调遵循法治之“纲”，这个“纲”就是报告提出的新时代法治建设总体要求。二是强调立好法治之“规”，这个“规”就是报告提出的完善以宪法为核心的中国特色社会主义法律体系。三是强调紧扣法治之“重”，这个“重”就是报告提出的扎实推进依法行政。四是强调凸显法治之“要”，这个“要”就是报告提出的严格公正司法。五是强调夯实法治之“基”，这个“基”就是报告提出的加快建设法治社会。<strong>部署深入推进新时代党的建设新的伟大工程，提出健全全面从严治党体系</strong>中央办公厅副主任兼调研室主任唐方裕表示，全面建设社会主义现代化国家、全面推进中华民族伟大复兴，关键在党，关键在党要管党、全面从严治党。完成新时代新征程党的使命任务，必须旗帜鲜明坚持和加强党的全面领导，深入推进新时代党的建设新的伟大工程。党的二十大报告单列一个部分，对“坚定不移全面从严治党，深入推进新时代党的建设新的伟大工程”作出部署，唐方裕介绍这部分内容的主要特点是“四个突出”：突出党的自我革命，突出全面从严治党体系，突出以党的政治建设为统领，突出思想建党和制度治党相结合。党的二十大综合各方面意见，顺应各级党组织和广大党员愿望，对党章作出适当修改。“修改后的党章充分体现马克思主义中国化时代化最新成果，充分体现党的十九大以来党中央提出的治国理政新理念新思想新战略，充分体现党的工作和党的建设的新鲜经验，对于深入推进新时代党的建设新的伟大工程具有重大意义。”唐方裕表示，对于党的二十大关于党的建设的论述和部署，需要把报告和党章结合起来学习理解。在回答记者提问时，唐方裕表示，党的二十大报告提出健全全面从严治党体系，这在党的全国代表大会报告中是首次。我们党作为长期执政的马克思主义政党和世界上第一大政党，党的远大目标和历史使命，党的队伍的庞大规模和广泛分布，党面临的重大风险和严峻挑战，都决定只有整体地而不是局部地、系统地而不是零碎地、持久地而不是短暂地、高标准地而不是一般化地全面从严治党，形成一个布局合理、内容科学、要素齐备、统一高效的全面从严治党体系，才能把我们党建设好。<strong>提出必须时刻保持解决大党独有难题的清醒和坚定，牢记全面从严治党永远在路上、党的自我革命永远在路上</strong>党的二十大报告指出：“全面建设社会主义现代化国家、全面推进中华民族伟大复兴，关键在党。我们党作为世界上最大的马克思主义执政党，要始终赢得人民拥护、巩固长期执政地位，必须时刻保持解决大党独有难题的清醒和坚定。”中央纪委国家监委宣传部部长王建新表示，党的二十大报告要求全党牢记，全面从严治党永远在路上、党的自我革命永远在路上。要围绕坚持党中央集中统一领导强化政治监督，完善党的自我革命制度规范体系，坚持以严的基调强化正风肃纪，坚决打赢反腐败斗争攻坚战持久战。在回答记者提问时，王建新表示，新时代十年，反腐败斗争历程波澜壮阔、成就举世瞩目，但形势依然严峻复杂，同腐败的较量是一场殊死搏斗，只能进、绝不能退，只能赢、绝不能输。必须坚决贯彻党的二十大战略部署，保持压倒性力量常在，不敢腐、不能腐、不想腐同时发力、同向发力、综合发力，坚决打赢反腐败斗争攻坚战持久战。', 2, 1, NULL, 0, 1, '1', '2022-10-25 12:17:46', 0, 0, NULL, 0, '2022-10-25 12:17:46', '2022-10-25 12:17:46');
INSERT INTO `chu_article` VALUES ('O0euTR2F', 'cc', 'CC', 2, 1, NULL, 0, 1, '1', '2022-10-25 14:20:38', 0, 0, NULL, 0, '2022-10-25 14:20:38', '2022-10-25 14:20:38');





-- ----------------------------
-- Table structure for house
-- ----------------------------
DROP TABLE IF EXISTS `house`;
CREATE TABLE `house`  (
                          `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'house唯一标识',
                          `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                          `price` int(11) UNSIGNED NOT NULL COMMENT '价格',
                          `area` int(11) UNSIGNED NOT NULL COMMENT '面积',
                          `room` int(11) UNSIGNED NOT NULL COMMENT '卧室数量',
                          `floor` int(11) UNSIGNED NOT NULL COMMENT '楼层',
                          `total_floor` int(11) UNSIGNED NOT NULL COMMENT '总楼层',
                          `watch_times` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '被看次数',
                          `build_year` int(4) NOT NULL COMMENT '建立年限',
                          `status` int(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '房屋状态 0-未审核 1-审核通过 2-已出租 3-逻辑删除',
                          `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                          `last_update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最近数据更新时间',
                          `city_en_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '城市标记缩写 如 北京bj',
                          `region_en_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地区英文简写 如昌平区 cpq',
                          `cover` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面',
                          `direction` int(11) NOT NULL COMMENT '房屋朝向',
                          `distance_to_subway` int(11) NOT NULL DEFAULT -1 COMMENT '距地铁距离 默认-1 附近无地铁',
                          `parlour` int(11) NOT NULL DEFAULT 0 COMMENT '客厅数量',
                          `district` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所在小区',
                          `admin_id` int(11) NOT NULL COMMENT '所属管理员id',
                          `bathroom` int(11) NOT NULL DEFAULT 0 COMMENT '浴室数量',
                          `street` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '街道',
                          `house_picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                          `house_tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '房屋信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of house
-- ----------------------------
INSERT INTO `house` VALUES (15, '富力城2 国贸CBD 时尚休闲 商务办公', 6200, 70, 1, 10, 20, 3, 2005, 0, '2018-06-26 21:47:37', '2022-11-03 08:00:00', 'bj', 'hdq', '08', 1, -1, 0, '融泽嘉园', 2, 0, '龙域西二路', NULL, NULL);
INSERT INTO `house` VALUES (16, '富力城4 国贸CBD 时尚休闲 商务办公', 6300, 70, 2, 10, 20, 0, 2012, 3, '2018-06-26 21:47:37', '2022-11-03 08:00:00', 'bj', 'hdq', '02', 1, -1, 1, '融泽嘉园', 2, 0, '龙域西二路', NULL, NULL);
INSERT INTO `house` VALUES (17, '二环东直门地铁站附近、王府井、天安门、国贸、三里屯、南锣鼓巷', 3000, 35, 1, 5, 10, 3, 2013, 1, '2018-06-26 21:47:37', '2018-07-03 08:00:00', 'bj', 'hdq', '03', 1, 200, 0, '融泽嘉园', 2, 0, '龙域西二路', NULL, NULL);
INSERT INTO `house` VALUES (18, '华贸城 东向一居挑空loft 干净温馨 随时可以签约', 5700, 52, 1, 7, 20, 0, 2012, 1, '2018-06-26 21:47:37', '2018-07-01 08:00:00', 'bj', 'hdq', '04', 2, 1085, 1, '融泽嘉园', 2, 0, '龙域西二路', NULL, NULL);
INSERT INTO `house` VALUES (19, '望春园板楼三居室 自住精装 南北通透 采光好视野棒！', 9200, 132, 3, 6, 14, 0, 2005, 1, '2018-06-26 21:47:37', '2018-07-01 08:00:00', 'bj', 'hdq', '05', 2, 1108, 2, '融泽嘉园', 2, 0, '龙域西二路', NULL, NULL);
INSERT INTO `house` VALUES (20, '高大上的整租两居室 业主诚意出租', 5400, 56, 2, 12, 20, 0, 2012, 1, '2018-06-26 21:47:37', '2018-07-01 15:11:19', 'bj', 'hdq', '06', 2, 20, 1, '融泽嘉园', 2, 0, '龙域西二路', NULL, NULL);
INSERT INTO `house` VALUES (21, '新康园 正规三居室 精装修 家电家具齐全', 1900, 18, 1, 13, 25, 0, 2012, 1, '2018-06-26 21:47:37', '2018-07-01 15:11:22', 'bj', 'hdq', 'FoFd0gROta6iky72BV099kbMJBix', 3, 1302, 0, '融泽嘉园', 2, 0, '龙域西二路', NULL, NULL);
INSERT INTO `house` VALUES (24, '湖光壹号望京华府183-387㎡阔景大宅', 50000, 288, 5, 1, 1, 0, 2015, 1, '2018-06-26 21:47:37', '2018-07-01 15:11:35', 'bj', 'hdq', '08', 5, 200, 3, '融泽嘉园', 2, 0, '龙域西二路', NULL, NULL);
INSERT INTO `house` VALUES (25, '大豪房', 3000, 59, 2, 10, 20, 0, 2010, 3, '2018-06-26 21:47:37', '2018-06-28 18:28:45', 'bj', 'cpq', 'FgY-eiEW4Ac6FhugH8lafF6akKvG', 2, 1000, 1, '融泽嘉园', 2, 0, '龙域中街', NULL, NULL);
INSERT INTO `house` VALUES (26, '大豪房', 3000, 58, 2, 10, 20, 0, 2018, 1, '2018-06-26 18:33:06', '2018-07-01 15:11:31', 'bj', 'hdq', '10', 2, 1000, 0, '融泽嘉园', 2, 0, '龙城中街', NULL, NULL);
INSERT INTO `house` VALUES (27, '上海大豪房', 10000, 100, 1, 3, 10, 0, 2018, 3, '2018-07-01 15:54:50', '2018-07-01 15:58:01', 'bj', 'dcq', 'Fj-BXYRHROuXsKUzvJiyZwxx25sg', 2, 100, 3, '豪校区', 2, 0, '6街道', NULL, NULL);

-- ----------------------------
-- Table structure for house_detail
-- ----------------------------
DROP TABLE IF EXISTS `house_detail`;
CREATE TABLE `house_detail`  (
                                 `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
                                 `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细描述',
                                 `layout_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '户型介绍',
                                 `traffic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交通出行',
                                 `round_service` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '周边配套',
                                 `rent_way` int(2) NOT NULL COMMENT '租赁方式',
                                 `address` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '详细地址 ',
                                 `subway_line_id` int(11) NULL DEFAULT NULL COMMENT '附近地铁线id',
                                 `subway_line_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附近地铁线名称',
                                 `subway_station_id` int(11) NULL DEFAULT NULL COMMENT '地铁站id',
                                 `subway_station_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地铁站名',
                                 `house_id` int(11) NOT NULL COMMENT '对应house的id',
                                 PRIMARY KEY (`id`) USING BTREE,
                                 UNIQUE INDEX `index_on_house_id`(`house_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of house_detail
-- ----------------------------
INSERT INTO `house_detail` VALUES (21, '国贸CBD商务区,近SOHO现代城,富顿中心,富力城商业街区,乐成中心,潘家园古玩城,八王坟长途客运站,北京游乐园,经由三环路可直达首都机场。附近有双井桥南,双井桥北,双井桥东双井桥西等30多条公交站牌!\n《天安门,故宫,王府井,三里屯,前门,天坛,北海,颐和园,雍和宫,奥林匹克公园,水立方,西单,欢乐谷,燕莎商城等》知名购物区及旅游名胜古迹,是您休闲旅游及商务下榻的理想选择', '房间采光良好,落地窗外景色宜人', '房子处于北京的CBD商务中心区国贸双井!紧邻双井地铁站,步行5分钟即到!这离国贸、中央电视台、潘家园、三里屯、团结湖、日坛使馆区、儿研所、大郊亭都很近', '房子闹中取静,地理位置优越,交通方便,紧邻呼家楼地铁站和东大桥地铁站;去机场可乘坐东直门机场快轨,非常方便｡购物中心有双井购物中心、国贸购物中心和侨福芳草地购物中心、三里屯购物中心等,远道而来的朋友可尽览都市璀璨!', 0, '二号院7号楼', 4, '10号线', 58, '双井', 15);
INSERT INTO `house_detail` VALUES (22, '国贸CBD商务区,近SOHO现代城,富顿中心,富力城商业街区,乐成中心,潘家园古玩城,八王坟长途客运站,北京游乐园,经由三环路可直达首都机场。附近有双井桥南,双井桥北,双井桥东双井桥西等30多条公交站牌!\n《天安门,故宫,王府井,三里屯,前门,天坛,北海,颐和园,雍和宫,奥林匹克公园,水立方,西单,欢乐谷,燕莎商城等》知名购物区及旅游名胜古迹,是您休闲旅游及商务下榻的理想选择!', '房间采光良好,落地窗外景色宜人', '房子处于北京的CBD商务中心区国贸双井!紧邻双井地铁站,步行5分钟即到', '这离国贸、中央电视台、潘家园、三里屯、团结湖、日坛使馆区、儿研所、大郊亭都很近。房子闹中取静,地理位置优越,交通方便,紧邻呼家楼地铁站和东大桥地铁站;去机场可乘坐东直门机场快轨,非常方便｡购物中心有双井购物中心、国贸购物中心和侨福芳草地购物中心、三里屯购物中心等,远道而来的朋友可尽览都市璀璨！', 0, '1号院1号楼', 1, '13号线', 5, '上地', 16);
INSERT INTO `house_detail` VALUES (24, '我和我女盆友当房东已经一年了,也是超赞房东,希望能为大家提供舒适的住所~ 房间的大门和房门都是密码门,小区有保安24小时值班,非常安全方便。 通常入住时间是下午三点,提前来的同学可以先寄存行李和洗澡哦~\n\n', '房間非常漂亮,空間很大,鵝黃色的牆壁看起來非常舒服', '位置距離地鐵站不遠', '距故宫、天安门、王府井、三里屯、簋街、南锣鼓巷等景点均可地铁半小时内到达,交通便利~', 1, '1号院2号楼', 1, '13号线', 16, '东直门', 17);
INSERT INTO `house_detail` VALUES (25, '这个经纪人很懒，没写核心卖点', '此房是一居室的格局，上下两层，面宽，房间亮堂，进门右手厨房，正前方是25平米的客厅，楼上是卧室，带洗手间！ 喧闹和安静隔开，适合居住', '小区距离地铁13号线北苑站500米的距离，交通出行便利....', '小区楼下就是华贸天地娱乐街，保利电影院，眉州东坡，中信银行，麦当劳等娱乐休闲设施齐全', 0, '1号院3号楼', 1, '13号线', 11, '北苑', 18);
INSERT INTO `house_detail` VALUES (26, '这个经纪人很懒，没写核心卖点', '此房为望春园小区板楼南北通透户型，主卧客厅朝南，次卧朝北，两个客厅双卫，居住很舒适。', '距离地铁5号线立水桥南站630米，有464,465,966,081，621等多条公交线路，交通出行四通八达。', '小区旁有大型购物商场易事达，物美超市，丰宁蔬菜基地，航空总医院、安贞医院北苑分院，中国银行、中国农业银行、中国工商银行、中国交通银行、中国建设银行、招商银行分布。小区旁有天奥健身房，还有立水桥公园..', 0, '6号院1号楼', 1, '13号线', 10, '立水桥', 19);
INSERT INTO `house_detail` VALUES (27, '高大上的整租两居室 业主诚意出租\n1、客厅挑高、宽敞舒适、阳光充足 2、卧室搭配的很新颖，使用之高 3、厨房带阳台，让您和家人有足够的空间展现私家厨艺', '客厅挑高、宽敞舒适、阳光充足 2、卧室搭配的很新颖，使用之高 3、厨房带阳台，让您和家人有足够的空间展现私家厨艺', '近地铁13号线东直门站', '社区环境好，环境优美，适宜居住，人文素质高，物业管理完善； 2、属于低密度社区 ，适宜居住 3、小区的林密树多，让您感受花园一样的家', 1, '1号院5号楼', 1, '13号线', 16, '东直门', 20);
INSERT INTO `house_detail` VALUES (28, '房子是正规三室一厅一厨一卫，装修保持的不错，家电家具都齐全。\n', '房子客厅朝北面积比较大，主卧西南朝向，次卧朝北，另一个次卧朝西，两个次卧面积差不多大。', '小区出南门到8号线育新地铁站614米，交通便利，小区500米范围内有物美，三旗百汇，龙旗广场等几个比较大的商场，生活购物便利，出小区北门朝东952米是地铁霍营站，是8号线和 13号线的换乘站，同时还有个S2线，通往怀来。（数据来源百度地图）', '小区西边300米就是物美超市和三旗百汇市场（日常百货、粮油米面、瓜果蔬菜、生鲜海货等等，日常生活很便利，消费成本低），北边200米是龙旗购物广场和永辉超市（保利影院，KFC，麦当劳等，轻松满足娱乐消费）。小区里还有商店，饭店，家政等。', 0, '2号院1号楼', 1, '13号线', 9, '霍营', 21);
INSERT INTO `house_detail` VALUES (31, '懒死了 不谢', '户型介绍', '交通出行', '周边配套', 0, '3号院1号楼', 1, '13号线', 12, '望京西', 24);
INSERT INTO `house_detail` VALUES (32, '房屋描述-编辑', '户型介绍', '交通出行', '周边配套-编辑', 0, '3号院2单元1003', 1, '13号线', 8, '回龙观', 25);
INSERT INTO `house_detail` VALUES (33, '超级big big的豪房', '户型介绍', '交通出行', '学校、语言', 0, '3号楼2单元100', 1, '13号线', 8, '回龙观', 26);
INSERT INTO `house_detail` VALUES (34, '豪房校区', '客厅挑高、宽敞舒适、阳光充足 2、卧室搭配的很新颖，使用之高 3、厨房带阳台，让您和家人有足够的空间展现私家厨艺', '交通出行', '社区环境好，环境优美，适宜居住，人文素质高，物业管理完善； 2、属于低密度社区 ，适宜居住 3、小区的林密树多，让您感受花园一样的家', 0, '1号院5号楼', 1, '13号线', 5, '上地', 27);

-- ----------------------------
-- Table structure for house_picture
-- ----------------------------
DROP TABLE IF EXISTS `house_picture`;
CREATE TABLE `house_picture`  (
                                  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                                  `house_id` int(11) NOT NULL COMMENT '所属房屋id',
                                  `cdn_prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片路径',
                                  `width` int(11) NULL DEFAULT NULL COMMENT '宽',
                                  `height` int(11) NULL DEFAULT NULL COMMENT '高',
                                  `location` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属房屋位置',
                                  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件名',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '房屋图片信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of house_picture
-- ----------------------------
INSERT INTO `house_picture` VALUES (68, 19, 'http://pav17qjlw.bkt.clouddn.com/', 911, 683, NULL, '01');
INSERT INTO `house_picture` VALUES (69, 19, 'http://pav17qjlw.bkt.clouddn.com/', 1012, 683, NULL, '02');
INSERT INTO `house_picture` VALUES (70, 24, 'http://pav17qjlw.bkt.clouddn.com/', 1280, 960, NULL, '03');
INSERT INTO `house_picture` VALUES (71, 24, 'http://pav17qjlw.bkt.clouddn.com/', 1024, 683, NULL, '04');
INSERT INTO `house_picture` VALUES (72, 21, 'http://pav17qjlw.bkt.clouddn.com/', 1024, 683, NULL, '05');
INSERT INTO `house_picture` VALUES (73, 21, 'http://pav17qjlw.bkt.clouddn.com/', 455, 683, NULL, '06');
INSERT INTO `house_picture` VALUES (74, 20, 'http://pav17qjlw.bkt.clouddn.com/', 1024, 683, NULL, '07');
INSERT INTO `house_picture` VALUES (75, 20, 'http://pav17qjlw.bkt.clouddn.com/', 1024, 683, NULL, '08');
INSERT INTO `house_picture` VALUES (76, 18, 'http://pav17qjlw.bkt.clouddn.com/', 1440, 960, NULL, '09');
INSERT INTO `house_picture` VALUES (77, 18, 'http://pav17qjlw.bkt.clouddn.com/', 1024, 683, NULL, '10');
INSERT INTO `house_picture` VALUES (78, 17, 'http://pav17qjlw.bkt.clouddn.com/', 1024, 683, NULL, '01');
INSERT INTO `house_picture` VALUES (79, 17, 'http://pav17qjlw.bkt.clouddn.com/', 1024, 683, NULL, '02');
INSERT INTO `house_picture` VALUES (80, 16, 'http://pav17qjlw.bkt.clouddn.com/', 1024, 683, NULL, '03');
INSERT INTO `house_picture` VALUES (81, 16, 'http://pav17qjlw.bkt.clouddn.com/', 1024, 683, NULL, '04');
INSERT INTO `house_picture` VALUES (82, 16, 'http://pav17qjlw.bkt.clouddn.com/', 1024, 683, NULL, '05');
INSERT INTO `house_picture` VALUES (83, 15, 'http://pav17qjlw.bkt.clouddn.com/', 1024, 683, NULL, '06');
INSERT INTO `house_picture` VALUES (85, 15, 'http://pav17qjlw.bkt.clouddn.com/', 1440, 960, NULL, '08');
INSERT INTO `house_picture` VALUES (86, 26, 'http://pav17qjlw.bkt.clouddn.com/', 768, 512, NULL, '09');
INSERT INTO `house_picture` VALUES (87, 25, 'http://pav17qjlw.bkt.clouddn.com/', 984, 768, NULL, 'Fosusezn1DsJnDhHfITVV8BFRzkd');
INSERT INTO `house_picture` VALUES (88, 25, 'http://pav17qjlw.bkt.clouddn.com/', 984, 768, NULL, 'FgY-eiEW4Ac6FhugH8lafF6akKvG');
INSERT INTO `house_picture` VALUES (89, 21, 'http://pav17qjlw.bkt.clouddn.com/', 979, 807, NULL, 'FoFd0gROta6iky72BV099kbMJBix');
INSERT INTO `house_picture` VALUES (90, 27, 'http://pav17qjlw.bkt.clouddn.com/', 1000, 612, NULL, 'Fj-BXYRHROuXsKUzvJiyZwxx25sg');

-- ----------------------------
-- Table structure for house_subscribe
-- ----------------------------
DROP TABLE IF EXISTS `house_subscribe`;
CREATE TABLE `house_subscribe`  (
                                    `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
                                    `house_id` int(11) NOT NULL COMMENT '房源id',
                                    `user_id` int(11) NOT NULL COMMENT '用户id',
                                    `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户描述',
                                    `status` int(2) NOT NULL DEFAULT 0 COMMENT '预约状态 1-加入待看清单 2-已预约看房时间 3-看房完成',
                                    `create_time` datetime(0) NOT NULL COMMENT '数据创建时间',
                                    `last_update_time` datetime(0) NOT NULL COMMENT '记录更新时间',
                                    `order_time` datetime(0) NULL DEFAULT NULL COMMENT '预约时间',
                                    `telephone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
                                    `admin_id` int(11) NOT NULL COMMENT '房源发布者id',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE INDEX `index_on_user_and_house`(`house_id`, `user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '预约看房信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of house_subscribe
-- ----------------------------
INSERT INTO `house_subscribe` VALUES (12, 15, 10, NULL, 3, '2018-07-01 22:46:03', '2018-07-01 22:46:16', '2018-07-02 00:00:00', '13888888888', 2);
INSERT INTO `house_subscribe` VALUES (13, 17, 2, NULL, 3, '2018-07-03 16:25:49', '2018-07-03 16:26:15', '2018-07-04 00:00:00', '18853850556', 2);

-- ----------------------------
-- Table structure for house_tag
-- ----------------------------
DROP TABLE IF EXISTS `house_tag`;
CREATE TABLE `house_tag`  (
                              `house_id` int(11) NOT NULL COMMENT '房屋id',
                              `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签id',
                              `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                              PRIMARY KEY (`id`) USING BTREE,
                              UNIQUE INDEX `index_on_house_id_and_name`(`house_id`, `name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '房屋标签映射关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of house_tag
-- ----------------------------
INSERT INTO `house_tag` VALUES (15, 23, '光照充足');
INSERT INTO `house_tag` VALUES (15, 18, '独立阳台');
INSERT INTO `house_tag` VALUES (16, 16, '光照充足');
INSERT INTO `house_tag` VALUES (17, 15, '随时看房');
INSERT INTO `house_tag` VALUES (17, 14, '集体供暖');
INSERT INTO `house_tag` VALUES (18, 13, '精装修');
INSERT INTO `house_tag` VALUES (19, 12, '独立卫生间');
INSERT INTO `house_tag` VALUES (19, 11, '独立阳台');
INSERT INTO `house_tag` VALUES (21, 19, '光照充足');
INSERT INTO `house_tag` VALUES (21, 20, '独立卫生间');
INSERT INTO `house_tag` VALUES (24, 10, '光照充足');
INSERT INTO `house_tag` VALUES (24, 3, '精装修');
INSERT INTO `house_tag` VALUES (24, 8, '集体供暖');
INSERT INTO `house_tag` VALUES (25, 21, '独立阳台');
INSERT INTO `house_tag` VALUES (26, 22, '独立阳台');

-- ----------------------------
-- Table structure for subway
-- ----------------------------
DROP TABLE IF EXISTS `subway`;
CREATE TABLE `subway`  (
                           `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
                           `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '线路名',
                           `city_en_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属城市英文名缩写',
                           PRIMARY KEY (`id`) USING BTREE,
                           INDEX `index_on_city`(`city_en_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subway
-- ----------------------------
INSERT INTO `subway` VALUES (1, '13号线', 'bj');
INSERT INTO `subway` VALUES (2, '1号线', 'bj');
INSERT INTO `subway` VALUES (3, '2号线', 'bj');
INSERT INTO `subway` VALUES (4, '10号线', 'bj');
INSERT INTO `subway` VALUES (5, '8号线', 'bj');
INSERT INTO `subway` VALUES (6, '9号线', 'bj');
INSERT INTO `subway` VALUES (7, '7号线', 'bj');

-- ----------------------------
-- Table structure for subway_station
-- ----------------------------
DROP TABLE IF EXISTS `subway_station`;
CREATE TABLE `subway_station`  (
                                   `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
                                   `subway_id` int(11) NOT NULL COMMENT '所属地铁线id',
                                   `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '站点名称',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   UNIQUE INDEX `unique_station`(`subway_id`, `name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subway_station
-- ----------------------------
INSERT INTO `subway_station` VALUES (5, 1, '上地');
INSERT INTO `subway_station` VALUES (16, 1, '东直门');
INSERT INTO `subway_station` VALUES (4, 1, '五道口');
INSERT INTO `subway_station` VALUES (14, 1, '光熙门');
INSERT INTO `subway_station` VALUES (11, 1, '北苑');
INSERT INTO `subway_station` VALUES (8, 1, '回龙观');
INSERT INTO `subway_station` VALUES (2, 1, '大钟寺');
INSERT INTO `subway_station` VALUES (12, 1, '望京西');
INSERT INTO `subway_station` VALUES (15, 1, '柳芳');
INSERT INTO `subway_station` VALUES (3, 1, '知春路');
INSERT INTO `subway_station` VALUES (10, 1, '立水桥');
INSERT INTO `subway_station` VALUES (13, 1, '芍药居');
INSERT INTO `subway_station` VALUES (6, 1, '西二旗');
INSERT INTO `subway_station` VALUES (1, 1, '西直门');
INSERT INTO `subway_station` VALUES (9, 1, '霍营');
INSERT INTO `subway_station` VALUES (7, 1, '龙泽');
INSERT INTO `subway_station` VALUES (33, 4, '三元家庄');
INSERT INTO `subway_station` VALUES (51, 4, '三元桥');
INSERT INTO `subway_station` VALUES (41, 4, '丰台站');
INSERT INTO `subway_station` VALUES (52, 4, '亮马桥');
INSERT INTO `subway_station` VALUES (27, 4, '健德门');
INSERT INTO `subway_station` VALUES (46, 4, '公主坟');
INSERT INTO `subway_station` VALUES (44, 4, '六里桥');
INSERT INTO `subway_station` VALUES (53, 4, '农业展览馆');
INSERT INTO `subway_station` VALUES (62, 4, '分钟寺');
INSERT INTO `subway_station` VALUES (59, 4, '劲松');
INSERT INTO `subway_station` VALUES (28, 4, '北土城');
INSERT INTO `subway_station` VALUES (61, 4, '十里河');
INSERT INTO `subway_station` VALUES (58, 4, '双井');
INSERT INTO `subway_station` VALUES (55, 4, '呼家楼');
INSERT INTO `subway_station` VALUES (54, 4, '团结湖');
INSERT INTO `subway_station` VALUES (57, 4, '国贸');
INSERT INTO `subway_station` VALUES (35, 4, '大红门');
INSERT INTO `subway_station` VALUES (32, 4, '太阳宫');
INSERT INTO `subway_station` VALUES (29, 4, '安贞门');
INSERT INTO `subway_station` VALUES (64, 4, '宋家庄');
INSERT INTO `subway_station` VALUES (20, 4, '巴沟');
INSERT INTO `subway_station` VALUES (30, 4, '惠新西街南口');
INSERT INTO `subway_station` VALUES (48, 4, '慈寿寺');
INSERT INTO `subway_station` VALUES (63, 4, '成寿寺');
INSERT INTO `subway_station` VALUES (42, 4, '泥洼');
INSERT INTO `subway_station` VALUES (22, 4, '海淀黄庄');
INSERT INTO `subway_station` VALUES (60, 4, '潘家园');
INSERT INTO `subway_station` VALUES (19, 4, '火器营');
INSERT INTO `subway_station` VALUES (26, 4, '牡丹园');
INSERT INTO `subway_station` VALUES (24, 4, '知春路');
INSERT INTO `subway_station` VALUES (23, 4, '知春里');
INSERT INTO `subway_station` VALUES (34, 4, '石榴庄');
INSERT INTO `subway_station` VALUES (39, 4, '纪家庙');
INSERT INTO `subway_station` VALUES (31, 4, '芍药居');
INSERT INTO `subway_station` VALUES (21, 4, '苏州街');
INSERT INTO `subway_station` VALUES (38, 4, '草桥');
INSERT INTO `subway_station` VALUES (45, 4, '莲花桥');
INSERT INTO `subway_station` VALUES (25, 4, '西土城');
INSERT INTO `subway_station` VALUES (43, 4, '西局');
INSERT INTO `subway_station` VALUES (47, 4, '西钓鱼台');
INSERT INTO `subway_station` VALUES (36, 4, '角门东');
INSERT INTO `subway_station` VALUES (37, 4, '角门西');
INSERT INTO `subway_station` VALUES (17, 4, '车道沟');
INSERT INTO `subway_station` VALUES (56, 4, '金台夕照');
INSERT INTO `subway_station` VALUES (18, 4, '长春桥');
INSERT INTO `subway_station` VALUES (40, 4, '首经贸');

-- ----------------------------
-- Table structure for support_address
-- ----------------------------
DROP TABLE IF EXISTS `support_address`;
CREATE TABLE `support_address`  (
                                    `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
                                    `belong_to` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '上一级行政单位名',
                                    `en_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '行政单位英文名缩写',
                                    `cn_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '行政单位中文名',
                                    `level` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '行政级别 市-city 地区-region',
                                    `baidu_map_lng` double NOT NULL COMMENT '百度地图经度',
                                    `baidu_map_lat` double NOT NULL COMMENT '百度地图纬度',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE INDEX `unique_en_name_and_belong_to`(`en_name`, `level`, `belong_to`) USING BTREE COMMENT '每个城市的英文名都是独一无二的'
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of support_address
-- ----------------------------
INSERT INTO `support_address` VALUES (4, 'bj', 'bj', '北京', 'city', 116.395645, 39.929986);
INSERT INTO `support_address` VALUES (5, 'sh', 'sh', '上海', 'city', 121.487899, 31.249162);
INSERT INTO `support_address` VALUES (6, 'hb', 'sjz', '石家庄', 'city', 114.522082, 38.048958);
INSERT INTO `support_address` VALUES (7, 'hb', 'ts', '唐山', 'city', 118.183451, 39.650531);
INSERT INTO `support_address` VALUES (8, 'hb', 'hd', '邯郸', 'city', 114.482694, 36.609308);
INSERT INTO `support_address` VALUES (9, 'bj', 'dcq', '东城区', 'region', 116.42188470126446, 39.93857401298612);
INSERT INTO `support_address` VALUES (10, 'bj', 'xcq', '西城区', 'region', 116.37319010401802, 39.93428014370851);
INSERT INTO `support_address` VALUES (12, 'bj', 'hdq', '海淀区', 'region', 116.23967780102151, 40.03316204507791);
INSERT INTO `support_address` VALUES (13, 'bj', 'cpq', '昌平区', 'region', 116.21645635689414, 40.2217235498323);
INSERT INTO `support_address` VALUES (14, 'sh', 'ptq', '普陀区', 'region', 121.39844294374956, 31.263742929075534);
INSERT INTO `support_address` VALUES (15, 'sjz', 'caq', '长安区', 'region', 114.59262155387033, 38.07687479578663);
INSERT INTO `support_address` VALUES (16, 'sjz', 'qdq', '桥东区', 'region', 114.51078430496142, 38.06338975380927);
INSERT INTO `support_address` VALUES (17, 'sjz', 'qxq', '桥西区', 'region', 114.43813995531943, 38.033364550068136);
INSERT INTO `support_address` VALUES (18, 'sjz', 'xhq', '新华区', 'region', 114.4535014286928, 38.117218640478164);
INSERT INTO `support_address` VALUES (19, 'bj', 'cyq', '朝阳区', 'region', 116.52169489108084, 39.95895316640668);
