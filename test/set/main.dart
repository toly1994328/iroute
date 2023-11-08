void main(){
  List<String> l1 = ['/a','/a/1'];
  List<String> l2 = ['/b','/b/1'];
  List<String> l3 = ['/a','/a/2'];
  List<String> l4 = ['/a','/a/3'];

  Set result = {...l4,...l1,...l2,...l3,};
  print(result);


}