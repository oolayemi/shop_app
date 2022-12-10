import 'package:flutter/material.dart';
import 'package:shop_app/views/dashboard/dashboard_viewmodel.dart';
import 'package:shop_app/views/homepage/homepage_view.dart';
import 'package:stacked/stacked.dart';

import '../../styles/brand_color.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      builder: (context, model, child) {
        List<Widget> buildScreens() {
          return [
            HomepageView(),
            Container(color: Colors.red,),
            Container(color: Colors.green,),
          ];
        }
        return Scaffold(
          body: IndexedStack(
            index: model.selectedIndex,
            children: buildScreens(),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(
                thickness: .2,
                height: .5,
              ),
              BottomNavigationBar(
                backgroundColor: BrandColors.mainBackground,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_outlined),
                    label: 'Account',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    label: 'Profile',
                  ),
                ],
                currentIndex: model.selectedIndex,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                iconSize: 28,
                type: BottomNavigationBarType.fixed,
                onTap: model.onItemTapped,
              ),
            ],
          ),
        );
      }
    );
  }
}
