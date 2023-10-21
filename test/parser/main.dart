// import 'package:iroute/13/04/app/navigation/router/iroute.dart';
//
// void main() {
//   String path = '/color/detail/a';
//   // List<String> parts = path.split('/');
//   // print(parts);
//   // print(parserPath(path));
//
//   Uri uri = Uri.parse(path);
//   print(uri.fragment);
//   print(uri.pathSegments);
//
//   List<String> parts = uri.pathSegments;
//
//   parts =  List.of(parts)..removeLast();
//   String result = parts.join('/');
//   print(result);
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