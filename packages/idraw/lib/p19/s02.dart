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
      child: Screen(),
    );
  }
}




final easingDelayDuration = Duration(seconds: 15);

class BgFx extends ClockFx {
  BgFx({required Size size, required DateTime time})
      : super(
    size: size,
    time: time,
    numParticles: 120,
  );

  @override
  void tick(Duration duration) {
    var secFrac = 1 - (DateTime.now().millisecond / 1000);

    var vecSpeed = duration.compareTo(easingDelayDuration) > 0
        ? max(.2, Curves.easeInOutSine.transform(secFrac))
        : 1;

    particles.forEach((p) {
      p.y -= p.vy * vecSpeed;

      if (p.y > height || p.y < 0 || p.life == 0) {
        _activateParticle(p);
      }
    });

    super.tick(duration);
  }

  void _activateParticle(Particle p) {
    var xRnd = Rnd.getDouble(0, width / 5);
    p.x = Rnd.getBool() ? width - xRnd : 0 + xRnd;
    p.y = Rnd.getDouble(0, height);
    p.a = Rnd.ratio > .95 ? Rnd.getDouble(.6, .8) : Rnd.getDouble(.08, .4);
    p.isFilled = Rnd.getBool();
    p.size = Rnd.getDouble(height / 20, height / 5);

    p.life = 1;

    p.vx = 0;
    p.vy = Rnd.getDouble(-3, 3);

    double v = Rnd.getDouble(.1, .5);

    p.vx = 0;
    p.vy *= v;
  }
}


class ClockBgParticlePainter extends CustomPainter {
  ClockFx fx;

  ClockBgParticlePainter({required this.fx}) : super(repaint: fx);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero&size);
    fx.particles.forEach((p) {
      var pos = Offset(p.x, p.y);

      var paint = Paint()
        ..color = p.color.withAlpha((255 * p.a).floor())
        ..strokeWidth = p.size * .2
        ..style = p.isFilled ? PaintingStyle.fill : PaintingStyle.stroke;

      if (p.isFilled) {
        var rect = Rect.fromCenter(
          center: pos,
          width: p.size,
          height: p.size,
        );

        canvas.drawRect(rect, paint);
      } else {
        canvas.drawCircle(pos, p.size / 1.2, paint);
      }
    });
  }

  @override
  bool shouldRepaint(_) => false;
}


final Color transparent = Color.fromARGB(0, 0, 0, 0);

abstract class ClockFx with ChangeNotifier {
  /// 可用画板宽度
  double width = 0;

  /// 可用画板盖度
  double height = 0;

  /// 宽高最小值
  double sizeMin = 0;

  /// 画板中心
  Offset center = Offset.zero;

  /// 产生新粒子的区域
  Rect spawnArea = Rect.zero;

  /// 绘制时的颜色集
  Palette? palette;

  /// 粒子集合
  late List<Particle> particles;

  /// 最大粒子数
  int numParticles;

  /// Date and time used for rendering time-specific effects.
  DateTime time;

  ClockFx({
    required Size size,
    required this.time,
    this.numParticles = 5000,
  }) {
    this.time = time;

    particles = List.filled(numParticles, Particle());
    // growableList.length = 3;
    palette = Palette(components: [transparent, transparent]);
    setSize(size);
  }

  /// Initializes the particle effect by resetting all the particles and assigning a random color from the palette.
  void init() {
    if (palette == null) return;
    for (int i = 0; i < numParticles; i++) {
      var color = Rnd.getItem(palette!.components);
      particles[i] = Particle(color: color);
      resetParticle(i);
    }
  }

  /// Sets the palette used for coloring.
  void setPalette(Palette palette) {
    this.palette = palette;
    var colors = palette.components.sublist(1);
    var accentColor = colors[colors.length - 1];
    particles.where((p) => p != null).forEach((p) => p.color =
    p.type == ParticleType.noise ? Rnd.getItem(colors) : accentColor);
  }

  /// Sets the time used for time-specific effects.
  void setTime(DateTime time) {
    this.time = time;
  }

  /// Sets the canvas size and updates dependent values.
  void setSize(Size size) {
    width = size.width;
    height = size.height;
    sizeMin = min(width, height);
    center = Offset(width / 2, height / 2);
    spawnArea = Rect.fromLTRB(
      center.dx - sizeMin / 100,
      center.dy - sizeMin / 100,
      center.dx + sizeMin / 100,
      center.dy + sizeMin / 100,
    );
    init();
  }

  /// Resets a particle's values.
  Particle resetParticle(int i) {
    Particle p = particles[i];
    p.size = p.a = p.vx = p.vy = p.life = p.lifeLeft = 0;
    p.x = center.dx;
    p.y = center.dy;
    return p;
  }

  void tick(Duration duration) {
    notifyListeners();
  }
}


/// Holds a list of colors.
class Palette {

  /// The palette's color members. All unique.
  List<Color> components;

  Palette({required this.components});

  /// Creates a new palette from JSON.
  factory Palette.fromJson(List<dynamic> json) {
    var components = json.map((c) => Color(int.tryParse(c)!)).toList();
    return Palette(components: components);
  }
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with SingleTickerProviderStateMixin{
  late BgFx _bgFx;
  late Ticker _ticker;
  Palette? _palette;

  @override
  void initState() {
    _bgFx = BgFx(
      size: Size(300, 200),
      time: DateTime.now(),
    );
    _init();


    super.initState();
  }


  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
        color: Color(0xff98D9B6).withAlpha(22),
        width: 300,
        height: 200,
        child: _buildBgBlurFx()));
  }

  void _init() async{
    List<Palette> palettes = await _loadPalettes();
    _palette = palettes[4];
    if(_palette==null) return;
    _bgFx.setPalette(_palette!);
    _ticker = createTicker(_tick)..start();

    setState(() {

    });
  }

  Future<List<Palette>> _loadPalettes() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/palettes.json");
    var palettes = json.decode(data) as List;
    return palettes.map((p) => Palette.fromJson(p)).toList();
  }


  Widget _buildBgBlurFx() {
    return
      RepaintBoundary(
        child: Stack(
          children: <Widget>[
            CustomPaint(

              painter: ClockBgParticlePainter(
                fx: _bgFx,
              ),
              child: Container(),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 300 * .05,
                sigmaY: 0,
              ),
              // filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(child: Text(" ")),
            ),
          ],
        ),
      );
  }


  void _tick(Duration duration) {
    if (DateTime.now().second % 5 == 0) _bgFx.tick(duration);
  }
}

class Particle {

  /// 粒子 x 位置
  double x;

  /// 粒子 y 位置
  double y;

  /// 粒子角度(弧度制)
  double a;

  /// 粒子水平速度
  double vx;

  /// 粒子垂直速度
  double vy;

  /// 距画布中心距离
  double dist;

  /// 到画布中心距离的百分比 (0-1).
  double distFrac;

  /// 粒子大小
  double size;

  /// 粒子生命长度 (0-1).
  double life;

  /// 粒子右侧粒子存货时间 (0-1).
  double lifeLeft;

  /// I粒子是否填充.
  bool isFilled;

  /// 粒子是否需要 "speed marks".
  bool isFlowing;

  /// 粒子颜色.
  Color color;

  /// 粒子描述
  int distribution;

  /// 粒子类型
  ParticleType type;

  Particle({
    this.x = 0,
    this.y = 0,
    this.a = 0,
    this.vx = 0,
    this.vy = 0,
    this.dist = 0,
    this.distFrac = 0,
    this.size = 0,
    this.life = 0,
    this.lifeLeft = 0,
    this.isFilled = false,
    this.isFlowing = false,
    this.color = Colors.black,
    this.distribution = 0,
    this.type = ParticleType.noise,
  });
}

enum ParticleType {
  hour,
  minute,
  noise,
}


class Rnd {
  static int _seed = DateTime.now().millisecondsSinceEpoch;
  static Random random = Random(_seed);

  static set seed(int val) => random = Random(_seed = val);
  static int get seed => _seed;

  /// Gets the next double.
  static get ratio => random.nextDouble();

  /// Gets a random int between [min] and [max].
  static int getInt(int min, int max) {
    return min + random.nextInt(max - min);
  }

  /// Gets a random double between [min] and [max].
  static double getDouble(double min, double max) {
    return min + random.nextDouble() * (max - min);
  }

  /// Gets a random boolean with chance [chance].
  static bool getBool([double chance = 0.5]) {
    return random.nextDouble() < chance;
  }

  /// Randomize the positions of items in a list.
  static List shuffle(List list) {
    for (int i = 0, l = list.length; i < l; i++) {
      int j = random.nextInt(l);
      if (j == i) {
        continue;
      }
      dynamic item = list[j];
      list[j] = list[i];
      list[i] = item;
    }
    return list;
  }

  /// Randomly selects an item from a list.
  static dynamic getItem(List list) {
    return list[random.nextInt(list.length)];
  }

  /// Gets a random palette from a list of palettes and sorts its' colors by luminance.
  ///
  /// Given if [dark] or not, this method makes sure the luminance of the background color is valid.
  static Palette getPalette(List<Palette?> palettes, bool dark) {
    Palette? result;

    while (result == null) {
      Palette palette = Rnd.getItem(palettes);
      List<Color> colors = Rnd.shuffle(palette.components).map<Color>((e) => e).toList();

      var luminance = colors[0].computeLuminance();

      if (dark ? luminance <= .1 : luminance >= .1) {
        var lumDiff = colors
            .sublist(1)
            .asMap()
            .map(
              (i, color) => MapEntry(
            i,
            [i, (luminance - color.computeLuminance()).abs()],
          ),
        )
            .values
            .toList();

        lumDiff.sort((List<num> a, List<num> b) {
          return a[1].compareTo(b[1]);
        });

        List<Color> sortedColors =
        lumDiff.map((d) => colors[(d[0] + 1).toInt()]).toList();

        result = Palette(
          components: [colors[0]] + sortedColors,
        );
      }
    }
    return result;
  }
}