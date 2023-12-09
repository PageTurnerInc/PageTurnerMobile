import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentBar extends StatefulWidget {
  final int count;
  final int total;
  final int index;

  const PercentBar({
    required this.count,
    required this.total,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PercentBarState createState() => _PercentBarState();
}

class _PercentBarState extends State<PercentBar> {
  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      width: 100, //width for progress bar
      animation: true, //animation to show progress at first
      animationDuration: 1000,
      leading: Padding( //prefix content
        padding: const EdgeInsets.only(right: 8),
        child: Text(widget.index.toString()), //left content
      ),
      trailing: Padding( //sufix content
        padding: const EdgeInsets.only(left: 8),
        child:Text("${widget.count} (${double.parse(((widget.count.toDouble() / widget.total.toDouble()) * 100.0).toStringAsFixed(1))}%)"), //right content
      ),
      percent: double.parse(((widget.count.toDouble() / widget.total.toDouble())).toStringAsFixed(1)), // 30/100 = 0.3
      progressColor: Colors.blue, //percentage progress bar color
      backgroundColor: Colors.grey[400],
    );
  }
}