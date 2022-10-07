import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ListViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListViewScreen',
      body: renderSeparated(),
    );
  }

  // 1.
  // 0~99번 리스트를 모두 한번에 그려줌
  Widget renderDefault() {
    return ListView(
      children: numbers
          .map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList(),
    );
  }

  // 2.
  // 0~3번 리스트를 그림.
  // 화면에 보이는것 보다 조금더 그려서 스크롤이 자연스럽게 보일수 있도록 함.
  // 화면에 보이지 않는 위젯들은 메모리에서 지워 효율적인 메모리 사용이 가능하도록 함.
  Widget renderBuilder() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  // 3.
  // ListView.builder + 중간 중간에 추가할 위젯을 넣을 수 있음.
  Widget renderSeparated() {
    return ListView.separated(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      // separatorBuilder: (context, index) {
      //   //하나하나씩
      //   return renderContainer(
      //     color: Colors.black,
      //     index: index,
      //     height: 100,
      //   );
      // },
      separatorBuilder: (context, index) {
        index += 1;
        // 5개의 item마다 배너 보여주기
        if(index % 5 == 0){
          return renderContainer(
            color: Colors.black,
            index: index,
            height: 100,
          );
        }
        return Container();
        // return SizedBox(height: 32,);
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
