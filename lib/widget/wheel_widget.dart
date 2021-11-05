import 'dart:developer';

import 'package:wheel_scrolling/widget/wheel_scrolling_view.dart' as CWS;
import 'package:wheel_scrolling/widget/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WheelWidget extends StatefulWidget {
  final ValueChanged<int>? onSelectedItemChanged;

  final double? size, textSize;
  final Color? color, selectedColor, textColor, selectedTextColor;

  const WheelWidget(
      {Key? key,
      this.size,
      this.color,
      this.selectedColor,
      this.textSize,
      this.textColor,
      this.selectedTextColor,
      this.onSelectedItemChanged})
      : super(key: key);

  @override
  State<WheelWidget> createState() => _WheelWidgetState();
}

class _WheelWidgetState extends State<WheelWidget> {
  int? index;
  final double _defaultSize = 100;
  late CWS.FixedExtentScrollController _controller =
      CWS.FixedExtentScrollController(initialItem: 18);

  Widget _buildItem(int i) {
    return Center(
      child: Container(
          height: widget.size ?? _defaultSize,
          width: widget.size ?? _defaultSize,
          decoration: BoxDecoration(
              color: index == i ? widget.selectedColor : widget.color,
              borderRadius:
                  BorderRadius.circular((widget.size ?? _defaultSize) * 2)
              //more than 50% of width makes circle
              ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
                child: Text(
              "test - ${i.toString()}",
              style: TextStyle(
                  color:
                      index == i ? widget.selectedTextColor : widget.textColor,
                  fontSize: widget.textSize ?? 20),
            )),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => _controller
        .animateTo(0, duration: Duration(seconds: 3), curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClickableListWheelScrollView(
          itemCount: 20,
          listHeight: constraints.maxWidth,
          onItemTapCallback: (index) => log("tiklandi $index"),
          itemHeight: widget.size ?? _defaultSize,
          scrollController: _controller,
          child: CWS.CircleListScrollView(
              controller: _controller,
              physics: CWS.CircleFixedExtentScrollPhysics(),
              axis: Axis.horizontal,
              itemExtent: (widget.size ?? _defaultSize),
              children: List.generate(20, (index) => _buildItem(index)),
              radius: constraints.maxWidth * 0.4,
              onSelectedItemChanged: (int index) => setState(() {
                    widget.onSelectedItemChanged?.call(index);
                    this.index = index;
                  })),
        );
      },
    );
  }
}
