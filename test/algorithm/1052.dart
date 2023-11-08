/// 1052. 爱生气的书店老板
//有一个书店老板，他的书店开了 n 分钟。每分钟都有一些顾客进入这家商店。
// 给定一个长度为 n 的整数数组 customers ，
// 其中 customers[i] 是在第 i 分钟开始时进入商店的顾客数量，所有这些顾客在第 i 分钟结束后离开。
// 在某些时候，书店老板会生气。 如果书店老板在第 i 分钟生气，那么 grumpy[i] = 1，
// 否则 grumpy[i] = 0。 当书店老板生气时，那一分钟的顾客就会不满意，若老板不生气则顾客是满意的。
// 书店老板知道一个秘密技巧，能抑制自己的情绪，可以让自己连续 minutes 分钟不生气，但却只能使用一次。
// 请你返回 这一天营业下来，最多有多少客户能够感到满意 。
//
//输入：customers = [1,0,1,2,1,1,7,5], grumpy = [0,1,0,1,0,1,0,1], minutes = 3
// 输出：16
// 解释：书店老板在最后 3 分钟保持冷静。
// 感到满意的最大客户数量 = 1 + 1 + 1 + 1 + 7 + 5 = 16.

//
// 算法思想：
// 因为有X分钟可以控制情绪，所以这X分钟要用在关键的时间段，也就是需要知道哪个长度为X的时间段不满意的客人最多。
// 最多满意客户数量 = 原本就满意的客户 + X时间段内因为控制了情绪而态度反转的最多客户数量
//
// 算法步骤：
//
// 统计老板不生气时的客人数量；
// 利用长度为X的滑动窗口统计，长度为X的时间段内不满意的客户最多数量是多少；

import 'dart:math';

void main() {
  List<int> customers = [4, 6, 3, 8, 7, 2, 6];
  //1生气    0不气
  List<int> grumpy = [1, 0, 1, 1, 0, 1, 0];
  //最大不满数 3+8
  // 没有魔法时满意数  6+7+6 = 19；
  //拥有魔法 6+3+8+7+6 =30
  int magic = 2;
  maxSatisfied(customers, grumpy, magic);
}

// int maxSatisfied(List<int> customers, List<int> grumpy, int minutes) {
//   int m = customers.length;
//   int total = 0;
// // 统计不生气时间内的客人总数
//   for (int i = 0; i < m; i++) {
//     if (grumpy[i] == 0) {
//       total += customers[i];
//     }
//   }
//   int curAngry = 0; // 长度为X的时间段内，不满意的客人数
// // 统计第一个大小为X的窗口内，不满意的客人数
//   for (int i = 0; i < minutes; i++) {
//     curAngry += customers[i] * grumpy[i];
//   }
//   int maxAngry = curAngry; // 所有窗口时间段内，遇到不满意的客人的最多数量
// // 滑动窗口，统计max_angry
//   for (int i = minutes; i < m; i++) {
//     curAngry += customers[i] * grumpy[i]; // 只把不满意的客人数量加进来
//     curAngry -= customers[i - minutes] * grumpy[i - minutes]; // 只减去不满意客人数量
//     maxAngry = max(maxAngry, curAngry); // 更新窗口内的不满意客人数量
//   }
// // 总满意人数 = 本来就满意的人数 + 老板抑制情绪的时间段内不满意变为满意的人数
//   return total + maxAngry;
// }

///最大满意人数
int maxSatisfied(List<int> customers, List<int> grumpy, int minutes) {
  int maxSatisNumber = 0;
  int maxUnSatisNumber = 0;
  int unSatisNumber = 0;
  //先算第一个窗口不满意人数
  for (int i = 0; i < minutes; i++) {
    if (grumpy[i] == 1) {
      maxUnSatisNumber += customers[i];
      unSatisNumber = maxUnSatisNumber;
    }
  }
//格口向后移动
  for (int i = minutes; i < customers.length; i++) {
    //减去前一个格口不满数 加上后一个格口不满数
    if (grumpy[i - minutes] == 1) {
      if (grumpy[i] == 1) {
        unSatisNumber = unSatisNumber - customers[i - minutes] + customers[i];
      } else {
        unSatisNumber = unSatisNumber - customers[i - minutes] + 0;
      }
    } else {
      if (grumpy[i] == 1) {
        unSatisNumber = unSatisNumber - 0 + customers[i];
      } else {
        unSatisNumber = unSatisNumber - 0 + 0;
      }
    }

    maxUnSatisNumber = max(maxUnSatisNumber, unSatisNumber);
  }
  print("最大不满意数$maxUnSatisNumber");
  for (int i = 0; i < customers.length; i++) {
    if (grumpy[i] == 0) {
      maxSatisNumber += customers[i];
    }
  }
  maxSatisNumber = maxSatisNumber + maxUnSatisNumber;
  print("最大满意数$maxSatisNumber");

  return maxSatisNumber;
}