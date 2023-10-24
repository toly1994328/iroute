import 'package:flutter/material.dart';

import 'bloc/sort_config.dart';

class SortSettings extends StatefulWidget {

  final SortConfig config;

  const SortSettings({super.key,required this.config});

  @override
  State<SortSettings> createState() => _SortSettingsState();
}

class _SortSettingsState extends State<SortSettings> {

  late TextEditingController _count = TextEditingController(
      text:sortConfig.value.count.toString()
  );
  late TextEditingController _duration = TextEditingController(
      text:sortConfig.value.duration.inMicroseconds.toString()
  );
  late TextEditingController _seed = TextEditingController(
      text:sortConfig.value.seed.toString()
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        title: Text('排序算法配置'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('数据数量(个数):'),
                const SizedBox(width: 20,),
                Expanded(child: TextField(
                  controller: _count,
                )),
              ],
            ),
            Row(
              children: [
                Text('时间间隔(微秒):'),
                const SizedBox(width: 20,),
                Expanded(child: TextField(
                  controller: _duration,
                )),
              ],
            ),
            Row(
              children: [
                Text('随机种子:'),
                const SizedBox(width: 20,),
                Expanded(child: TextField(
                  controller: _seed,
                )),
              ],
            ),
            Spacer(),
            ElevatedButton(onPressed: (){

              sortConfig.value = SortConfig(int.parse(_count.text), Duration(
                microseconds: int.parse(_duration.text),
              ),int.parse(_seed.text),sortConfig.value.name);

              Navigator.of(context).pop();
            }, child: Text('确定设置'))
          ],
        ),
      ),
    );
  }
}
