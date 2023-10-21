import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SortPage extends StatefulWidget {
  const SortPage({Key? key}) : super(key: key);

  @override
  State<SortPage> createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  //存放随机数组
  List<int> numbers = [];

  //订阅流
  StreamController<List<int>> streamController = StreamController();
  String currentSort = 'bubble';

  //柱子的数量 -> 生成排序数组的长度
  double sampleSize = 0;

  //是否排序
  bool isSorted = false;

  //是否在排序中
  bool isSorting = false;

  //排序动画更新的速度
  int speed = 0;

  static int duration = 1500;

  String getTitle() {
    switch (currentSort) {
      case "bubble":
        return "Bubble Sort";
      case "coctail":
        return "Coctail Sort";
      case "comb":
        return "Comb Sort";
      case "pigeonhole":
        return "Pigeonhole Sort";
      case "shell":
        return "Shell Sort";
      case "selection":
        return "Selection Sort";
      case "cycle":
        return "Cycle Sort";
      case "heap":
        return "Heap Sort";
      case "insertion":
        return "Insertion Sort";
      case "gnome":
        return "Gnome Sort";
      case "oddeven":
        return "OddEven Sort";
      case "quick":
        return "Quick Sort";
      case "merge":
        return "Merge Sort";
    }
    return "";
  }

  reset() {
    isSorted = false;
    numbers = [];
    for (int i = 0; i < sampleSize; ++i) {
      numbers.add(Random().nextInt(500));
    }
    streamController.add(numbers);
  }

  Duration getDuration() {
    return Duration(microseconds: duration);
  }

  ///动画时间
  changeSpeed() {
    if (speed >= 3) {
      speed = 0;
      duration = 1500;
    } else {
      speed++;
      duration = duration ~/ 2;
    }
    setState(() {});
  }

  ///冒泡排序
  bubbleSort() async {
    //控制需要进行排序的次数。每一轮循环都会确定一个数字的最终位置。
    for (int i = 0; i < numbers.length; ++i) {
      //遍历当前未排序的元素，通过相邻的元素比较并交换位置来完成排序。
      for (int j = 0; j < numbers.length - i - 1; ++j) {
        //如果 _numbers[j] 大于 _numbers[j + 1]，则交换它们的位置，确保较大的元素移到右边。
        if (numbers[j] > numbers[j + 1]) {
          int temp = numbers[j];
          numbers[j] = numbers[j + 1];
          numbers[j + 1] = temp;
        }
        //实现一个延迟，以便在ui上展示排序的动画效果
        await Future.delayed(getDuration(), () {});
        streamController.add(numbers);
      }
    }
  }

  ///鸡尾酒排序(双向冒泡排序)
  cocktailSort() async {
    bool swapped = true; // 表示是否进行了交换
    int start = 0; // 当前未排序部分的起始位置
    int end = numbers.length; // 当前未排序部分的结束位置

    // 开始排序循环，只有当没有进行交换时才会退出循环
    while (swapped == true) {
      swapped = false;

      // 从左往右遍历需要排序的部分
      for (int i = start; i < end - 1; ++i) {
        // 对每两个相邻元素进行比较
        if (numbers[i] > numbers[i + 1]) {
          // 如果前面的元素大于后面的元素，则交换它们的位置
          int temp = numbers[i];
          numbers[i] = numbers[i + 1];
          numbers[i + 1] = temp;
          swapped = true; // 进行了交换
        }

        // 实现动画效果，延迟一段时间后更新数组状态
        await Future.delayed(getDuration());
        streamController.add(numbers);
      }

      // 如果没有进行交换，则说明已经排好序，退出循环
      if (swapped == false) break;
      // 重设为false，准备进行下一轮排序
      swapped = false;
      // 将end设置为上一轮排序的最后一个元素的位置
      end = end - 1;

      // 从右往左遍历需要排序的部分
      for (int i = end - 1; i >= start; i--) {
        // 对每两个相邻元素进行比较
        if (numbers[i] > numbers[i + 1]) {
          // 如果前面的元素大于后面的元素，则交换它们的位置
          int temp = numbers[i];
          numbers[i] = numbers[i + 1];
          numbers[i + 1] = temp;
          swapped = true; // 进行了交换
        }

        // 实现动画效果，延迟一段时间后更新数组状态
        await Future.delayed(getDuration());
        streamController.add(numbers);
      }
      // 将start向右移一位，准备下一轮排序
      start = start + 1;
    }
  }

  ///梳排序（Comb Sort）
  combSort() async {
    int gap = numbers.length;

    bool swapped = true;

    // 当间隔不为1或存在交换时执行循环
    while (gap != 1 || swapped == true) {
      // 通过缩小间隔来逐步将元素归位
      gap = getNextGap(gap);
      swapped = false;
      for (int i = 0; i < numbers.length - gap; i++) {
        // 如果当前元素大于间隔位置上的元素，则交换它们的位置
        if (numbers[i] > numbers[i + gap]) {
          int temp = numbers[i];
          numbers[i] = numbers[i + gap];
          numbers[i + gap] = temp;
          swapped = true;
        }

        // 实现一个延迟，以便在 UI 上展示排序的动画效果。
        await Future.delayed(getDuration());
        streamController.add(numbers);
      }
    }
  }

  int getNextGap(int gap) {
    // 根据当前间隔值计算下一个间隔值
    gap = (gap * 10) ~/ 13;
    if (gap < 1) return 1;
    return gap;
  }

  ///鸽巢排序
  pigeonHole() async {
    int min = numbers[0];
    int max = numbers[0];
    int range, i, j, index;

    // 找到数组中的最大值和最小值
    for (int a = 0; a < numbers.length; a++) {
      if (numbers[a] > max) max = numbers[a];
      if (numbers[a] < min) min = numbers[a];
    }

    // 计算鸽巢的个数
    range = max - min + 1;
    List<int> p = List.generate(range, (i) => 0);

    // 将数字分配到各个鸽巢中
    for (i = 0; i < numbers.length; i++) {
      p[numbers[i] - min]++;
    }

    index = 0;

    // 将鸽巢中的数字取出，重新放回到数组中
    for (j = 0; j < range; j++) {
      while (p[j]-- > 0) {
        numbers[index++] = j + min;
        await Future.delayed(getDuration());
        streamController.add(numbers);
      }
    }
  }

  ///希尔排序
  shellSort() async {
    //定义变量 gap 并初始化为数组长度的一半。每次循环完成后将 gap 减半直到等于 0。
    for (int gap = numbers.length ~/ 2; gap > 0; gap ~/= 2) {
      //遍历每个子序列并进行插入排序。初始时从第一个子序列的第二个元素开始，即 i = gap，以 gap 为步长逐个遍历每个子序列。
      for (int i = gap; i < numbers.length; i += 1) {
        //将当前遍历到的元素赋值给它
        int temp = numbers[i];
        //内部使用一个 for 循环来实现插入排序。
        //循环开始时定义变量 j 并将其初始化为当前遍历到的元素的下标。通过不断比较前后相隔 gap 的元素大小并交换位置，将当前元素插入到正确的位置。
        int j;
        for (j = i; j >= gap && numbers[j - gap] > temp; j -= gap) {
          numbers[j] = numbers[j - gap];
        }
        numbers[j] = temp;
        await Future.delayed(getDuration());
        streamController.add(numbers);
      }
    }
  }

  ///选择排序
  selectionSort() async {
    for (int i = 0; i < numbers.length; i++) {
      for (int j = i + 1; j < numbers.length; j++) {
        // 遍历未排序部分，内层循环控制变量 j
        if (numbers[i] > numbers[j]) {
          // 判断当前元素是否比后续元素小
          int temp = numbers[j];
          // 交换当前元素和后续较小的元素
          numbers[j] = numbers[i];
          numbers[i] = temp;
        }

        await Future.delayed(getDuration(), () {});

        streamController.add(numbers);
      }
    }
  }

  ///循环排序
  cycleSort() async {
    int writes = 0;
    for (int cycleStart = 0; cycleStart <= numbers.length - 2; cycleStart++) {
      int item = numbers[cycleStart];
      int pos = cycleStart;

      // 在未排序部分中寻找比当前元素小的元素个数
      for (int i = cycleStart + 1; i < numbers.length; i++) {
        if (numbers[i] < item) pos++;
      }

      // 如果当前元素已经在正确位置上，则跳过此次迭代
      if (pos == cycleStart) {
        continue;
      }

      // 将当前元素放置到正确的位置上，并记录写操作次数
      while (item == numbers[pos]) {
        pos += 1;
      }
      if (pos != cycleStart) {
        int temp = item;
        item = numbers[pos];
        numbers[pos] = temp;
        writes++;
      }

      // 循环将位于当前位置的元素放置到正确的位置上
      while (pos != cycleStart) {
        pos = cycleStart;
        // 继续在未排序部分中寻找比当前元素小的元素个数
        for (int i = cycleStart + 1; i < numbers.length; i++) {
          if (numbers[i] < item) pos += 1;
        }

        // 将当前元素放置到正确的位置上，并记录写操作次数
        while (item == numbers[pos]) {
          pos += 1;
        }
        if (item != numbers[pos]) {
          int temp = item;
          item = numbers[pos];
          numbers[pos] = temp;
          writes++;
        }

        // 添加延迟操作以展示排序过程
        await Future.delayed(getDuration());
        streamController.add(numbers);
      }
    }
  }

  ///堆排序
  heapSort() async {
    // 从最后一个非叶子节点开始，构建最大堆
    for (int i = numbers.length ~/ 2; i >= 0; i--) {
      await heapify(numbers, numbers.length, i);
      streamController.add(numbers);
    }

    // 依次取出最大堆的根节点（最大值），并进行堆化
    for (int i = numbers.length - 1; i >= 0; i--) {
      int temp = numbers[0];
      numbers[0] = numbers[i];
      numbers[i] = temp;
      await heapify(numbers, i, 0);
      streamController.add(numbers);
    }
  }

  heapify(List<int> arr, int n, int i) async {
    int largest = i;
    int l = 2 * i + 1; // 左子节点索引
    int r = 2 * i + 2; // 右子节点索引

    // 如果左子节点存在并且大于父节点，则更新最大值索引
    if (l < n && arr[l] > arr[largest]) largest = l;

    // 如果右子节点存在并且大于父节点或左子节点，则更新最大值索引
    if (r < n && arr[r] > arr[largest]) largest = r;

    // 如果最大值索引不等于当前节点索引，则交换节点值，并递归进行堆化
    if (largest != i) {
      int temp = numbers[i];
      numbers[i] = numbers[largest];
      numbers[largest] = temp;
      heapify(arr, n, largest);
    }

    await Future.delayed(getDuration()); // 延迟操作，用于可视化排序过程
  }

  ///插入排序
  insertionSort() async {
    for (int i = 1; i < numbers.length; i++) {
      int temp = numbers[i]; // 将当前元素存储到临时变量 temp 中
      int j = i - 1; // j 表示已排序部分的最后一个元素的索引

      // 在已排序部分从后往前查找，找到合适位置插入当前元素
      while (j >= 0 && temp < numbers[j]) {
        numbers[j + 1] = numbers[j]; // 当前元素比已排序部分的元素小，将元素后移一位
        --j; // 向前遍历
        await Future.delayed(getDuration());
        streamController.add(numbers); // 更新排序结果
      }

      numbers[j + 1] = temp; // 插入当前元素到已排序部分的正确位置
      await Future.delayed(getDuration(), () {});
      streamController.add(numbers); // 更新排序结果
    }
  }

  ///地精排序 (侏儒排序)
  gnomeSort() async {
    int index = 0;

    while (index < numbers.length) {
      // 当 index 小于数组长度时执行循环
      if (index == 0) index++;
      if (numbers[index] >= numbers[index - 1]) {
        // 如果当前元素大于等于前面的元素，则将 index 加1
        index++;
      } else {
        // 否则，交换这两个元素，并将 index 减1（使得元素可以沉到正确位置）
        int temp = numbers[index];
        numbers[index] = numbers[index - 1];
        numbers[index - 1] = temp;
        index--;
      }
      await Future.delayed(getDuration());
      streamController.add(numbers);
    }

    return;
  }

  ///奇偶排序(Odd-Even Sort)
  oddEvenSort() async {
    bool isSorted = false;

    while (!isSorted) {
      // 当 isSorted 为 false 时执行循环
      isSorted = true; // 先假设数组已经排好序

      for (int i = 1; i <= numbers.length - 2; i = i + 2) {
        // 对奇数索引位置进行比较
        if (numbers[i] > numbers[i + 1]) {
          // 如果当前元素大于后面的元素，则交换它们的值
          int temp = numbers[i];
          numbers[i] = numbers[i + 1];
          numbers[i + 1] = temp;
          isSorted = false; // 若发生了交换，则说明数组仍未完全排序，将 isSorted 设为 false
          await Future.delayed(getDuration());
          streamController.add(numbers);
        }
      }

      for (int i = 0; i <= numbers.length - 2; i = i + 2) {
        // 对偶数索引位置进行比较
        if (numbers[i] > numbers[i + 1]) {
          // 如果当前元素大于后面的元素，则交换它们的值
          int temp = numbers[i];
          numbers[i] = numbers[i + 1];
          numbers[i + 1] = temp;
          isSorted = false;
          await Future.delayed(getDuration());
          streamController.add(numbers);
        }
      }
    }

    return;
  }

  ///快速排序
  quickSort(int leftIndex, int rightIndex) async {
    // 定义一个名为 _partition 的异步函数，用于划分数组，并返回划分后的基准元素的索引位置
    Future<int> _partition(int left, int right) async {
      // 选择中间位置的元素作为基准元素
      int p = (left + (right - left) / 2).toInt();

      // 交换基准元素和最右边的元素
      var temp = numbers[p];
      numbers[p] = numbers[right];
      numbers[right] = temp;
      await Future.delayed(getDuration());
      streamController.add(numbers);

      // 初始化游标 cursor
      int cursor = left;

      // 遍历数组并根据基准元素将元素交换到左侧或右侧
      for (int i = left; i < right; i++) {
        if (cf(numbers[i], numbers[right]) <= 0) {
          // 如果当前元素小于等于基准元素，则交换它和游标位置的元素
          var temp = numbers[i];
          numbers[i] = numbers[cursor];
          numbers[cursor] = temp;
          cursor++;

          await Future.delayed(getDuration());
          streamController.add(numbers);
        }
      }

      // 将基准元素放置在游标位置
      temp = numbers[right];
      numbers[right] = numbers[cursor];
      numbers[cursor] = temp;

      await Future.delayed(getDuration());
      streamController.add(numbers);

      return cursor; // 返回基准元素的索引位置
    }

    // 如果左索引小于右索引，则递归地对数组进行快速排序
    if (leftIndex < rightIndex) {
      int p = await _partition(leftIndex, rightIndex);

      await quickSort(leftIndex, p - 1); // 对基准元素左侧的子数组进行快速排序

      await quickSort(p + 1, rightIndex); // 对基准元素右侧的子数组进行快速排序
    }
  }

  // 比较函数，用于判断两个元素的大小关系
  cf(int a, int b) {
    if (a < b) {
      return -1; // 若 a 小于 b，则返回 -1
    } else if (a > b) {
      return 1; // 若 a 大于 b，则返回 1
    } else {
      return 0; // 若 a 等于 b，则返回 0
    }
  }

  ///归并排序
  mergeSort(int leftIndex, int rightIndex) async {
    // 定义一个名为 merge 的异步函数，用于合并两个有序子数组
    Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
      // 计算左侧子数组和右侧子数组的大小
      int leftSize = middleIndex - leftIndex + 1;
      int rightSize = rightIndex - middleIndex;

      // 创建左侧子数组和右侧子数组
      List leftList = List.generate(leftSize, (index) => 0);
      List rightList = List.generate(rightSize, (index) => 0);

      // 将原始数组中的元素分别复制到左侧子数组和右侧子数组中
      for (int i = 0; i < leftSize; i++) {
        leftList[i] = numbers[leftIndex + i];
      }
      for (int j = 0; j < rightSize; j++) {
        rightList[j] = numbers[middleIndex + j + 1];
      }

      // 初始化游标和索引
      int i = 0, j = 0;
      int k = leftIndex;

      // 比较左侧子数组和右侧子数组的元素，并按顺序将较小的元素放入原始数组中
      while (i < leftSize && j < rightSize) {
        if (leftList[i] <= rightList[j]) {
          numbers[k] = leftList[i];
          i++;
        } else {
          numbers[k] = rightList[j];
          j++;
        }

        await Future.delayed(getDuration());
        streamController.add(numbers);

        k++;
      }

      // 将左侧子数组或右侧子数组中剩余的元素放入原始数组中
      while (i < leftSize) {
        numbers[k] = leftList[i];
        i++;
        k++;

        await Future.delayed(getDuration());
        streamController.add(numbers);
      }

      while (j < rightSize) {
        numbers[k] = rightList[j];
        j++;
        k++;

        await Future.delayed(getDuration());
        streamController.add(numbers);
      }
    }

    // 如果左索引小于右索引，则递归地对数组进行归并排序
    if (leftIndex < rightIndex) {
      // 计算中间索引位置
      int middleIndex = (rightIndex + leftIndex) ~/ 2;

      // 分别对左侧子数组和右侧子数组进行归并排序
      await mergeSort(leftIndex, middleIndex);
      await mergeSort(middleIndex + 1, rightIndex);

      await Future.delayed(getDuration());
      streamController.add(numbers);

      // 合并两个有序子数组
      await merge(leftIndex, middleIndex, rightIndex);
    }
  }

  checkAndResetIfSorted() async {
    if (isSorted) {
      reset();
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  sort() async {
    setState(() {
      isSorting = true;
    });

    await checkAndResetIfSorted();

    Stopwatch stopwatch = Stopwatch()..start();

    switch (currentSort) {
      case "bubble":
        await bubbleSort();
        break;
      case "coctail":
        await cocktailSort();
        break;
      case "comb":
        await combSort();
        break;
      case "pigeonhole":
        await pigeonHole();
        break;
      case "shell":
        await shellSort();
        break;
      case "selection":
        await selectionSort();
        break;
      case "cycle":
        await cycleSort();
        break;
      case "heap":
        await heapSort();
        break;
      case "insertion":
        await insertionSort();
        break;
      case "gnome":
        await gnomeSort();
        break;
      case "oddeven":
        await oddEvenSort();
        break;
      case "quick":
        await quickSort(0, sampleSize.toInt() - 1);
        break;
      case "merge":
        await mergeSort(0, sampleSize.toInt() - 1);
        break;
    }

    stopwatch.stop();

    print("Sorting completed in ${stopwatch.elapsed.inMilliseconds} ms.");
    setState(() {
      isSorting = false;
      isSorted = true;
    });
  }

  setSort(String type) {
    setState(() {
      currentSort = type;
    });
  }

  @override
  void initState() {
    super.initState();
    // reset();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sampleSize = MediaQuery.of(context).size.width / 2;
    for (int i = 0; i < sampleSize; ++i) {
      //随机往数组中填值
      numbers.add(Random().nextInt(500));
    }
    setState(() {});
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "当前选择的是：${getTitle()}",
          style: const TextStyle(fontSize: 14),
        ),
        actions: <Widget>[
          PopupMenuButton(
            initialValue: currentSort,
            itemBuilder: (ctx) {
              return const [
                PopupMenuItem(
                  value: 'bubble',
                  child: Text("Bubble Sort — 冒泡排序"),
                ),
                PopupMenuItem(
                  value: 'coctail',
                  child: Text("Coctail Sort — 鸡尾酒排序(双向冒泡排序)"),
                ),
                PopupMenuItem(
                  value: 'comb',
                  child: Text("Comb Sort — 梳排序"),
                ),
                PopupMenuItem(
                  value: 'pigeonhole',
                  child: Text("pigeonhole Sort — 鸽巢排序"),
                ),
                PopupMenuItem(
                  value: 'shell',
                  child: Text("shell Sort — 希尔排序"),
                ),
                PopupMenuItem(
                  value: 'selection',
                  child: Text("Selection Sort — 选择排序"),
                ),
                PopupMenuItem(
                  value: 'cycle',
                  child: Text("CycleSort — 循环排序"),
                ),
                PopupMenuItem(
                  value: 'heap',
                  child: Text("HeapSort — 堆排序"),
                ),
                PopupMenuItem(
                  value: 'insertion',
                  child: Text("InsertionSort — 插入排序"),
                ),
                PopupMenuItem(
                  value: 'gnome',
                  child: Text("GnomeSort — 地精排序 (侏儒排序)"),
                ),
                PopupMenuItem(
                  value: 'oddeven',
                  child: Text("OddEvenSort — 奇偶排序"),
                ),
                PopupMenuItem(
                  value: 'quick',
                  child: Text("QuickSort — 快速排序"),
                ),
                PopupMenuItem(
                  value: 'merge',
                  child: Text("MergeSort — 归并排序"),
                ),
              ];
            },
            onSelected: (String value) {
              reset();
              setSort(value);
            },
          )
        ],
      ),
      body: StreamBuilder<Object>(
        initialData: numbers,
        stream: streamController.stream,
        builder: (context, snapshot) {
          List<int> numbers = snapshot.data as List<int>;
          int counter = 0;
          return Row(
            children: numbers.map((int num) {
              counter++;
              return CustomPaint(
                painter: BarPainter(
                  width: MediaQuery.of(context).size.width / sampleSize,
                  value: num,
                  index: counter,
                ),
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
                onPressed: isSorting
                    ? null
                    : () {
                  reset();
                  setSort(currentSort);
                },
                child: const Text("重置")),
            ElevatedButton(
                onPressed: isSorting ? null : sort, child: const Text("开始排序")),
            ElevatedButton(
              onPressed: isSorting ? null : changeSpeed,
              child: Text(
                "${speed + 1}x",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  //宽度
  final double width;

  //高度(数组中对应的值)
  final int value;

  //位置索引
  final int index;

  BarPainter({required this.width, required this.value, required this.index});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (value < 500 * .10) {
      paint.color = Colors.blue.shade100;
    } else if (value < 500 * .20) {
      paint.color = Colors.blue.shade200;
    } else if (value < 500 * .30) {
      paint.color = Colors.blue.shade300;
    } else if (value < 500 * .40) {
      paint.color = Colors.blue.shade400;
    } else if (value < 500 * .50) {
      paint.color = Colors.blue.shade500;
    } else if (value < 500 * .60) {
      paint.color = Colors.blue.shade600;
    } else if (value < 500 * .70) {
      paint.color = Colors.blue.shade700;
    } else if (value < 500 * .80) {
      paint.color = Colors.blue.shade800;
    } else if (value < 500 * .90) {
      paint.color = Colors.blue.shade900;
    } else {
      paint.color = const Color(0xFF011E51);
    }

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    canvas.drawLine(
        Offset(index * width, 0),
        Offset(
          index * width,
          value.ceilToDouble(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
