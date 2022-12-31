import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/core/utils/tools.dart';
import 'package:shop_app/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/check_out_stock_details.dart';
import 'check_out_form_viewmodel.dart';

class CheckOutFormView extends StatelessWidget {
  const CheckOutFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckOutFormViewModel>.reactive(
      viewModelBuilder: () => CheckOutFormViewModel(),
      onModelReady: (model) async => await model.setUp(context),
      builder: (context, model, child) {
        return CustomScaffoldWidget(
          appBar: const CustomAppBar(title: "Check Out"),
          body: Stack(
            children: [
              ListView(
                children: [
                  Form(
                    key: model.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Row(
                        //       crossAxisAlignment: CrossAxisAlignment.end,
                        //       children: [
                        //         SizedBox(
                        //           width: MediaQuery.of(context).size.width * .38,
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               const Text(
                        //                 "Product",
                        //                 style: TextStyle(fontSize: 16),
                        //               ),
                        //               const SizedBox(height: 5),
                        //               InkWell(
                        //                 onTap: () => buildDropDown(
                        //                     ctx: context,
                        //                     check: model.storeProducts,
                        //                     onSelectProduct: (storeProductData) {
                        //                       model.selectedProduct = storeProductData;
                        //                       model.notifyListeners();
                        //                     }),
                        //                 child: Container(
                        //                   height: 50,
                        //                   padding: const EdgeInsets.symmetric(horizontal: 10),
                        //                   decoration:
                        //                       BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1.2)),
                        //                   child: Row(
                        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                     children: [
                        //                       Expanded(
                        //                         child: Text(
                        //                           model.selectedProduct?.product?.name ?? "Select product",
                        //                           overflow: TextOverflow.ellipsis,
                        //                         ),
                        //                       ),
                        //                       const Icon(Icons.keyboard_arrow_down_rounded)
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         const SizedBox(width: 30),
                        //         SizedBox(
                        //           width: MediaQuery.of(context).size.width * .33,
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               const Text(
                        //                 "Quantity",
                        //                 style: TextStyle(fontSize: 16),
                        //               ),
                        //               const SizedBox(height: 5),
                        //               SizedBox(
                        //                 height: 50,
                        //                 child: TextFormField(
                        //                   controller: model.quantityController,
                        //                   decoration: InputDecoration(
                        //                     hintText: "Enter Quantity",
                        //                     contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        //                     border: OutlineInputBorder(
                        //                         borderRadius: BorderRadius.circular(4),
                        //                         borderSide: const BorderSide(color: Colors.black, width: 1.5)),
                        //                     focusedBorder: OutlineInputBorder(
                        //                         borderRadius: BorderRadius.circular(4),
                        //                         borderSide: const BorderSide(color: Colors.black, width: 1.2)),
                        //                     enabledBorder: OutlineInputBorder(
                        //                         borderRadius: BorderRadius.circular(4),
                        //                         borderSide: const BorderSide(color: Colors.black, width: 1.2)),
                        //                   ),
                        //                   keyboardType: TextInputType.number,
                        //                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         if (model.selectedProduct != null && model.quantityController.text.isNotEmpty) {
                        //           model.addProduct(context);
                        //         } else {
                        //           flusher("Please select all field to continue", context, color: Colors.red);
                        //         }
                        //       },
                        //       child: Container(
                        //         alignment: Alignment.bottomCenter,
                        //         child: const Icon(
                        //           Icons.add_circle_outline_outlined,
                        //           size: 40,
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // const SizedBox(height: 20),
                        ListView.separated(
                          itemCount: model.checkOutDetails.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            CheckOutDetails detail = model.checkOutDetails.elementAt(index);
                            return Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Name:",
                                      ),
                                      Text(
                                        detail.product!.name!,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Unit Price:",
                                      ),
                                      Text(formatMoney(detail.product?.price.toString())),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Check In Qty:",
                                      ),
                                      Text(detail.checkInQuantity.toString()),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "New Stock Qty:",
                                      ),
                                      Text(detail.newStockQuantity.toString()),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Quantity Sold:",
                                      ),
                                      Text(detail.soldQuantity.toString()),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Expected Qty Remaining",
                                      ),
                                      Text((detail.checkInQuantity! - detail.soldQuantity!).toString()),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Enter Actual Qty Remaining",
                                      ),
                                      SizedBox(
                                        width: 95,
                                        // height: 20,
                                        child: TextFormField(
                                          validator: (val) => val!.isEmpty ? "Can't be empty" : null,
                                          textAlign: TextAlign.end,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          onChanged: (value) {
                                            model.setQuantity(detail, int.parse(value.isNotEmpty ? value : '0'), index);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            thickness: 2,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                            controller: model.commentController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter comment",
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
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
                    title: "Check Out",
                    onPressed: () {
                      if (model.formKey.currentState!.validate()) {
                        model.checkOut(context);
                      }
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
