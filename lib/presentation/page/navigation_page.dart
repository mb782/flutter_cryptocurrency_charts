import 'package:auto_route/auto_route.dart';
import 'package:clean_app/backbone/dependency_injection.dart' as di;
import 'package:clean_app/presentation/bloc/settings/bloc.dart';
import 'package:clean_app/presentation/router/app_router.gr.dart';
import 'package:clean_app/screens/login_screen/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final SettingsBloc settingsBloc = di.sl.get();
  @override
  void initState() {
    super.initState();
    settingsBloc.add(const SettingsEvent.getFiatCurrency());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AutoTabsScaffold(
        backgroundColor: Theme.of(context).primaryColor,
        routes: const <PageRouteInfo<dynamic>>[
          RatingsPageRouter(),
          PortfolioPageRouter(),
          ProfilePageRouter(),
        ],
        bottomNavigationBuilder: (_, TabsRouter tabsRouter) {
          return Padding(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              bottom: 12.h,
              top: 4.h,
            ),
            child: SalomonBottomBar(
              onTap: tabsRouter.setActiveIndex,
              selectedItemColor: Theme.of(context).focusColor,
              // ignore: always_specify_types
              items: [
                SalomonBottomBarItem(
                  activeIcon: Icon(
                    Icons.bar_chart,
                    color: Theme.of(context).focusColor,
                  ),
                  icon: Icon(
                    Icons.bar_chart,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text(
                    'ratings',
                  ),
                ),
                SalomonBottomBarItem(
                  activeIcon: Icon(
                    Icons.pie_chart,
                    color: Theme.of(context).focusColor,
                  ),
                  icon: Icon(
                    Icons.pie_chart,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text(
                    'market',
                  ),
                ),
                SalomonBottomBarItem(
                  activeIcon: Icon(
                    Icons.manage_accounts,
                    color: Theme.of(context).focusColor,
                  ),
                  icon: Icon(
                    Icons.manage_accounts,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text(
                    'settings',
                  ),
                ),
              ],
              currentIndex: tabsRouter.activeIndex,
            ),
          );
        },
      ),
    );
  }
}
