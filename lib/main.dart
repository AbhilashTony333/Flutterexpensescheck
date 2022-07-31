import 'dart:io';
import 'package:expensescheck/Chart.dart';
import 'package:expensescheck/DataClass.dart';
import 'package:expensescheck/ExpensesList.dart';
import 'package:expensescheck/NewTransaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(WeeklyCheck());
}

class WeeklyCheck extends StatelessWidget {
  const WeeklyCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple, accentColor: Colors.white),
      home: MyWeeklyExpense(),
    );
  }
}

class MyWeeklyExpense extends StatefulWidget {
  const MyWeeklyExpense({Key? key}) : super(key: key);

  @override
  State<MyWeeklyExpense> createState() => _MyWeeklyExpenseState();
}

class _MyWeeklyExpenseState extends State<MyWeeklyExpense> {
  bool isChecked = true;
  List<WeeklyData> DataList = [];

  List<WeeklyData> get recentTx {
    return DataList.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void AddNewTx(String Name, double Amount, DateTime Date) {
    final newTx = WeeklyData(
        id: DateTime.now().toString(), name: Name, amount: Amount, date: Date);
    setState(() {
      DataList.add(newTx);
    });
  }

  void del(String id) {
    setState(() {
      DataList.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(AddNewTx);
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery
            .of(context)
            .orientation == Orientation.landscape;
    final appBarr = AppBar(
      title: Text('Weekly Expense'),
      actions: [
        IconButton(
          onPressed: () => openBottomSheet(context),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
      ],
    );
    final txList = Container(
        height: (MediaQuery
            .of(context)
            .size
            .height -
            appBarr.preferredSize.height -
            MediaQuery
                .of(context)
                .padding
                .top) *
            0.7,
        child: DataList.isEmpty
            ? SizedBox(
          child: Card(
            child: Image.asset(
              'assetsu/Drawables/Brahmi.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
        )
            : ExpensesList(DataList, del));
    return Scaffold(
      appBar: appBarr,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isLandScape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.blueGrey,
                )
              ],
            ),
          if (!isLandScape)
            Container(
                height: (MediaQuery
                    .of(context)
                    .size
                    .height -
                    appBarr.preferredSize.height -
                    MediaQuery
                        .of(context)
                        .padding
                        .top) *
                    0.2,
                child: Chart(recentTx)),
          if (!isLandScape) txList,
          if (isLandScape)
            isChecked
                ? Container(
                height: (MediaQuery
                    .of(context)
                    .size
                    .height -
                    appBarr.preferredSize.height -
                    MediaQuery
                        .of(context)
                        .padding
                        .top) *
                    0.7,
                child: Chart(recentTx))
                : txList,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Platform.isIOS ? Container(): FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () => openBottomSheet(context),
      ),
    );
  }
}
