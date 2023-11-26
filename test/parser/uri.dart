import 'path_utils.dart';

void main() {
  String pattern = '/user/:id/book/:bookId';
  String path = '/user/001/book/card';

  parserPath();
  // List<String> params = [];
  // RegExp regExp = patternToRegExp(pattern,params);
  //
  //
  // bool data = regExp.hasMatch(path);
  // List<RegExpMatch> matchs = regExp.allMatches(path).toList();
  // Map<String,String?> pathParams = {};
  // if(matchs.isNotEmpty){
  //
  //   for(int i=0;i<params.length;i++){
  //    String? value = matchs.first.namedGroup(params[i]);
  //    pathParams[params[i]] = value;
  //   }
  // }
  //
  // print(pathParams);
  // print(regExp.pattern);
  //
  // // match.forEach((element) {
  // //   print(element.namedGroup('id'));
  // // });
  // // regExp
  // print(params);
  // String ret = patternToPath(pattern, {
  //   'id':'0',
  //   'bookId':'card',
  // });
  // print(regExp);
  // print(ret);
}

void parserPath() {
  String template = '/user/:id/book/:bookId';
  String path = '/user/001/book/card';
  List<String> keys = [];
  RegExp regExp = patternToRegExp(template,keys);
  Map<String, String?> pathParams = {};
  RegExpMatch? match = regExp.firstMatch(path);

  if (match != null) {
    for (int i = 0; i < keys.length; i++) {
      String? value = match.namedGroup(keys[i]);
      pathParams[keys[i]] = value;
    }
  }
  print(pathParams);
}


final RegExp _parameterRegExp = RegExp(r':(\w+)(\((?:\\.|[^\\()])+\))?');

RegExp patternToRegExp(String pattern, List<String> parameters) {
  final StringBuffer buffer = StringBuffer('^');
  int start = 0;
  for (final RegExpMatch match in _parameterRegExp.allMatches(pattern)) {
    if (match.start > start) {
      buffer.write(RegExp.escape(pattern.substring(start, match.start)));
    }
    final String name = match[1]!;
    final String? optionalPattern = match[2];
    final String regex = optionalPattern != null
        ? _escapeGroup(optionalPattern, name)
        : '(?<$name>[^/]+)';
    buffer.write(regex);
    parameters.add(name);
    start = match.end;
  }

  if (start < pattern.length) {
    buffer.write(RegExp.escape(pattern.substring(start)));
  }

  if (!pattern.endsWith('/')) {
    buffer.write(r'(?=/|$)');
  }
  return RegExp(buffer.toString(), caseSensitive: false);
}

String _escapeGroup(String group, [String? name]) {
  final String escapedGroup = group.replaceFirstMapped(
      RegExp(r'[:=!]'), (Match match) => '\\${match[0]}');
  if (name != null) {
    return '(?<$name>$escapedGroup)';
  }
  return escapedGroup;
}

void parser() {
  String path =
      'http://user:pwd@toly1994.com:8080/path1/path2?key1=value1&key2=value2#fragment';
  Uri? uri = Uri.tryParse(path);
  if (uri == null) return;
  print(uri.scheme); // http
  print(uri.userInfo); // user:pwd
  print(uri.host); // toly1994.com
  print(uri.port); // 8080
  print(uri.path); // /path1/path2
  print(uri.query); // key1=value1&key2=value2
  print(uri.fragment); // fragment
}
