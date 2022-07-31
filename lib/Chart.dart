import 'package:expensescheck/ChartDesign.dart';
import 'package:expensescheck/DataClass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<WeeklyData> recent;

  Chart(this.recent);

  List<Map<String, Object>> get GroupedTx {
    return List.generate(7, (index) {
      var Weekend = DateTime.now().subtract(Duration(days: index));
      double totalDay = 0.0;

      for (int i = 0; i < recent.length; i++) {
        if (recent[i].date.day == Weekend.day &&
            recent[i].date.month == Weekend.month &&
            recent[i].date.year == Weekend.year) {
          totalDay += recent[i].amount;
        }
      }
      return {'Day': DateFormat.E().format(Weekend), 'TotalPerDay': totalDay};
    }).reversed.toList();
  }

  double get totalPerWeek {
    return GroupedTx.fold(0.0, (Sum, element) {
      return Sum += element['TotalPerDay'] as double;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
        child: Row(
          children: GroupedTx.map((e) {
            return Container(
              child: Flexible(
                fit: FlexFit.tight,
                child: ChartDesign(e['Day'] as String, e['TotalPerDay']as double,totalPerWeek==0.0?0.0: (e['TotalPerDay']as double)/totalPerWeek ),
              ),
            );
          }).toList() ,
        ));
  }
}
