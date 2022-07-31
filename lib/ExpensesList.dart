import 'package:expensescheck/DataClass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesList extends StatelessWidget {
  List<WeeklyData> AllData;
  final Function del;

  ExpensesList(this.AllData, this.del);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: ListView.builder(
          itemBuilder: (contexxxt, ind) {
            return Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  child: FittedBox(
                      child: Text(AllData[ind].amount.toStringAsFixed(0))),
                ),
                title: Text(AllData[ind].name),
                subtitle:
                    Text(DateFormat.MMMMEEEEd().format(AllData[ind].date)),
                trailing: MediaQuery.of(context).size.width > 400
                    ? ElevatedButton.icon(
                        onPressed: () => del(AllData[ind].id),
                        icon: Icon(Icons.delete),
                        label: Text('Delete'))
                    : IconButton(
                        onPressed: () => del(AllData[ind].id),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),
              ),
            );
          },
          itemCount: AllData.length,
        ));
  }
}
