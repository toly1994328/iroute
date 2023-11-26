/// 两数相加
// 给你两个非空的链表表示两个非负的整数。
// 它们每位数字都是按照逆序 的方式存储的，并且每个节点只能存储一位数字

//  请你将两个数相加，并以相同形式返回一个表示和的链表。
// 你可以假设除了数字  之外，这两个数都不会以  开头。
//输入: 1=[2,4,3]， 2=[5,6,4] 输出:[7,0,8] 解释: 342 + 465 = 807.
void main() {
  // l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
  ListNode l1 = ListNode(2, next: ListNode(4, next: ListNode(3)),);
  ListNode l2 = ListNode(5, next: ListNode(6, next: ListNode(4)),);

  //9,9,9,9,9,9,9
  // ListNode l1 = ListNode(9, next: ListNode(9, next: ListNode(9, next: ListNode(9, next: ListNode(9, next: ListNode(9, next: ListNode(9, next: ListNode(9, next: ListNode(9)))))))));
  // ListNode l2 = ListNode(9, next: ListNode(9, next: ListNode(9,next: ListNode(9)),));
  ListNode result = addTwoNumbers(l1, l2);
  print(result);
}

class ListNode {
  int val;
  ListNode? next;

  ListNode(this.val, {this.next});

  @override
  String toString(){
    String result='';
    ListNode? cur = this;
    while(cur!=null){
      result += cur.val.toString();
      cur = cur.next;
    }
    return result;
  }

}

// ListNode? addTwoNumbers(ListNode? l1, ListNode? l2) {
//   if (l1 == null) {
//     return l2;
//   }
//   if (l2 == null) {
//     return l1;
//   }
//   ListNode? l3 = ListNode(0);
//   ListNode? cur = l3;
//   int temp = 0;
//   while (l1 != null || l2 != null) {
//     int val1 = l1 == null ? 0 : l1.val;
//     int val2 = l2 == null ? 0 : l2.val;
//     int sum = val1 + val2 + temp;
//     cur?.next = ListNode(sum % 10);
//     temp = sum ~/ 10;
//     cur = cur?.next;
//     l1 = l1?.next;
//     l2 = l2?.next;
//   }
//   if (temp != 0) {
//     cur?.next = ListNode(temp);
//   }
//   return l3.next;
// }

// ListNode? addTwoNumbers(ListNode? l1, ListNode? l2) {
//   ListNode? head, tail;
//   int carry = 0;
//   while (l1 != null || l2 != null) {
//     int n1 = l1?.val ?? 0;
//     int n2 = l2?.val ?? 0;
//     int sum = n1 + n2 + carry;
//     if (head == null) {
//       head = ListNode(sum % 10);
//       tail = head;
//     } else {
//       tail!.next = ListNode(sum % 10);
//       tail = tail.next;
//     }
//     carry = sum ~/ 10;
//     l1 = l1?.next;
//     l2 = l2?.next;
//   }
//   if (carry > 0) {
//     tail!.next = ListNode(carry);
//   }
//   return head;
// }

ListNode addTwoNumbers(ListNode? l1, ListNode? l2) {
  ListNode pre = ListNode(0);
  ListNode cur = pre;
  int carry = 0;
  while (l1 != null || l2 != null) {
    int x = l1?.val ?? 0;
    int y = l2?.val ?? 0;
    int sum = x + y + carry;

    carry = sum ~/ 10;
    sum = sum % 10;
    cur.next = ListNode(sum);

    cur = cur.next!;
    if (l1 != null) {
      l1 = l1.next;
    }
    if (l2 != null) {
      l2 = l2.next;
    }
  }
  if (carry == 1) {
    cur.next = ListNode(carry);
  }
  return pre.next!;
}
