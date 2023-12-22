import 'dart:async';
import 'dart:math';

// import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;

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
  Random random = Random();

  @override
  void initState() {
    super.initState();

    pm.size = Size(400, 260);

    initParticles();

    // pm.addParticle(Particle(
    //     color: Colors.blue,
    //     size: 50,
    //     vx: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
    //     vy: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
    //     ay: 0.1,
    //     ax: 0.1,
    //     x: 150,
    //     y: 100));

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(pm.tick)
    // ..repeat()
        ;
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
    return GestureDetector(
      onTap: theWorld,
      child: CustomPaint(
        size: pm.size,
        painter: WorldRender(manage: pm),
      ),
    );
  }

  void initParticles() async {
    ByteData data = await rootBundle.load("assets/images/flutter.png");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    image.Image? imageSrc = image.decodeImage(Uint8List.fromList(bytes));
    if(imageSrc==null) return;

    double offsetX=  (pm.size.width-imageSrc.width)/2;
    double offsetY=  (pm.size.height-imageSrc.height)/2;

    for (int i = 0; i < imageSrc.width; i++) {
      for (int j = 0; j < imageSrc.height; j++) {
        image.PixelUint8 pixel = imageSrc.getPixel(i, j) as image.PixelUint8;
        var color = Color.fromARGB(pixel.a.toInt(),pixel.r.toInt(),pixel.g.toInt(),pixel.b.toInt());
        print('-($i,$j)----${color.value}---------------');

        if (color.value == 4278190080) {

          Particle particle = Particle(
              x: i * 1.0+ offsetX,
              y: j * 1.0+ offsetY,
              vx: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
              vy: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
              ay: 0.1,
              size: 0.5,
              color: Colors.blue); //产生粒子---每个粒子拥有随机的一些属性信息

          pm.particles.add(particle);
        }
      }
    }
    pm.tick();
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
    // canvas.drawRect(Offset.zero&size, stokePaint);
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
