import 'package:flutter/material.dart';
import '../../provider/state.dart';
import 'color_picker.dart';
class SortSettings extends StatefulWidget {

  const SortSettings({super.key,});

  @override
  State<SortSettings> createState() => _SortSettingsState();
}

class _SortSettingsState extends State<SortSettings> {
  final TextEditingController _count = TextEditingController();
  final TextEditingController _duration = TextEditingController();
  final TextEditingController _seed = TextEditingController();
  int _colorIndex = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SortState state = SortStateScope.of(context);
    _count.text = state.config.count.toString();
    _duration.text = state.config.duration.inMicroseconds.toString();
    _seed.text = state.config.seed.toString();
    _colorIndex = state.config.colorIndex;
  }

  @override
  Widget build(BuildContext context) {
    SortState state = SortStateScope.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Align(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                  width: 28,
                  height: 28,
                  margin: EdgeInsets.only(right: 8,left: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xffE3E5E7),
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: Icon(Icons.arrow_back_ios_new,size: 18,)),
            ),
          ),
        ),
        // leading: BackButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                splashRadius: 20,
                onPressed: (){
              SortState state = SortStateScope.of(context);
              state.config =state.config.copyWith(
                  count:  int.parse(_count.text),
                  duration: Duration(
                    microseconds: int.parse(_duration.text),
                  ),
                  seed: int.parse(_seed.text),
                colorIndex: _colorIndex
              );
              Navigator.of(context).pop();
            }, icon: Icon(Icons.check)),
          )],
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        title: Text('排序算法配置'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('数据数量(个数):'),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextField(
                      controller: _count,
                    )),
              ],
            ),
            Row(
              children: [
                Text('时间间隔(微秒):'),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextField(
                      controller: _duration,
                    )),
              ],
            ),
            Row(
              children: [
                Text('随机种子:'),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextField(
                      controller: _seed,
                    )),
              ],
            ),
            const SizedBox(height: 20,),

            Row(
              children: [
                Text('选择颜色:'),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: ColorPicker(
                      colors: kColorSupport,
                      onSelected: (index){
                        setState(() {
                          _colorIndex = index;
                        });
                      },
                      activeIndex: _colorIndex,
                    ),),
              ],
            ),

            Spacer(),
            // ElevatedButton(
            //     onPressed: () {
            //       SortState state = SortStateScope.of(context);
            //       state.config =state.config.copyWith(
            //         count:  int.parse(_count.text),
            //         duration: Duration(
            //           microseconds: int.parse(_duration.text),
            //         ),
            //         seed: int.parse(_seed.text)
            //       );
            //       Navigator.of(context).pop();
            //     },
            //     child: Text('确定设置'))
          ],
        ),
      ),
    );
  }
}
