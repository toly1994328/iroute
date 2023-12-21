import 'dart:math';

// import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json;
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
      child: const ChinaMap(),
    );
  }
}

class ChinaMap extends StatefulWidget {
  const ChinaMap({super.key});

  @override
  _ChinaMapState createState() => _ChinaMapState();
}

class _ChinaMapState extends State<ChinaMap> {
  final String url = 'https://geo.datav.aliyun.com/areas_v2/bound/100000_full.json'; //全国点位详细信息

  //请求点位信息地址
  Future<MapRoot?> getMapRoot() async {
    try {
      final Response response = await Dio().get(url);
      if (response.data != null) {
        return MapRoot.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  late Future<MapRoot?> _future;

  @override
  void initState() {
    super.initState();
    _future = getMapRoot();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MapRoot?>(
      future: _future,
      builder: (context, async) {
        print(async.hasData);
        if (async.hasData) {
          return CustomPaint(
            size: Size(500, 400),
            painter: MapPainter(mapRoot: async.data),
          );
        } else {
          return CupertinoActivityIndicator();
        }
      },
    );
  }
}

class MapPainter extends CustomPainter {
  final MapRoot? mapRoot; //点位信息

  late Paint _paint;
  final List<Color> colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  int colorIndex = 0;

  MapPainter({required this.mapRoot}) {
    _paint = Paint()
      ..strokeWidth = 0.1
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if(mapRoot == null) return;
    if(mapRoot!.features ==null) return;

    canvas.clipRect(
        Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));
    canvas.translate(size.width / 2, size.height / 2);
    double dx = mapRoot!.features![0]?.geometry?.coordinates[0][0][0].dx??0;
    double dy = mapRoot!.features![0]?.geometry?.coordinates[0][0][0].dy??0;
    canvas.translate( -dx, -dy);

    double rate = 0.65;

    canvas.translate(-700*rate, 350*rate);
    canvas.scale(8*rate, -10.5*rate);

    _drawMap(canvas, size);
  }


  void _drawMap(Canvas canvas, Size size) {
    //全国省份循环
    for (int i = 0; i < mapRoot!.features!.length; i++) {
      var features = mapRoot!.features![i];
      if(features ==null) return;
      PaintingStyle style;
      Color color = Colors.black;
      style = PaintingStyle.fill;
      Path path = Path();
      if (features.properties?.name == "台湾省" ||
          features.properties?.name == "海南省" ||
          features.properties?.name == "河北省" ||
          features.properties?.name == "") { //海南和台湾和九段线
        Path otherPath = Path();
        features.geometry?.coordinates.forEach((List<List<Offset>> lv3) {
          for (var lv2 in lv3) {
            otherPath.moveTo(lv2[0].dx, lv2[0].dy);
            // for (var lv1 in lv2) {
            //   otherPath.lineTo(lv1.dx, lv1.dy); //优化一半点位
            //   print("========${lv1}==============================");
            // }
          }
        });
        path.addPath(otherPath, Offset.zero);
        if (features.properties?.name == "") {
          style = PaintingStyle.stroke;
          color = Colors.black;
        } else {
          style = PaintingStyle.fill;
          color = colors[colorIndex % 4];
        }
        colorIndex++;
      } else {

        final Offset first = features.geometry?.coordinates[0][0][0]??Offset.zero;
        path.moveTo(first.dx, first.dy);
        if(features.geometry ==null) return;
        for (Offset d in features.geometry!.coordinates.first.first) {
          path.lineTo(d.dx, d.dy);
        }
        style = PaintingStyle.fill;
        color = colors[colorIndex % 4];
        colorIndex++;
      }

      canvas.drawPath(path, _paint..color = color..style = style); //绘制地图
    }
  }

  @override
  bool shouldRepaint(MapPainter oldDelegate) => oldDelegate.mapRoot != mapRoot;
}




class MapRoot {
  String type;
  String name;
  List<Features?>? features;

  MapRoot({
    required this.type,
    required this.name,
    required this.features,
  });

  static MapRoot? fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Features?>? features = jsonRes['features'] is List ? [] : null;
    if (features != null) {
      for (var item in jsonRes['features']) {
        if (item != null) {
          features.add(Features.fromJson(item));
        }
      }
    }
    return MapRoot(
      type: jsonRes['type'],
      name: jsonRes['name'],
      features: features,
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'name': name,
    'features': features,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Features {
  String type;
  Properties? properties;
  Geometry? geometry;

  Features({
    required this.type,
    required this.properties,
    required this.geometry,
  });

  static Features? fromJson(jsonRes) => jsonRes == null
      ? null
      : Features(
    type: jsonRes['type'],
    properties: Properties.fromJson(jsonRes['properties']),
    geometry: Geometry.fromJson(jsonRes['geometry']),
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'properties': properties,
    'geometry': geometry,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Properties {
  String? adcode;
  String? name;
  List<double>? center;
  List<double>? centroid;
  int? childrenNum;
  String?level;
  Parent? parent;
  int? subFeatureIndex;
  List<int>? acroutes;
  Object? adchar;

  Properties({
    required this.adcode,
    required this.name,
    required this.center,
    required this.centroid,
    required this.childrenNum,
    required this.level,
    required this.parent,
    required this.subFeatureIndex,
    required this.acroutes,
    required this.adchar,
  });

  static Properties? fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<double>? center = jsonRes['center'] is List ? [] : null;
    if (center != null) {
      for (var item in jsonRes['center']) {
        if (item != null) {
          center.add(item);
        }
      }
    }

    List<double>? centroid = jsonRes['centroid'] is List ? [] : null;
    if (centroid != null) {
      for (var item in jsonRes['centroid']) {
        if (item != null) {
          centroid.add(item);
        }
      }
    }

    List<int>? acroutes = jsonRes['acroutes'] is List ? [] : null;
    if (acroutes != null) {
      for (var item in jsonRes['acroutes']) {
        if (item != null) {
          acroutes.add(item);
        }
      }
    }
    return Properties(
      adcode: jsonRes['adcode'],
      name: jsonRes['name'],
      center: center,
      centroid: centroid,
      childrenNum: jsonRes['childrenNum'],
      level: jsonRes['level'],
      parent: Parent.fromJson(jsonRes['parent']),
      subFeatureIndex: jsonRes['subFeatureIndex'],
      acroutes: acroutes,
      adchar: jsonRes['adchar'],
    );
  }

  Map<String, dynamic> toJson() => {
    'adcode': adcode,
    'name': name,
    'center': center,
    'centroid': centroid,
    'childrenNum': childrenNum,
    'level': level,
    'parent': parent,
    'subFeatureIndex': subFeatureIndex,
    'acroutes': acroutes,
    'adchar': adchar,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Parent {
  int adcode;

  Parent({
    required this.adcode,
  });

  static Parent? fromJson(jsonRes) => jsonRes == null
      ? null
      : Parent(
    adcode: jsonRes['adcode'],
  );

  Map<String, dynamic> toJson() => {
    'adcode': adcode,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Geometry {
  String type;
  List<List<List<Offset>>> coordinates;

  Geometry({
    required this.type,
    required this.coordinates,
  });

  static Geometry? fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<List<List<Offset>>>? coordinates =
    jsonRes['coordinates'] is List ? [] : null;

    bool fourLever =false;
    if (jsonRes['coordinates'] is List) {
      if (jsonRes['coordinates'][0] is List){
        if (jsonRes['coordinates'][0][0] is List){
          if (jsonRes['coordinates'][0][0][0] is List){
            fourLever =true;
          }
        }
      }
    }

    if(!fourLever){
      if (coordinates != null) {
        for (var level0 in jsonRes['coordinates']) {
          List<List<Offset>> lever0=[];
          if (level0 != null) {
            List<Offset> items1 = [];
            for (var item1 in level0 is List ? level0 : []) {
              if (item1 != null) {
                Offset items2 = Offset(item1[0], item1[1]);
                items1.add(items2);
              }
              lever0.add(items1);
            }
          }
          coordinates.add(lever0);
        }
      }
    }else{
      if (coordinates != null) {
        for (var level0 in jsonRes['coordinates']) {
          if (level0 != null) {
            List<List<Offset>> items1 = [];
            for (var item1 in level0 is List ? level0 : []) {
              if (item1 != null) {
                List<Offset> items2 = [];
                for (var item2 in item1 is List ? item1 : []) {
                  if (item2 != null && item2 is List) {
                    Offset items3 = Offset(item2[0], item2[1]);
                    items2.add(items3);
                  } else {
                    items2.add(Offset.zero);
                  }
                  items1.add(items2);
                }
              }
              coordinates.add(items1);
            }
          }
        }
      }
    }


    return Geometry(
      type: jsonRes['type'],
      coordinates: coordinates??[],
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'coordinates': coordinates,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}
