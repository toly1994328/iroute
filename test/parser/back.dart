void main(){
  print(backPath('/a/c/d?k=v'));
}

String backPath(String path){
  Uri uri = Uri.parse(path);
  List<String> parts = List.of(uri.pathSegments)..removeLast();
  return '/${parts.join('/')}';
}