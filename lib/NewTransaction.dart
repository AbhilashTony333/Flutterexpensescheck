import 'dart:io';

import 'package:expensescheck/AdaptiveButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function AddNew;

  NewTransaction(this.AddNew);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  DateTime pickedDate = DateTime.now();

  void datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((picked) {
      setState(() {
        if (picked == null) {
          return;
        } else {
          pickedDate = picked;
        }
      });
    });
  }

  void onSubmit() {
    String name = nameController.text;
    double amount = double.parse(amountController.text);
    DateTime date = pickedDate;

    setState(() {
      widget.AddNew(name, amount, date);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
//        crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Enter store Name'),
                keyboardType: TextInputType.name,
                controller: nameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Enter Amount'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: amountController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(pickedDate == null
                      ? 'No Date choosen !'
                      : DateFormat.MMMMEEEEd().format(pickedDate)),
                  ElevatedButton(
                    onPressed: () {
                      datePicker();
                    },
                    child: Text('Choose Date'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple, onPrimary: Colors.white),
                  )
                ],
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      color: Colors.pinkAccent,
                      onPressed: () {
                        onSubmit();
                      },
                      child: Text('Save the Expense'),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        onSubmit;
                      },
                      child: Text('Save the Expense'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.purple, onPrimary: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}



// AdaptiveButton('Save',onSubmit);
// AdaptiveButton('Choose Date',datePicker);
