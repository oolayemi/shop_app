import 'package:flutter/material.dart';
import 'package:shop_app/views/homepage/homepage_view.dart';
import 'package:shop_app/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../success_screen.dart';
import 'record_sale_viewmodel.dart';

class RecordSaleView extends StatelessWidget {
  const RecordSaleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecordSaleViewModel>.reactive(
      viewModelBuilder: () => RecordSaleViewModel(),
      onModelReady: (model) => model.setUp(context),
      builder: (context, model, child) {
        return CustomScaffoldWidget(
          appBar: const CustomAppBar(
            title: "Record Sale",
          ),
          body: Stack(
            children: [
              ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: model.records.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              model.records.elementAt(index),
                              InkWell(
                                onTap: () {
                                  index == model.records.length - 1
                                      ? model.records.add(const SomethingSha())
                                      : model.records.removeAt(index);

                                  model.notifyListeners();
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Icon(
                                    index == model.records.length - 1
                                        ? Icons.add_circle_outline_outlined
                                        : Icons.remove_circle_outline,
                                    size: 40,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Total Amount", style: TextStyle(fontWeight: FontWeight.w600)),
                            Text("₦0.0", style: TextStyle(fontWeight: FontWeight.w700),)
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Comment",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 130,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black, width: 1)),
                        child: TextFormField(
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter comment",
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SquareButton(
                    title: "Record Sale",
                    onPressed: () {
                      NavigationService().back();
                      NavigationService().navigateToView(
                        SuccessfulScreen(
                          title: "New Sale Recorded\nSuccessfully",
                          buttonTitle: "Go Home",
                          onPressed: () => NavigationService().clearStackAndShowView(const HomepageView()),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
