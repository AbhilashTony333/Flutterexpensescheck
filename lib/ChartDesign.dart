import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartDesign extends StatelessWidget {
  String WeekDay;
  double Amount;
  double percent;

  ChartDesign(this.WeekDay, this.Amount, this.percent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Column(
          children: [
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(child: Text(WeekDay))),
            Container(
              height: constraints.maxHeight * 0.7,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black, width: 2)),
                  ),
                  FractionallySizedBox(
                    heightFactor: percent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.purple, width: 2)),
                    ),
                  )
                ],
              ),
            ),
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(child: Text(Amount.toStringAsFixed(0))))
          ],
        ),
      );
    });
  }
}
