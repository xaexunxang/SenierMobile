import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mojadel2/mypage/signup/tabs.dart';
import 'package:mojadel2/mypage/signup/transaction_history_dropDown_Button.dart';

import '../../sample/things_sample.dart';

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
      child: Column(
        children: [
          TabBar(
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
          SizedBox(
            width: 412.0,
            height: 446.0,
            child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            TransactionDropdownButton(
                              initialValue: dropDownValue,
                              onChanged: (value) {
                                setState(() {
                                  dropDownValue = value;
                                });
                              },
                            ),
                            TransactionCheckDropdownButton(
                              initialValue: checkDropDownValue,
                              onChanged: (value) {
                                setState(() {
                                  checkDropDownValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      dropDownValue == '중고거래' && checkDropDownValue == '거래 중'
                          ? const UsedTrading()
                          : dropDownValue == '중고거래' && checkDropDownValue == '거래완료'
                              ? const UsedTraded()
                              : dropDownValue == '공동구매' && checkDropDownValue == '거래 중'
                                  ? const GroupBuying()
                                  : GroupBuied(),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('요모조모')],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('체크리스트')],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('관심')],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('가계부')],
                ),
              ],
            ),
          ),
        ],
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
        Container(
          width: 430.0,
          height: 348.0,
          child: ListView.separated(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                height: 140.0,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        width: 150,
                        height: 300,
                        child: Image.asset(
                          items[index]['imagePath']!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: '${items[index]['name']}\n',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${items[index]['location']} ${items[index]['time']}\n',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: '${items[index]['price']}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              // AppColors.mintgreen 대신 Colors.green을 사용했습니다. 필요에 따라 적절한 색상 코드로 수정하세요.
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          ),
        ),
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
        Container(
          width: 100.0,
          height: 100.0,
          color: Colors.deepOrangeAccent,
          child: const Text(
            '공동구매 거래 중!',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Container(
          width: 100.0,
          height: 100.0,
          color: Colors.lightGreenAccent,
          child: const Text(
            '공동구매 거래 중!',
            style: TextStyle(color: Colors.black),
          ),
        ),
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
        Container(width: 100.0, height: 100.0, color: Colors.red,child: const Text('중고거래 거래완료!', style: TextStyle(color: Colors.black),),),
        Container(width: 100.0, height: 100.0, color: Colors.blue, child: const Text('중고거래 거래완료!', style: TextStyle(color: Colors.black),),),
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
        Container(width: 100.0, height: 100.0, color: Colors.yellow,child: const Text('공동구매 거래완료!', style: TextStyle(color: Colors.black),),),
        Container(width: 100.0, height: 100.0, color: Colors.green, child: const Text('공동구매 거래완료!', style: TextStyle(color: Colors.black),),),
      ],
    );
  }
}
