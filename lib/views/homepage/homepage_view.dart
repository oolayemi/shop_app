import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/views/check_out_form/check_out_form_view.dart';
import 'package:shop_app/views/homepage/homepage_viewmodel.dart';
import 'package:shop_app/views/new_stock/new_stock_view.dart';
import 'package:shop_app/views/record_sale/record_sale_view.dart';
import 'package:shop_app/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../styles/brand_color.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomepageViewModel>.reactive(
      viewModelBuilder: () => HomepageViewModel(),
      builder: (context, model, child) {
        return CustomScaffoldWidget(
          padding: 0,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/drinks.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    color: const Color(0xFF102002).withOpacity(.6),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage: AssetImage("assets/images/user.png"),
                                    ),
                                    const SizedBox(width: 6),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Welcome back,',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          'Anjolaoluwa',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const SizedBox()
                                  // const Icon(
                                  //   Icons.notifications_none_rounded,
                                  //   color: Colors.white,
                                  // ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => NavigationService().navigateToView(const CheckOutFormView()),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * .42,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: AssetImage('assets/images/card_bg.png'),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/checkout.svg"),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Check out',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => NavigationService().navigateToView(const NewStockView()),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * .42,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: AssetImage('assets/images/card_bg.png'),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/images/bag.svg"),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Input New Stock',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height - 350,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: InkWell(
                    onTap: () => model.toggleProduct(),
                    child: model.toggleProducts
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/images/worried.svg"),
                                const SizedBox(height: 20),
                                const Text(
                                  "You have not recorded\nany stock for today.",
                                  style: TextStyle(fontSize: 16, color: Color(0xFF102002)),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    NavigationService().navigateToView(const RecordSaleView());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: BrandColors.primary,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                                  ),
                                  child: const Text(
                                    "Record Sale",
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Today’s Stock",
                                        style: TextStyle(color: Color(0xFF102002), fontSize: 16),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          NavigationService().navigateToView(const RecordSaleView());
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: BrandColors.primary,
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                                        ),
                                        child: const Text(
                                          "Record Sale",
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  const ListTile(
                                    title: Text("Bottles of Pepsi - 5packs"),
                                    trailing: Text("₦2,000", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                    subtitle: Text("5/11/22"),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                                  ),
                                  const Divider(thickness: 1),
                                  const ListTile(
                                    title: Text("Bottles of Pepsi - 5packs"),
                                    trailing: Text("₦2,000", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                    subtitle: Text("5/11/22"),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                                  ),
                                  const Divider(thickness: 1),
                                  const ListTile(
                                    title: Text("Bottles of Pepsi - 5packs"),
                                    trailing: Text("₦2,000", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                    subtitle: Text("5/11/22"),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                                  ),
                                  const Divider(thickness: 1),
                                  const ListTile(
                                    title: Text("Bottles of Pepsi - 5packs"),
                                    trailing: Text("₦2,000", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                    subtitle: Text("5/11/22"),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                                  ),
                                  const Divider(thickness: 1),
                                  const ListTile(
                                    title: Text("Bottles of Pepsi - 5packs"),
                                    trailing: Text("₦2,000", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                    subtitle: Text("5/11/22"),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                                  ),
                                  const Divider(thickness: 1),
                                  const ListTile(
                                    title: Text("Bottles of Pepsi - 5packs"),
                                    trailing: Text("₦2,000", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                    subtitle: Text("5/11/22"),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                                  ),
                                  const Divider(thickness: 1),
                                  const ListTile(
                                    title: Text("Bottles of Pepsi - 5packs"),
                                    trailing: Text("₦2,000", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                    subtitle: Text("5/11/22"),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
