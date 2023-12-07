// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class SearchAnchorDemo extends StatefulWidget {
  const SearchAnchorDemo({super.key});

  @override
  State<SearchAnchorDemo> createState() => _SearchAnchorDemoState();
}

class _SearchAnchorDemoState extends State<SearchAnchorDemo> {
  Color? selectedColorSeed;
  List<ColorLabel> searchHistory = <ColorLabel>[];

  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map(
      (ColorLabel color) => ListTile(
        leading: const Icon(Icons.history),
        title: Text(color.label),
        trailing: IconButton(
          icon: const Icon(Icons.call_missed),
          onPressed: () {
            controller.text = color.label;
            controller.selection = TextSelection.collapsed(offset: controller.text.length);
          },
        ),
      ),
    );
  }

  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text;
    return ColorLabel.values.where((ColorLabel color) => color.label.contains(input)).map(
          (ColorLabel filteredColor) => ListTile(
            leading: CircleAvatar(backgroundColor: filteredColor.color),
            title: Text(filteredColor.label),
            trailing: IconButton(
              icon: const Icon(Icons.call_missed),
              onPressed: () {
                controller.text = filteredColor.label;
                controller.selection = TextSelection.collapsed(offset: controller.text.length);
              },
            ),
            onTap: () {
              controller.closeView(filteredColor.label);
              handleSelection(filteredColor);
            },
          ),
        );
  }

  void handleSelection(ColorLabel selectedColor) {
    setState(() {
      selectedColorSeed = selectedColor.color;
      if (searchHistory.length >= 5) {
        searchHistory.removeLast();
      }
      searchHistory.insert(0, selectedColor);
    });
  }

  Map<String,Color> colorMaps(ColorScheme colors) => {
    'primary':colors.primary ,
    'secondary':colors.secondary ,
    'inverseSurface':colors.inverseSurface ,
    'background':colors.background ,


    'onPrimaryContainer':colors.onPrimaryContainer ,
    'onErrorContainer':colors.onErrorContainer ,
    'onBackground':colors.onBackground ,
    'onTertiaryContainer':colors.onTertiaryContainer ,


    'error':colors.error ,
    'inversePrimary':colors.inversePrimary ,
    'primaryContainer':colors.primaryContainer ,
    'errorContainer':colors.errorContainer ,

    'onPrimary':colors.onPrimary ,
    'onSecondary':colors.onSecondary ,
    'onError':colors.onError ,
    'onTertiary':colors.onTertiary ,
    'onSurfaceVariant':colors.onSurfaceVariant ,
    'shadow':colors.shadow ,
  };



  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(useMaterial3: true, colorSchemeSeed: selectedColorSeed);
    final ColorScheme colors = themeData.colorScheme;
    Map<String,Color> data = colorMaps(colors);
    SizedBox cardSize = const SizedBox(
      width: 80,
      height: 30,
      child: Text(''),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('搜索颜色')),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            SearchAnchor.bar(
              barHintText: '输入颜色',
              suggestionsBuilder: (BuildContext context, SearchController controller) {
                if (controller.text.isEmpty) {
                  if (searchHistory.isNotEmpty) {
                    return getHistoryList(controller);
                  }
                  return <Widget>[Center(child: Text('暂无历史记录.', style: TextStyle(color: colors.outline)))];
                }
                return getSuggestions(controller);
              },
            ),
            cardSize,
            Wrap(
              children: data.keys.map((key) => Card(color: data[key], child: SizedBox(
                width: 80,
                height: 30,
                child: Center(child: Text(key,style: TextStyle(fontSize: 8,color: Colors.white,shadows: [
                  BoxShadow(color: Colors.black,offset: Offset(.1,.1),blurRadius: 2)
                ]),)),
              ))).toList(),
            ),

          ],
        ),
      ),
    );
  }
}


enum ColorLabel {
  red('red', Colors.red),
  orange('orange', Colors.orange),
  yellow('yellow', Colors.yellow),
  green('green', Colors.green),
  blue('blue', Colors.blue),
  indigo('indigo', Colors.indigo),
  violet('violet', Color(0xFF8F00FF)),
  purple('purple', Colors.purple),
  pink('pink', Colors.pink),
  silver('silver', Color(0xFF808080)),
  gold('gold', Color(0xFFFFD700)),
  beige('beige', Color(0xFFF5F5DC)),
  brown('brown', Colors.brown),
  grey('grey', Colors.grey),
  black('black', Colors.black),
  white('white', Colors.white);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}
