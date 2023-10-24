import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../bloc/state.dart';
import '../functions.dart';
import '../bloc/sort_config.dart';
import 'data_painter.dart';

class SortPage extends StatefulWidget {
  final Size size;
  const SortPage({Key? key, required this.size}) : super(key: key);

  @override
  State<SortPage> createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  //存放随机数组
  List<int> numbers = [];

  //订阅流
  StreamController<List<int>> streamController = StreamController();

  String get currentSort => sortName.value;

  //柱子的数量 -> 生成排序数组的长度
  double sampleSize = 0;

  //是否排序
  bool isSorted = false;

  //是否在排序中
  bool isSorting = false;


  reset() {
    isSorted = false;
    setSize(sortConfig.value.count);
    streamController.add(numbers);
  }

  Duration getDuration() {
    return sortConfig.value.duration;
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

    SortFunction? sortFunction = sortFunctionMap[currentSort];
    if(sortFunction!=null){
      await sortFunction(numbers,(arr) async {
        await Future.delayed(getDuration());
        streamController.add(arr);
      });
    }

    stopwatch.stop();
    print("Sorting completed in ${stopwatch.elapsed.inMilliseconds} ms.");
    setState(() {
      isSorting = false;
      isSorted = true;
    });
  }

  @override
  void initState() {
    super.initState();
    // reset();
    print(widget.size);
    setSize(sortConfig.value.count);
    sortConfig.addListener(_onSortConfigChange);
    sortName.addListener(reset);
  }

  Random random = Random();
  void setSize(int count){
    int s = count;
    numbers.clear();
    if(count==-1){
      s = widget.size.width~/2;
    }

    if(sortConfig.value.seed!=-1){
      random = Random(sortConfig.value.seed);
    }

    for (int i = 0; i < s; i++) {
      //随机往数组中填值
      numbers.add(random.nextInt(widget.size.height.toInt()));
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

    List<int> numbers =  SortStateScope.of(context).data;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.run_circle_outlined),
        onPressed: (){
          sort();
        },
      ),
      body: StreamBuilder<Object>(
        initialData: numbers,
        stream: streamController.stream,
        builder: (context, snapshot) {
          List<int> numbers = snapshot.data as List<int>;
          return CustomPaint(
            size: widget.size,
            painter: DataPainter(data: numbers),
          );
        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: <Widget>[
      //       ElevatedButton(
      //           onPressed: isSorting
      //               ? null
      //               : () {
      //             reset();
      //             setSort(currentSort);
      //           },
      //           child: const Text("重置")),
      //       ElevatedButton(
      //           onPressed: isSorting ? null : sort, child: const Text("开始排序")),
      //       ElevatedButton(
      //         onPressed: isSorting ? null : changeSpeed,
      //         child: Text(
      //           "${speed + 1}x",
      //           style: const TextStyle(fontSize: 20),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  void _onSortConfigChange() {
    setSize(sortConfig.value.count);
  }
}

class BarPainter extends CustomPainter {
  //宽度
  final double width;
  final double height;

  //高度(数组中对应的值)
  final int value;

  //位置索引
  final int index;

  BarPainter({required this.width, required  this.height,required this.value, required this.index});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    // double rate = value/height;
    // print(rate);
    // paint.color = Colors.blue.withOpacity(rate);
    if (value < 500 * .10) {
      paint.color = Colors.blue.shade100;
    } else if (value < height * .20) {
      paint.color = Colors.blue.shade200;
    } else if (value < height * .30) {
      paint.color = Colors.blue.shade300;
    } else if (value < height * .40) {
      paint.color = Colors.blue.shade400;
    } else if (value < height * .50) {
      paint.color = Colors.blue.shade500;
    } else if (value < height * .60) {
      paint.color = Colors.blue.shade600;
    } else if (value < height * .70) {
      paint.color = Colors.blue.shade700;
    } else if (value < height * .80) {
      paint.color = Colors.blue.shade800;
    } else if (value < height * .90) {
      paint.color = Colors.blue.shade900;
    } else {
      paint.color = const Color(0xFF011E51);
    }

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    canvas.drawLine(
        Offset(index * width+width/2, 0),
        Offset(
          index * width+width/2,
          value.ceilToDouble(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
