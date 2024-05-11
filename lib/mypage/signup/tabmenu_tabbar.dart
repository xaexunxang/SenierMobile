import 'package:flutter/material.dart';
import 'package:mojadel2/mypage/signup/tabs.dart';
import 'package:mojadel2/mypage/signup/transaction_history_dropDown_Button.dart';

const List<String> transactionTypes = ['중고거래', '공동구매'];
const List<String> checkTransaction = ['거래 중', '거래 완료'];

class TabMenuTabbar extends StatefulWidget {
  const TabMenuTabbar({super.key});

  @override
  State<TabMenuTabbar> createState() => _TabMenuTabbarState();
}

class _TabMenuTabbarState extends State<TabMenuTabbar> {
  String dropDownValue = transactionTypes.first;
  String checkDropDownValue = checkTransaction.first;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 500,
      child: DefaultTabController(
        length: TABS.length,
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
                    ],
                  ),
                  dropDownValue == '중고거래'
                      ? const UsedTrade()
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
      ),
    );
  }
}



class UsedTrade extends StatelessWidget {
  const UsedTrade({super.key});

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
