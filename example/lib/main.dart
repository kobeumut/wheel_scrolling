import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wheel_scrolling/widget/clickable_list_wheel_widget.dart';
import 'package:wheel_scrolling/widget/wheel_widget.dart';

class TestExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      child: WheelWidget(
        size: 100,
        color: Colors.black,
        selectedColor: Colors.red,
        textColor: Colors.white,
        selectedTextColor: Colors.black,
        onSelectedItemChanged: (value) => log("$value secildi"),
      ),
    );
  }
}

class TestExample2 extends StatelessWidget {
  final double _defaultSize = 100;
  final double? size, textSize;
  final Color? color, selectedColor, textColor, selectedTextColor;

  TestExample2(
      {Key? key,
      this.size,
      this.color,
      this.selectedColor,
      this.textSize,
      this.textColor,
      this.selectedTextColor})
      : super(key: key);

  Widget _buildItem(int i) {
    return Center(
      child: Container(
          height: size ?? _defaultSize,
          width: size ?? _defaultSize,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular((size ?? _defaultSize) * 2)
              //more than 50% of width makes circle
              ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
                child: GestureDetector(
              onTap: () => log("message $i"),
              child: Text(
                "test - ${i.toString()}",
                style: TextStyle(color: textColor, fontSize: textSize ?? 20),
              ),
            )),
          )),
    );
  }

  ScrollController controller = ScrollController(initialScrollOffset: 20);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      height: 400,
      child: ClickableListWheelScrollView(
        child: ListWheelScrollView(
          controller: controller,
          children: List.generate(
              20,
              (index) =>
                  InkWell(onTap: () => log("test"), child: _buildItem(index))),
          itemExtent: size ?? 40,
        ),
        itemCount: 20,
        listHeight: 400,
        onItemTapCallback: (index) => log("tiklandi $index"),
        itemHeight: size ?? 40,
        scrollController: controller,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: TestExample(),
          )),
    );
  }
}

void main() => runApp(MyApp());
