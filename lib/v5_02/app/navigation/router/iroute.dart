class IRoute {
  final String path;
  final List<IRoute> children;

  const IRoute({required this.path, this.children = const []});

  @override
  String toString() {
    return 'IRoute{path: $path, children: $children}';
  }

  List<String> list(){

    return [];
  }

}


const List<IRoute> kDestinationsIRoutes = [
  IRoute(
    path: '/color',
    children: [
      IRoute(path: '/color/add'),
      IRoute(path: '/color/detail'),
    ],
  ),
  IRoute(
    path: '/counter',
  ),
  IRoute(
    path: '/user',
  ),
  IRoute(
    path: '/settings',
  ),
];
