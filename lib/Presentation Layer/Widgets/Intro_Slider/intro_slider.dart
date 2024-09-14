import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/validationCubit.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

class IntroductionSlider extends StatefulWidget {
  const IntroductionSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroductionSlider> createState() => _IntroductionSliderState();
}

class _IntroductionSliderState extends State<IntroductionSlider> {
  List<ContentConfig> slides = [];
  late Function goToTab;
  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    slides.add(const ContentConfig(
      pathImage: 'images/Altrue Logo White.png',
      backgroundImage: 'images/cftp-official-visual-landscape.png',
      backgroundImageFit: BoxFit.cover,
      title: 'Ignite Your Impact',
      description:
          'Ignite Your Impact. Join a global community of changemakers. Amplify your efforts and create positive change.',
      styleDescription: TextStyle(
          color: Colors.amber, fontSize: 23, fontWeight: FontWeight.bold),
      maxLineTitle: 2,
      backgroundColor: Color(0xfff5a623),
      styleTitle: TextStyle(
          height: .8,
          color: Colors.white,
          fontSize: 80,
          fontWeight: FontWeight.bold),
    ));
    slides.add(const ContentConfig(
        pathImage: 'images/tmock-min.png',
        description:
            'Wear Your Cause. Empower others to give with every scan. Make a statement.',
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        title: 'Make a Statement',
        maxLineTitle: 2,
        styleTitle: TextStyle(
            height: .8,
            color: Colors.amber,
            fontSize: 70,
            fontWeight: FontWeight.bold),
        backgroundColor: Colors.black));
    slides.add(const ContentConfig(
        centerWidget: Text('data'),
        backgroundImage: 'images/Social-as-a-tool-for-change-image-2.jpeg',
        backgroundImageFit: BoxFit.cover,
        foregroundImageFit: BoxFit.cover,
        title: 'Connect, Donate, Inspire',
        description:
            'Connect & Donate. Support causes you care about. Inspire a brighter future',
        styleDescription: TextStyle(
            color: Colors.amber, fontSize: 23, fontWeight: FontWeight.bold),
        maxLineTitle: 2,
        styleTitle: TextStyle(
            height: .8,
            color: Colors.white,
            fontSize: 80,
            fontWeight: FontWeight.bold),
        backgroundColor: Colors.black));
    slides.add(const ContentConfig(
        pathImage: 'images/Altrue Logo White.png',
        backgroundImage: 'images/hyatt-volunteers-min.png',
        backgroundImageFit: BoxFit.cover,
        description:
            'Partner for Good. Join forces with companies making a difference.',
        styleDescription: TextStyle(
            color: Colors.amber, fontSize: 23, fontWeight: FontWeight.bold),
        title: 'Partner For Good',
        maxLineTitle: 2,
        styleTitle: TextStyle(
            height: .8,
            color: Colors.white,
            fontSize: 62,
            fontWeight: FontWeight.bold),
        backgroundColor: Colors.black));
    slides.add(
      const ContentConfig(
          title: "Empower Your Impact Today",
          styleTitle: TextStyle(
              height: .8,
              color: Colors.amberAccent,
              fontSize: 70,
              fontWeight: FontWeight.bold),
          description:
              'Start Today. Sign up, earn rewards, and make an impact.',
          styleDescription: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
          backgroundImage: 'images/tmock-min.png',
          backgroundImageFit: BoxFit.cover),
    );
  }

  onDonePress() {
    goToTab(1);
  }

  void onTabChangeCompleted(index) {
    print(index);
  }

  Widget nextBtn() {
    return const Icon(
      Icons.navigate_next,
      color: Colors.white,
      size: 35,
      shadows: [
        Shadow(
          color: Colors.black,
          blurRadius: 10,
        )
      ],
    );
  }

  Widget doneBtn(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.done,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () => context.go('/signUp'));
  }

  Widget skipBtn() {
    return const Icon(
      Icons.skip_next,
      color: Colors.white,
      size: 35,
      shadows: [
        Shadow(
          color: Colors.black,
          blurRadius: 10,
        )
      ],
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
      overlayColor: MaterialStateProperty.all<Color>(Colors.amber),
    );
  }

  List<Widget> renderTabList() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Alignment alignment = Alignment.center;
       if (i == 0) {
      alignment = Alignment.centerRight;
    }


      ContentConfig current = slides[i];
      tabs.add(SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: AssetImage(
                      current.backgroundImage ?? 'images/tmock-min.png'),
                  fit: BoxFit.cover,
                  alignment: alignment)),
          child: ListView(
            children: [
              // GestureDetector(
              //   child: Image.asset(
              //     current.pathImage?? current.backgroundImage!,

              //     fit: BoxFit.cover,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(9, 229, 229, 229)),
                  margin: const EdgeInsets.only(top: 40),
                  child: Text(
                    current.title ?? current.widgetTitle!.toString(),
                    style: current.styleTitle,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  current.description!,
                  style: current.styleDescription,
                  textAlign: TextAlign.start,
                  maxLines: 6,
                ),
              )
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      navigationBarConfig: NavigationBarConfig(
          navPosition: NavPosition.bottom, padding: const EdgeInsets.all(10)),
      indicatorConfig: const IndicatorConfig(
        isShowIndicator: true,
        sizeIndicator: 20,
        indicatorWidget: Icon(
          Icons.circle,
          color: Colors.white,
          size: 12,
        ),
      ),
      renderSkipBtn: skipBtn(),
      skipButtonStyle: myButtonStyle(),
      renderNextBtn: nextBtn(),
      nextButtonStyle: myButtonStyle(),
      renderDoneBtn: doneBtn(context),
      doneButtonStyle: myButtonStyle(),
      listCustomTabs: renderTabList(),
      refFuncGoToTab: (refFunc) {
        goToTab = refFunc;
      },
      onDonePress: () {
        context.read<ValidationCubit>().showSignUp();
        userRepository.introDone();
      },
      scrollPhysics: const BouncingScrollPhysics(),
      onTabChangeCompleted: onTabChangeCompleted,
      curveScroll: Curves.bounceIn,
    );
  }
}
