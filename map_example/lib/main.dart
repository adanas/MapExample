import 'package:flutter/material.dart';
import 'package:map_example/google_map_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Map Sample'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  int _selectedIndex = 0;
  late PageController _pageController;

  static final List<Widget> _pageList = [
    //const CustomPage(panelColor: Colors.red, title: "google map"),
    const GoogleMapView(),
    const CustomPage(panelColor: Colors.green, title: "mapbox"),
    const CustomPage(panelColor: Colors.blue, title: "osm"),
    //const SettingView(),
  ];

  final BottomNavigationBarItem _bottomNavigationBarItemHome = const BottomNavigationBarItem(
    icon: Icon(Icons.map),
    label: "google map",
  );

  final BottomNavigationBarItem _bottomNavigationBarItemMap = const BottomNavigationBarItem(
    icon: Icon(Icons.map_outlined),
    label: "mapbox",
  );

  final BottomNavigationBarItem _bottomNavigationBarItemSettings = const BottomNavigationBarItem(
    icon: Icon(Icons.map_rounded),
    label: "osm",
  );

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            _bottomNavigationBarItemHome,
            _bottomNavigationBarItemMap,
            _bottomNavigationBarItemSettings,
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            _selectedIndex = index;
            _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          },
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

@immutable
class CustomPage extends StatelessWidget {

  final Color panelColor;
  final String title;
  
  const CustomPage({required this.panelColor, required this.title, Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: panelColor,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Center(
              child: Text(title),
            ),
          ),
        ),
      ]
    );
  }

}
