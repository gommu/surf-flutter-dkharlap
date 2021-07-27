import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screen/res/assets_uri.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  Widget _buildIndicator() {
    List<Widget> children = List.generate(3, (index) {
      return Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: Container(
          height: 8,
          width: index == _currentIndex ? 24 : 8,
          decoration: BoxDecoration(
              color: index == _currentIndex ? Colors.green : Color(0xff7C7E92),
              borderRadius: BorderRadius.circular(4)),
        ),
      );
    });

    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 88),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center, children: children),
        ),
      ),
    );
  }

  Widget _buildCommonFrames(
    BuildContext context,
    String iconUrl,
    String header,
    String description,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: Text(
                    'Пропустить',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.green,
                        ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/sight-list');
                  },
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 58, right: 58, top: 173),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconUrl,
                    height: 104.0,
                    width: 104.0,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    header,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastFrame(
    BuildContext context,
    String iconUrl,
    String header,
    String description,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: Container(),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/sight-list');
                  },
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 58, right: 58, top: 173),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconUrl,
                    height: 104.0,
                    width: 104.0,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    header,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/sight-list');
                        },
                        child: Text('НА СТАРТ'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ))),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            _buildCommonFrames(
              context,
              iconOnboarding1,
              'Добро пожаловать в Путеводитель',
              'Ищи новые локации и сохраняй самые любимые',
            ),
            _buildCommonFrames(
              context,
              iconOnboarding2,
              'Построй маршрут и отправляйся в путь',
              'Достигай цели максимально быстро и комфортно',
            ),
            _buildLastFrame(
              context,
              iconOnboarding3,
              'Добавляй места которые нашел сам',
              'Делись самыми интересными и помоги нам стать лучше!',
            ),
          ],
        ),
        _buildIndicator(),
      ],
    );
  }
}
