import 'package:flutter/material.dart';

/*----------------------------------------------------------------------------*/
const List<String> transactionTypes = ['중고거래', '공동구매'];

class TransactionDropdownButton extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String>? onChanged;

  const TransactionDropdownButton(
      {required this.initialValue, this.onChanged, super.key});

  @override
  State<TransactionDropdownButton> createState() =>
      _TransactionDropdownButtonState();
}

class _TransactionDropdownButtonState extends State<TransactionDropdownButton> {
  late String dropDownValue;

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          DropdownButton(
              borderRadius: BorderRadius.circular(7.0),
              value: dropDownValue,
              elevation: 8,
              style: const TextStyle(
                color: Colors.black,
              ),
              items: transactionTypes
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropDownValue = value!;
                  widget.onChanged?.call(dropDownValue);
                });
              }),
        ],
      ),
    );
  }
}

/*----------------------------------------------------------------------------*/
const List<String> checkTransaction = ['거래 중', '거래 완료'];

class TransactionCheckDropdownButton extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String>? onChanged;

  const TransactionCheckDropdownButton(
      {required this.initialValue, required this.onChanged, super.key});

  @override
  State<TransactionCheckDropdownButton> createState() =>
      _TransactionCheckDropdownButtonState();
}

class _TransactionCheckDropdownButtonState extends State<TransactionCheckDropdownButton> {
  late String checkDropDownValue;

  @override
  void initState() {
    super.initState();
    checkDropDownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton(
              borderRadius: BorderRadius.circular(7.0),
              value: checkDropDownValue,
              elevation: 8,
              style: const TextStyle(
                color: Colors.black,
              ),
              items: checkTransaction
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  checkDropDownValue = value!;
                  widget.onChanged?.call(checkDropDownValue);
                });
              }),
        ],
      ),
    );
  }
}
