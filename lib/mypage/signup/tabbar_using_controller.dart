import 'package:flutter/material.dart';
import 'package:mojadel2/mypage/signup/tabs.dart';
import 'package:mojadel2/mypage/signup/transaction_history_dropDown_Button.dart';

import '../../sample/things_sample.dart';

// 마이페이지 거래내역 내 거래형태에 따른 버튼 리스트
const List<String> transactionTypes = ['중고거래', '공동구매'];
const List<String> checkTransaction = ['거래 중', '거래 완료'];

// 카테고리를 나누기 위한 함수 - Stateful
class TabBarUsingController extends StatefulWidget {
  const TabBarUsingController({super.key});

  @override
  State<TabBarUsingController> createState() => _TabBarUsingControllerState();
}

// TabBarButton을 사용하기위해 추가된 with TickerProviderStateMixin
class _TabBarUsingControllerState extends State<TabBarUsingController>
    with TickerProviderStateMixin {
  // TabBarController를 사용하기위한 tabcontroller
  late final TabController tabController;

  // 거래 형태에 따른 문자열 초기화 - 각 리스트의 첫번째 문자열로 초기화
  String dropDownValue = transactionTypes.first;
  String checkDropDownValue = checkTransaction.first;

  @override
  void initState() {
    super.initState();

    // TABS 배열은 tabs.dart에 있음
    // TABS 배열의 길이 만큼 TabController를 지정, refresh되지 않게 vsync는 this
    tabController = TabController(length: TABS.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // 사이즈를 정해주지 않으면 탭뷰의 크기가 무한히 늘어날수 없다는 오류 - SizedBox로 해결
    return SizedBox(
      width: 500.0,
      height: 500.0,
      child: Column(
        children: [
          // TabBar 생성
          TabBar(
            // TabBar 디자인(TabBar 스타일, 글씨 스타일, 액션 스타일, 정렬 등)
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
            // TabBar의 tabController 입력
            controller: tabController,
            // TABS의 배열을 리스트형태로 맵핑하고, 각 탭에 라벨값을 텍스트 형태로 출력
            // 카테고리 이름
            tabs: TABS
                .map(
                  (e) => Tab(
                    child: Text(e.label),
                  ),
                )
                .toList(),
          ),
          // TabBar에 따른 View, 화면 출력
          // TabBarView 사이즈 정의
          SizedBox(
            width: 412.0,
            height: 446.0,
            child: TabBarView(
              // tabController 필수
              controller: tabController,
              // 카테고리 눌렀을 때만 넘어가게 설정
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // 아래로 스크롤 가능하게 설정
                SingleChildScrollView(
                  // 수직 스크롤
                  scrollDirection: Axis.vertical,
                  child: Column(
                    // TabBarView 출력 정렬
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 거래형태 Row로 설정
                      Row(
                        children: [
                          // 중고거래와 공동구매 설정 DropdownButton
                          // TransactionDropDownButton and TransactionCheckDropdownButton은
                          // transaction_history_dropDown_Button.dart에 있음
                          TransactionDropdownButton(
                            // 초기 값 설정 : dropDownValue = transactionTypes.first
                            initialValue: dropDownValue,
                            onChanged: (value) {
                              setState(() {
                                // value > String 값, 눌렀을 때 그 문자열이 들어감
                                dropDownValue = value;
                              });
                            },
                          ),
                          // 거래 중과 거래 완료 설정 DropdownButton
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
                      dropDownValue == '중고거래' && checkDropDownValue == '거래 중'
                          ? const UsedTrading()
                          : dropDownValue == '중고거래' && checkDropDownValue == '거래완료'
                              ? const UsedTraded()
                              : dropDownValue == '공동구매' && checkDropDownValue == '거래 중'
                                  ? const GroupBuying()
                                  : GroupBuied(),
                      // 중고거래 and 거래 중 : True > UsedTrading 함수 호출 / False > 다음 조건문 실행
                      // 중고거래 and 거래 완료 : True > UsedTraded 함수 호출 / False > 다음 조건문 실행
                      // 공동구매 and 거래 중 : True > GroupBuying 함수 호출 / False > GroupBuied 함수 호출
                    ],
                  ),
                ),
                // 나머지 카테고리 (기능 넣어야함)
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

// 중고거래 and 거래 중 화면
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

// 공동구매 and 거래 중 화면
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

// 중고거래 and 거래 완료 화면
class UsedTraded extends StatelessWidget {
  const UsedTraded({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          color: Colors.red,
          child: const Text(
            '중고거래 거래완료!',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Container(
          width: 100.0,
          height: 100.0,
          color: Colors.blue,
          child: const Text(
            '중고거래 거래완료!',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

// 공동구매 and 거래 완료 화면
class GroupBuied extends StatelessWidget {
  const GroupBuied({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          color: Colors.yellow,
          child: const Text(
            '공동구매 거래완료!',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Container(
          width: 100.0,
          height: 100.0,
          color: Colors.green,
          child: const Text(
            '공동구매 거래완료!',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
