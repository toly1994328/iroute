import 'dart:convert';
import 'dart:math';
import 'dart:ui';

// import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// create by 张风捷特烈 on 2020/11/5
/// contact me by email 1981462002@qq.com
/// 说明:

class Paper extends StatelessWidget {
  const Paper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const ClockPanel(),
    );
  }
}



class BgManage with ChangeNotifier {
  late List<Particle> particles;
  late DateTime datetime; // 时间
  Random random = Random();

  /// 粒子列表
  int numParticles;

  /// 最大粒子数
  Size size; // 尺寸

  BgManage({required this.size, this.numParticles = 500}) {
    particles = [];
    datetime = DateTime.now();
  }

  checkParticles(DateTime now) {
    //判断当前时间是否改变,再将点位放到集合中
    if ((datetime.hour ~/ 10) != (now.hour ~/ 10)) {
      collectDigit(target: datetime.hour ~/ 10, offsetRate: 0);
    }
    if ((datetime.hour % 10) != (now.hour % 10)) {
      collectDigit(target: datetime.hour % 10, offsetRate: 1);
    }
    if ((datetime.minute ~/ 10) != (now.minute ~/ 10)) {
      collectDigit(target: datetime.minute ~/ 10, offsetRate: 2.5);
    }
    if ((datetime.minute % 10) != (now.minute % 10)) {
      collectDigit(target: datetime.minute % 10, offsetRate: 3.5);
    }
    if ((datetime.second ~/ 10) != (now.second ~/ 10)) {
      collectDigit(target: datetime.second ~/ 10, offsetRate: 5);
    }
    if ((datetime.second % 10) != (now.second % 10)) {
      collectDigit(target: datetime.second % 10, offsetRate: 6);
      datetime = now;
    }
  }

  double _radius = 4;

  void collectDigit({int target = 0, double offsetRate = 0}) {
    if (target > 10) {
      return;
    }

    double space = _radius * 2;
    double offSetX =
        (digits[target][0].length * 2 * (_radius + 1) + space) * offsetRate;

    for (int i = 0; i < digits[target].length; i++) {
      for (int j = 0; j < digits[target][j].length; j++) {
        if (digits[target][i][j] == 1) {
          double rX = j * 2 * (_radius + 1) + (_radius + 1); //第(i，j)个点圆心横坐标
          double rY = i * 2 * (_radius + 1) + (_radius + 1); //第(i，j)个点圆心纵坐标
          Particle particle = Particle(
              x: rX + offSetX,
              y: rY,
              size: _radius,
              color: randomColor(),
              active: true,
              vx: 2.5 * random.nextDouble() * pow(-1, random.nextInt(20)),
              vy: 2 * random.nextDouble() + 1);
          particles.add(particle);
        }
      }
    }
  }

  Color randomColor({
    int limitA = 120,
    int limitR = 0,
    int limitG = 0,
    int limitB = 0,
  }) {
    var a = limitA + random.nextInt(256 - limitA); //透明度值
    var r = limitR + random.nextInt(256 - limitR); //红值
    var g = limitG + random.nextInt(256 - limitG); //绿值
    var b = limitB + random.nextInt(256 - limitB); //蓝值
    return Color.fromARGB(a, r, g, b); //生成argb模式的颜色
  }

  void tick(DateTime now) {
    checkParticles(now);

    for (int i = 0; i < particles.length; i++) {
      doUpdate(particles[i]);
    }
    notifyListeners();
  }

  void doUpdate(Particle p) {
    p.vy += p.ay; // y加速度变化
    p.vx += p.ax; // x加速度变化
    p.x += p.vx;
    p.y += p.vy;

    if (p.x > size.width) {
      p.x = size.width;
      p.vx = -p.vx;
    }

    if (p.x < 0) {
      p.x = 0;
      p.vx = -p.vx;
    }

    if (p.y > size.height) {
      particles.remove(p);
    }
  }
}

class BgPainter extends CustomPainter {
  final BgManage manage;

  BgPainter({required this.manage}) : super(repaint: manage);

  Paint clockPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {

    manage.particles.forEach((particle) {
      clockPaint..color = particle.color;
      canvas.drawCircle(
          Offset(particle.x, particle.y), particle.size, clockPaint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
class ClockManage with ChangeNotifier {
  late List<Particle> particles;
  late DateTime datetime; // 时间

  /// 粒子列表
  int numParticles;

  /// 最大粒子数
  Size size; // 尺寸

  ClockManage({required this.size, this.numParticles = 500}) {
    particles = List.filled(numParticles,Particle());
    datetime = DateTime.now();
  }

  collectParticles(DateTime datetime) {
    count = 0;
    particles.forEach((Particle element) {
      if(element!=null){
        element.active = false;
      }
    });

    collectDigit(target: datetime.hour ~/ 10, offsetRate: 0);
    collectDigit(target: datetime.hour % 10, offsetRate: 1);
    collectDigit(target: 10, offsetRate: 3.2);
    collectDigit(target: datetime.minute ~/ 10, offsetRate: 2.5);
    collectDigit(target: datetime.minute % 10, offsetRate: 3.5);
    collectDigit(target: 10, offsetRate: 7.25);
    collectDigit(target: datetime.second ~/ 10, offsetRate: 5);
    collectDigit(target: datetime.second % 10, offsetRate: 6);
  }

  int count = 0;
  double _radius = 4;

  void collectDigit({int target = 0, double offsetRate = 0}) {
    if (target > 10 && count > numParticles) {
      return;
    }

    double space = _radius * 2;
    double offSetX = (digits[target][0].length * 2 * (_radius + 1) + space) *
        offsetRate;

    for (int i = 0; i < digits[target].length; i++) {
      for (int j = 0; j < digits[target][j].length; j++) {
        if (digits[target][i][j] == 1) {
          double rX = j * 2 * (_radius + 1) + (_radius + 1); //第(i，j)个点圆心横坐标
          double rY = i * 2 * (_radius + 1) + (_radius + 1); //第(i，j)个点圆心纵坐标
          particles[count] = Particle(x: rX + offSetX,
              y: rY, size: _radius, color: Colors.blue,
              active: true);
          count++;
        }
      }
    }
  }

  void tick(DateTime now) {
    collectParticles(now);
    notifyListeners();
  }

  void doUpdate(Particle p, DateTime datetime) {

  }
}

class ClockPainter extends CustomPainter {
  final ClockManage manage;

  ClockPainter({required this.manage}) : super(repaint: manage);

  Paint clockPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    manage.particles.where((e) => e!=null&&e.active).forEach((particle) {
      clockPaint..color = particle.color;
      canvas.drawCircle(
          Offset(particle.x, particle.y), particle.size, clockPaint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ClockPanel extends StatefulWidget {
  const ClockPanel({super.key});

  @override
  _ClockPanelState createState() => _ClockPanelState();
}

class _ClockPanelState extends State<ClockPanel>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  late ClockManage pm;

  late BgManage bgManage;

  @override
  void initState() {
    super.initState();
    pm = ClockManage(size: Size(550, 200));
    bgManage = BgManage(size: Size(550, 200));

    _ticker = createTicker(_tick)
      ..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: pm.size,
      painter: ClockPainter(manage: pm),
      foregroundPainter: BgPainter(manage: bgManage),
    );
  }

  void _tick(Duration duration) {
    DateTime now = DateTime.now();

    if (now.millisecondsSinceEpoch - pm.datetime.millisecondsSinceEpoch > 1000) {
      pm..datetime = now..tick(now);
    }
    bgManage..tick(now);
  }
}

class Particle {
  /// x 位移.
  double x;

  /// y 位移.
  double y;

  /// 粒子大小.
  double size;

  /// 粒子颜色.
  Color color;

  bool active; // 粒子是否可用

  double vx; /// 粒子水平速度.
  double ax; // 粒子水平加速度
  double ay; // 粒子竖直加速度
  double vy; ///粒子竖直速度.

  Particle({
    this.x = 0,
    this.y = 0,
    this.size = 0,
    this.vx=0,
    this.ax=0,
    this.ay=0,
    this.vy=0,
    this.active = true,
    this.color = Colors.black,
  });
}

const colors = [
  Color(0x8833B5E5),
  Color(0x880099CC),
  Color(0x889933CC),
  Color(0x8899CC00),
  Color(0x88669900),
  Color(0x88FFBB33),
  Color(0x88FF8800),
  Color(0x88FF4444),
  Color(0x88CC0000)
];

const digits = [
  [
    [0, 0, 1, 1, 1, 0, 0],
    [0, 1, 1, 0, 1, 1, 0],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [0, 1, 1, 0, 1, 1, 0],
    [0, 0, 1, 1, 1, 0, 0]
  ], //0

  [
    [0, 0, 0, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 0, 0],
    [1, 1, 1, 1, 1, 1, 1]
  ], //1
  [
    [0, 1, 1, 1, 1, 1, 0],
    [1, 1, 0, 0, 0, 1, 1],
    [0, 0, 0, 0, 0, 1, 1],
    [0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 1, 1, 0, 0],
    [0, 0, 1, 1, 0, 0, 0],
    [0, 1, 1, 0, 0, 0, 0],
    [1, 1, 0, 0, 0, 0, 0],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 1, 1, 1, 1, 1]
  ], //2
  [
    [1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 0, 1, 1],
    [0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 1, 1, 0, 0],
    [0, 0, 1, 1, 1, 0, 0],
    [0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 0, 1, 1],
    [0, 0, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [0, 1, 1, 1, 1, 1, 0]
  ], //3

  [
    [0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 1, 0],
    [0, 1, 1, 0, 1, 1, 0],
    [1, 1, 0, 0, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 1, 1, 1, 1]
  ], //4
  [
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 0, 0, 0, 0, 0],
    [1, 1, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 1, 0],
    [0, 0, 0, 0, 0, 1, 1],
    [0, 0, 0, 0, 0, 1, 1],
    [0, 0, 0, 0, 0, 1, 1],
    [0, 0, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [0, 1, 1, 1, 1, 1, 0]
  ], //5
  [
    [0, 0, 0, 0, 1, 1, 0],
    [0, 0, 1, 1, 0, 0, 0],
    [0, 1, 1, 0, 0, 0, 0],
    [1, 1, 0, 0, 0, 0, 0],
    [1, 1, 0, 1, 1, 1, 0],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [0, 1, 1, 1, 1, 1, 0]
  ], //6
  [
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 0, 0],
    [0, 0, 1, 1, 0, 0, 0],
    [0, 0, 1, 1, 0, 0, 0],
    [0, 0, 1, 1, 0, 0, 0],
    [0, 0, 1, 1, 0, 0, 0]
  ], //7
  [
    [0, 1, 1, 1, 1, 1, 0],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [0, 1, 1, 1, 1, 1, 0],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [0, 1, 1, 1, 1, 1, 0]
  ], //8
  [
    [0, 1, 1, 1, 1, 1, 0],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 1, 1],
    [0, 1, 1, 1, 0, 1, 1],
    [0, 0, 0, 0, 0, 1, 1],
    [0, 0, 0, 0, 0, 1, 1],
    [0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 1, 1, 0, 0],
    [0, 1, 1, 0, 0, 0, 0]
  ], //9
  [
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 1, 1, 0],
    [0, 1, 1, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 1, 1, 0],
    [0, 1, 1, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0]
  ] //:
];
