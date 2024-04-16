import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'BottomSlidePopup.dart';
import 'DimmedBottomSlidePopup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Hello World',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool bottomSheetVisible = false;
  bool dimmedBottomSheetVisible = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Animate"),
      ),
      backgroundColor: CupertinoColors.white,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton.filled(
                  child: const Text("BottomSheet"),
                  onPressed: () {
                    setState(() {
                      bottomSheetVisible = !bottomSheetVisible;
                    });
                  },
                ),
                CupertinoButton.filled(
                  child: const Text("Dimmed BottomSheet"),
                  onPressed: () {
                    setState(() {
                      dimmedBottomSheetVisible = !dimmedBottomSheetVisible;
                    });
                  },
                ),
              ],
            ),
          ),
          BottomSlidePopup(
            visible: bottomSheetVisible,
            duration: const Duration(milliseconds: 300),
            child: const Image(
              height: 400,
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://i.namu.wiki/i/yG6wJoPBUVKER411ZCxvew-lTwXe_3FyEFK1ndAKnvDgRjK_yC-h7USkOBX3Jdsv21zg39bam7ixkW81KGZTYg.webp",
              ),
            ),
          ),
          DimmedBottomSlidePopup(
            visible: dimmedBottomSheetVisible,
            duration: const Duration(milliseconds: 300),
            onCancel: () => setState(() => dimmedBottomSheetVisible = false),
            child: const Image(
              height: 500,
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://i.namu.wiki/i/yG6wJoPBUVKER411ZCxvew-lTwXe_3FyEFK1ndAKnvDgRjK_yC-h7USkOBX3Jdsv21zg39bam7ixkW81KGZTYg.webp",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
