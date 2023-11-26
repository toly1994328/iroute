
void main(){
  //  创建一个 2->4->3 的链表对象
  ListNode listNode = ListNode(2,next: ListNode(4,next: ListNode(3)));

  // 并完成 ListNode#toString 方法，打印 243
  print(listNode);
}

class ListNode {
  int val;
  ListNode? next;

  ListNode(this.val, {this.next});

  @override
  String toString(){
    ListNode? cur = this;
    String result = "";
    while( cur!=null){
      result = result +cur.val.toString();
      cur = cur.next;
    }
    return result;
  }
}