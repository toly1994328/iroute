// import 'package:iroute/10/more_pop_icon.dart';
// import 'package:iroute/13/04/app/navigation/router/iroute.dart';
//
// void main() {
//   bool b = MenuAction.help > MenuAction.about;
//   print(b);
// }
//
//
// IRoute? parserPath(String path){
//
//   List<String> parts = path.split('/');
//   String lever1 = '/${parts[1]}';
//   List<IRoute> iRoutes = kDestinationsIRoutes.where((e) => e.path == lever1).toList();
//
//   int counter = 2;
//
//   IRoute? result;
//   String check = lever1;
//   List<IRoute> children = iRoutes.first.children;
//
//   check = check +"/" + parts[counter];
//
//   for(int i = 0;i<children.length;i++){
//
//     String path = children[i].path;
//     if(path == check){
//       result = children[i];
//       break;
//     }
//     // String path =
//     // result.children.add(IRoute(path: parts[i]);
//   }
//   return result;
// }