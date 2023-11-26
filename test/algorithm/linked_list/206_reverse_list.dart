
void main(){
  /// 打印 1->9->9->4
  ListNode listNode = ListNode(1, ListNode(9, ListNode(9,ListNode(4))));
  print(listNode);
  ListNode? result = listNode.reverseList(listNode);
  print(result);
}

class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);

  @override
  String toString(){
    ListNode? cur = this;
    String result = "";
    while( cur!=null){
      result = result +cur.val.toString();
      cur = cur.next;
      if(cur!=null){
        result +='->';
      }
    }
    return result;
  }

  ListNode? reverseList(ListNode? head) {
    if (head == null || head.next == null) return head;
    ListNode? pre = reverseList(head.next);
    head.next?.next = head;
    head.next = null;
    return pre;
  }
}



