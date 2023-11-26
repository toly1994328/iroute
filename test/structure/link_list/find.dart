/// Dart、Rust 、C++ 、Java

void main() {
  ListNode listNode = ListNode(0, ListNode(3, ListNode(2, ListNode(8))));
  print(listNode);

  // List<int> evens = listNode.getEvenValue();
  // print(evens);

  // List<int> values = listNode.getValueByStep(2);
  // print(values);

  // listNode.deleteAt(3);
  // ListNode? ret = listNode.deleteFromEnd(2);
  // print(ret);

  // ListNode? middleNode1 = listNode.middleNode1();
  // print(middleNode1);

  ListNode? middleNode2 = listNode.middleNode2();
  print(middleNode2);
  // ListNode? findNode = listNode.find(8);
  // if(findNode!=null){
  //   ListNode? result =  listNode.deleteNode(findNode);
  //   // 0->2->8
  //   print(result);
  // }
}

class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);

  //// region [2023.11.20]
  @override
  String toString() {
    ListNode? cur = this;
    String result = "";
    while (cur != null) {
      result = result + cur.val.toString();
      cur = cur.next;
      if (cur != null) {
        result += '->';
      }
    }
    return result;
  }

  // endregion

  //// region [2023.11.21]
  /// [2023.11.21] TODO: 完成 find 函数，在链表中查找指定值的首位节点
  ListNode? find(int target) {
    ListNode? cur = this;
    while (cur != null) {
      if (cur.val == target) {
        return cur;
      }
      cur = cur.next;
    }
    return null;
  }

  /// [2023.11.21]
  /// TODO: LeetCode 237 删除指定节点(非尾结点)
  void deleteNodeNotLast(ListNode node) {
    if (node.next != null) {
      node.val = node.next!.val;
      node.next = node.next?.next;
    }
  }

  // endregion

  //// region [2023.11.22]
  /// [2023.11.22]
  /// TODO: 完成 size 方法，返回链表长度
  int size() {
    int i = 0;
    ListNode? cur = this;
    while (cur != null) {
      cur = cur.next;
      i++;
    }
    return i;
  }

  /// [2023.11.22]
  /// TODO: 完成 deleteAt 方法，删除第 index 个节点
  void deleteAt(int index) {
    if (index == 0) {
      ListNode? next = this.next;
      this.val = next?.val ?? -1;
      this.next = next?.next;
      next?.next = null;
      return;
    }

    ListNode? cur = this;
    for (int i = 0; i < index - 1; i++) {
      cur = cur?.next;
    }
    ListNode? target = cur?.next;
    cur?.next = target?.next;
    target?.next = null;
  }

  /// [2023.11.22]
  /// TODO: LeetCode 19 删除链表的倒数第 N 个节点
  ListNode? deleteFromEnd(int n) {
    ListNode? dummy = ListNode(0, this);
    ListNode? first = this;
    ListNode? second = dummy;
    for (int i = 0; i < n; ++i) {
      first = first?.next;
    }
    while (first != null) {
      first = first.next;
      second = second?.next;
    }
    second?.next = second.next?.next;
    return dummy.next;
  }

  ListNode? deleteNode(ListNode node) {
    ListNode? cur = this;
    if (cur == node) {
      cur = cur.next!;
      return cur;
    }
    while (cur != null) {
      if (cur.next == node) {
        cur.next = cur.next?.next;
        return this;
      }
      cur = cur.next;
    }
    return this;
  }

  // endregion

  //// region [2023.11.23]
  /// [2023.11.23]
  /// TODO: 完成 getEvenValue 方法，
  /// 返回链表中偶数节点的值列表
  List<int> getEvenValue() {
    ListNode? cur = this;
    List<int> result = [];

    while (cur != null) {
      result.add(cur.val);
      cur = cur.next?.next;
    }
    return result;
  }

  /// TODO: 完成 getValueByStep 方法，
  /// 返回链表中每隔 step 个节点的值列表
  /// 例:
  /// 链表: 0->3->2->8->9
  /// step=3 : 输出 [0, 8]
  /// step=2 : 输出 [0, 2, 9]
  List<int> getValueByStep(int step) {
    ListNode? cur = this;
    List<int> result = [];

    while (cur != null) {
      result.add(cur.val);
      for (int i = 0; i < step; i++) {
        cur = cur?.next;
      }
    }
    return result;
  }

  /// [2023.11.23]
  /// TODO: LeetCode 876 链表的中间结点
  /// [1,2,3,4,5] -> [3,4,5]
  /// [1,2,3,4,5,6] -> [4,5,6]
  /// 时间 O(N) 空间 O(N)
  ListNode? middleNode1() {
    List<ListNode?> nodes = [];
    ListNode? cur = this;
    while (cur != null) {
      nodes.add(cur);
      cur = cur.next;
    }
    return nodes[nodes.length ~/ 2];
  }

  /// 使用快慢指针 - 一次遍历
  ListNode? middleNode2() {
    ListNode? slow = this;
    ListNode? fast = this;
    while (fast != null && fast.next != null) {
      slow = slow?.next;
      fast = fast.next?.next;
    }
    return slow;
  }
// endregion
}
