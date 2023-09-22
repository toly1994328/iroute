import 'package:toly_menu/toly_menu.dart';

List<MenuData> menus = [
  MenuData(path: '/dashboard', label: '总览面板', children: [
    MenuData(path: '/dashboard/data_analyse', label: '数据分析', deep: 1),
    MenuData(path: '/dashboard/work_board', label: '工作台', deep: 1, children: [
      MenuData(path: '/dashboard/work_board/a', label: '第一工作区', deep: 2),
      MenuData(path: '/dashboard/work_board/b', label: '第二工作区', deep: 2),
      MenuData(path: '/dashboard/work_board/c', label: '第三工作区', deep: 2),
    ]),
  ]),
  MenuData(path: '/cases', label: '案例演示', children: [
    MenuData(path: '/cases/counter', label: '计数器项目', deep: 1),
    MenuData(path: '/cases/guess', label: '猜数字项目', deep: 1),
    MenuData(path: '/cases/muyu', label: '电子木鱼项目', deep: 1),
    MenuData(path: '/cases/canvas', label: '白板绘制项目', deep: 1),
    MenuData(path: '/cases/timer', label: '计时器项目', deep: 1),
  ]),
  MenuData(path: '/manager', label: '系统管理', children: [
    MenuData(path: '/manager/account', label: '账号管理', deep: 1),
    MenuData(path: '/manager/role', label: '角色管理', deep: 1),
    MenuData(path: '/manager/menu', label: '菜单管理', deep: 1),
  ]),
  MenuData(path: '/knowledge', label: '知识库管理', children: [
    MenuData(path: '/knowledge/a', label: '语文知识', deep: 1, children: [
      MenuData(
        path: '/knowledge/a/1',
        label: '诗词歌赋',
        deep: 2,
      ),
      MenuData(
        path: '/knowledge/a/2',
        label: '人物故事',
        deep: 2,
      ),
      MenuData(
        path: '/knowledge/a/3',
        label: '名著推荐',
        deep: 2,
      )
    ]),
    MenuData(
        path: '/knowledge/b',
        label: '数学知识',
        children: [
          MenuData(
            path: '/knowledge/b/1',
            label: '人物故事',
            deep: 2,
          ),
          MenuData(
            path: '/knowledge/b/2',
            label: '数学定理',
            deep: 2,
          ),
          MenuData(
            path: '/knowledge/b/3',
            label: '几何知识',
            deep: 2,
          ),
          MenuData(
            path: '/knowledge/b/4',
            label: '代数知识',
            deep: 2,
          )
        ],
        deep: 1),
    MenuData(
      path: '/knowledge/c',
      label: '英语知识',
      deep: 1,
    ),
  ]),
  MenuData(path: '/widgets', label: '组件集录', children: [
    MenuData(path: '/widgets/stateless', label: '无状态组件', deep: 1),
    MenuData(path: '/widgets/stateful', label: '有状态组件', deep: 1),
    MenuData(path: '/widgets/single_child', label: '单子渲染组件', deep: 1),
    MenuData(path: '/widgets/mutli_child', label: '多子渲染组件', deep: 1),
    MenuData(path: '/widgets/sliver', label: '滑片组件', deep: 1),
    MenuData(path: '/widgets/proxy', label: '代理组件', deep: 1),
    MenuData(path: '/widgets/other', label: '其他组件', deep: 1),
  ])
];
