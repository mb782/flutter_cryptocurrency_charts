import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:clean_app/presentation/page/login_screen.dart';
import 'package:clean_app/presentation/page/portfolio/portfolio_page.dart';
import 'package:clean_app/presentation/page/profile/profile_page.dart';
import 'package:clean_app/presentation/page/ratings/detail_info_page.dart';
import 'package:clean_app/presentation/page/ratings/ratings_page.dart';
import 'package:clean_app/screens/login_screen/login_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute<dynamic>>[
    AutoRoute<dynamic>(
      path: 'presentation/loginpage',
      name: 'LoginPage',
      initial: true,
      page: LoginScreen,
      children: <AutoRoute<dynamic>>[
        AutoRoute<dynamic>(
          path: 'presentation/navigation_page',
          name: 'NavigationPageRouter',
          initial: true,
          page: LoginPage,
          children: <AutoRoute<dynamic>>[
            AutoRoute<dynamic>(
              path: 'presentation/page/ratings/ratings_page',
              name: 'RatingsPageRouter',
              page: EmptyRouterPage,
              children: <AutoRoute<dynamic>>[
                AutoRoute<dynamic>(
                  path: '',
                  page: RatingsPage,
                ),
                AutoRoute<dynamic>(
                  path: '',
                  page: DetailInfoPage,
                ),
              ],
            ),
            AutoRoute<dynamic>(
              path: 'presentation/page/portfolio/portfolio_page',
              name: 'PortfolioPageRouter',
              page: EmptyRouterPage,
              children: <AutoRoute<dynamic>>[
                AutoRoute<dynamic>(
                  path: '',
                  page: PortfolioPage,
                ),
                AutoRoute<dynamic>(
                  path: '',
                  page: DetailInfoPage,
                ),
              ],
            ),
            AutoRoute<dynamic>(
              path: 'presentation/page/profile/profile_page',
              name: 'ProfilePageRouter',
              page: ProfilePage,
            ),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
