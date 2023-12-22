import 'dart:math';

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      child: LayoutBuilder(
        builder: (ctx, constraints) => World(size: constraints.biggest),
      ),
    );
  }
}

class World extends StatefulWidget {
  final Size size;

  const World({Key? key, required this.size}) : super(key: key);

  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ParticleManage pm = ParticleManage();
  Random random = Random();

  @override
  void initState() {
    super.initState();
    loadImageFromAssets("assets/images/sword.png");
    pm.size = widget.size;

    initParticles();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..addListener(pm.tick)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  theWorld() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: widget.size.width,
            height: widget.size.height,
            child: Image.asset(
              'assets/images/bg.jpeg',
              fit: BoxFit.cover,
            )),
        GestureDetector(
          onTap: theWorld,
          child: CustomPaint(
            size: pm.size,
            painter: WorldRender(
              manage: pm,
            ),
          ),
        ),
      ],
    );
  }

  //读取 assets 中的图片
  void loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    pm.setImage(await decodeImageFromList(data.buffer.asUint8List()));
  }

  void initParticles() {
    for (int i = 0; i < 60; i++) {
      Particle particle = Particle(
          x: pm.size.width / 60 * i,
          y: 0,
          vx: 1 * random.nextDouble() * pow(-1, random.nextInt(20)),
          vy: 4 * random.nextDouble() + 1);
      pm.particles.add(particle);
    }
  }
}

class WorldRender extends CustomPainter {
  final ParticleManage manage;

  Paint fillPaint = Paint()
    ..colorFilter = ColorFilter.matrix(<double>[
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      0.4,
      0,
    ]);

  Paint stokePaint = Paint()
    ..strokeWidth = 0.5
    ..style = PaintingStyle.stroke;

  WorldRender({required this.manage}) : super(repaint: manage);

  @override
  void paint(Canvas canvas, Size size) {
    if (manage.image == null) return;
    // canvas.drawRect(Offset.zero&size, stokePaint);
    manage.particles.forEach((particle) {
      drawParticle(canvas, particle);
    });
  }

  void drawParticle(Canvas canvas, Particle particle) {
    fillPaint.color = particle.color;
    if (manage.image == null) return;
    canvas.save();
    canvas.translate(particle.x, particle.y);
    var dis = sqrt(particle.vy * particle.vy + particle.vx * particle.vx);
    canvas.rotate(acos(particle.vx / dis) + pi + pi / 2);
    canvas.drawImageRect(
        manage.image!,
        Rect.fromLTWH(
            0, 0, manage.image!.width * 1.0, manage.image!.height * 1.0),
        Rect.fromLTWH(
            0, 0, manage.image!.width * 0.18, manage.image!.height * 0.18),
        fillPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant WorldRender oldDelegate) =>
      oldDelegate.manage != manage;
}

class ParticleManage with ChangeNotifier {
  List<Particle> particles = [];
  Random random = Random();
  ui.Image? image;

  void setImage(ui.Image image) {
    this.image = image;
    notifyListeners();
  }

  Size size;

  ParticleManage({this.size = Size.zero});

  void setParticles(List<Particle> particles) {
    this.particles = particles;
  }

  void addParticle(Particle particle) {
    particles.add(particle);
    notifyListeners();
  }

  void tick() {
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
      p.y = 0;
    }
  }

  void reset() {
    particles.forEach((p) {
      p.x = 0;
    });
    notifyListeners();
  }

  Color randomRGB({
    int limitR = 0,
    int limitG = 0,
    int limitB = 0,
  }) {
    var r = limitR + random.nextInt(256 - limitR); //红值
    var g = limitG + random.nextInt(256 - limitG); //绿值
    var b = limitB + random.nextInt(256 - limitB); //蓝值
    return Color.fromARGB(255, r, g, b); //生成argb模式的颜色
  }
}

class Particle {
  /// x 位移.
  double x;

  /// y 位移.
  double y;

  /// 粒子水平速度.
  double vx;

  // 粒子水平加速度
  double ax;

  // 粒子竖直加速度
  double ay;

  ///粒子竖直速度.
  double vy;

  /// 粒子大小.
  double size;

  /// 粒子颜色.
  Color color;

  Particle({
    this.x = 0,
    this.y = 0,
    this.ax = 0,
    this.ay = 0,
    this.vx = 0,
    this.vy = 0,
    this.size = 0,
    this.color = Colors.black,
  });

  Particle copyWith(
          {double? x,
          double? y,
          double? ax,
          double? ay,
          double? vx,
          double? vy,
          double? size,
          Color? color}) =>
      Particle(
          x: x ?? this.x,
          y: y ?? this.y,
          ax: ax ?? this.ax,
          ay: ay ?? this.ay,
          vx: vx ?? this.vx,
          vy: vy ?? this.vy,
          size: size ?? this.size,
          color: color ?? this.color);
}
