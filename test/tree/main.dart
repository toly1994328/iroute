import 'node.dart';

main(){
  /// 需求:在树中寻找满足需求的节点列表
  /// input: 2-3-1
  /// 输出节点 2, 2-3,2-3-1
  // findNodes(root, '2-2', 0,'');
  // List<Node> nodes = findNodes(root, '2-3-1', 0,'',[]);
  List<Node> nodes = find( '/2/3/1');
  print(nodes);
}

List<Node> find(String input){
  String fixInput = input.substring(1);
  List<Node> nodes = findNodes(root2,fixInput,0,'/',[]);
  if(nodes.isNotEmpty&&nodes.last.value!=input){
    return [];
  }
  return nodes;
}


List<Node> findNodes(Node node,String input,int deep,String prefix,List<Node> result){
  List<String> parts = input.split('/');
  if(deep>parts.length-1){
    return result;
  }
  String target = parts[deep];
  if(node.children.isNotEmpty){
    List<Node> nodes = node.children.where((e) => e.value==prefix+target).toList();
    bool match = nodes.isNotEmpty;
    if(match){
      Node matched = nodes.first;
      result.add(matched);
      String nextPrefix = '${matched.value}/';
      findNodes(matched, input, ++deep,nextPrefix,result);
    }
  }else{
    return result;
  }
  return result;
}

// List<Node> findNodes(Node node,String input,int deep,String prefix,List<Node> result){
//   List<String> parts = input.split('-');
//   if(deep>parts.length-1){
//     return result;
//   }
//   String target = parts[deep];
//     if(node.children.isNotEmpty){
//       List<Node> nodes = node.children.where((e) => e.value==prefix+target).toList();
//       bool match = nodes.isNotEmpty;
//       if(match){
//         Node matched = nodes.first;
//         result.add(matched);
//         String nextPrefix = '${matched.value}-';
//         findNodes(matched, input, ++deep,nextPrefix,result);
//       }
//   }else{
//       return result;
//   }
//   return result;
// }