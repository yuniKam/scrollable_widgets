import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({Key? key}) : super(key: key);

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ReorderableListViewScreen',
      body: renderBulider(),
    );
  }

  // 1.
  //
  Widget renderDefault() {
    return ReorderableListView(
      children: numbers
          .map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList(),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          // oldIndex와 newIndex 모두 이동되기 전에 산정한다.
          // [red, orange, yellow]
          // [0, 1, 2] - index
          //
          // red 를 yellow 다음으로 옮기고 싶다.
          // red : 0 oldIndex -> 3 newIndex
          // onReorder 가 실행이 되는 패턴은 값을 옮기기 전의 인덱스로 값을 받아옴
          // 실제로 인덱스가 몇번인가는 문제가 되지 않는다.
          // [orange, yellow, red]
          //
          // [red, orange, yellow]
          // yellow 를 red 앞으로 옮기고 싶다.
          // yellow : 2 oldIndex -> o newIndex
          // [yellow, red, orange]

          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
    );
  }

  // 2.
  //
  Widget renderBulider() {
    return ReorderableListView.builder(
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[numbers[index] % rainbowColors.length],
          index: numbers[index],
        );
      },
      itemCount: numbers.length,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      key: Key(index.toString()),
      // height: height == null ? 300 : height,
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
