import 'package:flutter/widgets.dart';

class HomePageS extends StatefulWidget {
  const HomePageS({Key? key}) : super(key: key);

  @override
  _HomePageSState createState() => _HomePageSState();
}

class _HomePageSState extends State<HomePageS> {
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
