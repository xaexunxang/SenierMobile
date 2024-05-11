import 'package:flutter/material.dart';
import 'package:mojadel2/mypage/signup/tabs.dart';
import 'package:mojadel2/mypage/signup/transaction_history_dropDown_Button.dart';

const List<String> transactionTypes = ['중고거래', '공동구매'];
const List<String> checkTransaction = ['거래 중', '거래 완료'];

class TabBarUsingController extends StatefulWidget {
  const TabBarUsingController({super.key});

  @override
  State<TabBarUsingController> createState() => _TabBarUsingControllerState();
}

class _TabBarUsingControllerState extends State<TabBarUsingController>
    with TickerProviderStateMixin {
  late final TabController tabController;
  String dropDownValue = transactionTypes.first;
  String checkDropDownValue = checkTransaction.first;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: TABS.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500.0,
      height: 500.0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
            overlayColor: const MaterialStatePropertyAll(Colors.white),
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            controller: tabController,
            tabs: TABS
                .map(
                  (e) => Tab(
                    child: Text(e.label),
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                Row(
                  children: [
                    TransactionDropdownButton(
                      initialValue: dropDownValue,
                      onChanged: (value) {
                        setState(() {
                          dropDownValue = value;
                        });
                      },
                    ),
                    // TransactionCheckDropdownButton(
                    //   initialValue: checkDropDownValue,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       checkDropDownValue = value;
                    //     });
                    //   },
                    // )
                  ],
                ),
                dropDownValue == '중고거래'
                    ? const UsedTrading()
                    : const GroupBuying(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('아효2')],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('아효3')],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('아효4')],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('아효5')],
            ),
          ],
        ),
      ),
    );
  }
}

class UsedTrading extends StatelessWidget {
  const UsedTrading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(width: 100.0, height: 100.0, color: Colors.deepPurpleAccent),
        Container(width: 100.0, height: 100.0, color: Colors.lightBlueAccent),
      ],
    );
  }
}

class GroupBuying extends StatelessWidget {
  const GroupBuying({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: 100.0, height: 100.0, color: Colors.deepOrangeAccent),
        Container(width: 100.0, height: 100.0, color: Colors.lightGreenAccent)
      ],
    );
  }
}

class UsedTraded extends StatelessWidget {
  const UsedTraded({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(width: 100.0, height: 100.0, color: Colors.red),
        Container(width: 100.0, height: 100.0, color: Colors.blue),
      ],
    );
  }
}

class GroupBuied extends StatelessWidget {
  const GroupBuied({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: 100.0, height: 100.0, color: Colors.yellow),
        Container(width: 100.0, height: 100.0, color: Colors.green),
      ],
    );
  }
}
