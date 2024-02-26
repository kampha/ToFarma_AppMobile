import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_farma_app/app/pages/pages.dart';
import 'package:to_farma_app/app/screens/screen.dart';
import 'package:to_farma_app/app/widgets/custom_loading.dart';
import 'package:to_farma_app/core/utlis/custom_colors.dart';

class MenuComponent extends StatefulWidget {
  const MenuComponent({super.key});

  @override
  State<MenuComponent> createState() => MenuHome();
}

class MenuHome extends State<MenuComponent> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const MedicamentsScreen(),
    const BlogScreen(),
    const MessageScreen(),
    const RecipePage(),
    const PharmacovigilancePage()
  ];

  GlobalKey<NavigatorState> _tab1navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> _tab2navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> _tab3navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> _tab4navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> _tab5navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Colors.white,
      tabBar: CupertinoTabBar(
          currentIndex: _selectedIndex,
          backgroundColor: CustomColors.ButtonEnabledAction,
          activeColor: CustomColors.white,
          inactiveColor: CustomColors.black,
          onTap: (index) {
            switch (index) {
              case 0:
                _tab1navigatorKey = GlobalKey<NavigatorState>();
                break;
              case 1:
                _tab2navigatorKey = GlobalKey<NavigatorState>();
                break;
              case 2:
                _tab3navigatorKey = GlobalKey<NavigatorState>();
                break;
              case 3:
                _tab4navigatorKey = GlobalKey<NavigatorState>();
                break;
              case 4:
                _tab5navigatorKey = GlobalKey<NavigatorState>();
                break;
            }

            _selectedIndex = index;
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Medicamentos',
              icon: Icon(Icons.medication),
            ),
            BottomNavigationBarItem(
              label: 'Blog',
              icon: Icon(Icons.book),
            ),
            BottomNavigationBarItem(
              label: 'Mensajería',
              icon: Icon(Icons.message),
            ),
            BottomNavigationBarItem(
              label: 'Receta',
              icon: Icon(Icons.thermostat_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Formulario',
              icon: Icon(Icons.format_align_justify_rounded),
            ),
          ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              navigatorKey: _tab1navigatorKey,
              builder: (context) {
                return _widgetOptions[index];
              },
            );
          case 1:
            return CupertinoTabView(
              navigatorKey: _tab2navigatorKey,
              builder: (context) {
                return _widgetOptions[index];
              },
            );
          case 2:
            return CupertinoTabView(
              navigatorKey: _tab3navigatorKey,
              builder: (context) {
                return _widgetOptions[index];
              },
            );
          case 3:
            return CupertinoTabView(
              navigatorKey: _tab4navigatorKey,
              builder: (context) {
                return _widgetOptions[index];
              },
            );
          case 4:
            return CupertinoTabView(
              navigatorKey: _tab5navigatorKey,
              builder: (context) {
                return _widgetOptions[index];
              },
            );
          default:
            return CupertinoTabView(
              builder: (context) {
                return LoadingProgress();
              },
            );
        }
      },
    );
  }
}

// const MedicamentsScreen(),
//           const BlogScreen(),
//           MessageScreen(),
//           const RecipePage(),
//           Container(
//             color: Colors.amber,
//           ),
