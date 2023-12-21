import 'dart:math';

// import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      child: const World(),
    );
  }
}

class World extends StatefulWidget {
  const World({super.key});

  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ParticleManage pm = ParticleManage();

  @override
  void initState() {
    super.initState();
    initParticleManage();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..addListener(pm.tick)
    // ..repeat()
        ;
  }

  void initParticleManage() {
    pm.size = Size(300, 200);
    Particle particle = Particle(x: 0, y: 0, vx: 3, vy: 0,ay: 0.05,
        color: Colors.blue, size: 8);
    pm.particles = [particle];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  theWorld(){
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: theWorld,
      child: CustomPaint(
        size: pm.size,
        painter: WorldRender(manage: pm),
      ),
    );
  }
}

class ParticleManage with ChangeNotifier {
  List<Particle> particles = [];

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
    particles.forEach(doUpdate);
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
      p.y = size.height;
      p.vy = -p.vy;
    }
    if (p.y < 0) {
      p.y = 0;
      p.vy = -p.vy;
    }
  }

  void reset() {
    particles.forEach((p) {
      p.x = 0;
    });
    notifyListeners();
  }
}

class WorldRender extends CustomPainter {

  final ParticleManage manage;

  Paint fillPaint = Paint();

  Paint stokePaint = Paint()
    ..strokeWidth = 0.5
    ..style = PaintingStyle.stroke;

  WorldRender({required this.manage}) : super(repaint: manage);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, stokePaint);
    manage.particles.forEach((particle) {
      drawParticle(canvas, particle);
    });
  }

  void drawParticle(Canvas canvas, Particle particle) {
    fillPaint.color = particle.color;
    canvas.drawCircle(Offset(particle.x, particle.y), particle.size, fillPaint);
  }

  @override
  bool shouldRepaint(covariant WorldRender oldDelegate) =>
      oldDelegate.manage != manage;
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
}
