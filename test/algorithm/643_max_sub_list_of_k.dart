import 'dart:math';

/// 子数组最大平均数
///
///给你一个由 n 个元素组成的整数数组 nums 和一个整数 k 。
/// 请你找出平均数最大且 长度为 k 的连续子数组，并输出该最大平均数。
///输入：nums = [1,12,-5,-6,50,3], k = 4
///输出：12.75
///解释：最大平均数 (12-5-6+50)/4 = 51/4 = 12.75

///滑动窗口解法
//class Solution:
//     def problemName(self, s: str) -> int:
//         # Step 1: 定义需要维护的变量们 (对于滑动窗口类题目，这些变量通常是最小长度，最大长度，或者哈希表)
//         x, y = ..., ...
//
//         # Step 2: 定义窗口的首尾端 (start, end)， 然后滑动窗口
//         start = 0
//         for end in range(len(s)):
//             # Step 3: 更新需要维护的变量, 有的变量需要一个if语句来维护 (比如最大最小长度)
//             x = new_x
//             if condition:
//                 y = new_y
//
//             '''
//             ------------- 下面是两种情况，读者请根据题意二选1 -------------
//             '''
//             # Step 4 - 情况1
//             # 如果题目的窗口长度固定：用一个if语句判断一下当前窗口长度是否达到了限定长度
//             # 如果达到了，窗口左指针前移一个单位，从而保证下一次右指针右移时，窗口长度保持不变,
//             # 左指针移动之前, 先更新Step 1定义的(部分或所有)维护变量
//             if 窗口长度达到了限定长度:
//                 # 更新 (部分或所有) 维护变量
//                 # 窗口左指针前移一个单位保证下一次右指针右移时窗口长度保持不变
//
//             # Step 4 - 情况2
//             # 如果题目的窗口长度可变: 这个时候一般涉及到窗口是否合法的问题
//             # 如果当前窗口不合法时, 用一个while去不断移动窗口左指针, 从而剔除非法元素直到窗口再次合法
//             # 在左指针移动之前更新Step 1定义的(部分或所有)维护变量
//             while 不合法:
//                 # 更新 (部分或所有) 维护变量
//                 # 不断移动窗口左指针直到窗口再次合法
//
//         # Step 5: 返回答案
//         return ...
//

void main() {
  List<int> num = [4, 6, 3, 8, 7, 2, 6];
  print("${findMaxAverage(num, 3)}");
}
//
double findMaxAverage(List<int> num, int k) {
  int sum = 0;
  int n = num.length;
  //窗口大小
  for (int i = 0; i < k; i++) {
    sum += num[i];
  }
  int maxSum = sum;

  for (int i = k; i < n; i++) {
    sum = sum - num[i - k] + num[i];//减前一个 + 后一个  == 相当于视口向前滑动一格
    //第一次  sum =  num[0]+num[1] - num[0] + num[2]  = num[1] + num[2]
    //第二次  sum = num[1]+num[2] - num[1] +num[3] = num[2] + num[3]
    maxSum = max(maxSum, sum);
  }
  return 1.0 * maxSum / k;
}

// double findMaxAverage(List<int> num, int k) {
//   int maxSum = 0;
//   //窗口开始的和
//   for (int i = 0; i < k; i++) {
//     maxSum += num[i];
//   }
//   for( int i = k;i<num.length;i++){
//
//
//   }
//
//
//
//   return maxSum / k;
// }