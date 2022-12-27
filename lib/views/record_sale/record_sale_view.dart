import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/core/utils/tools.dart';
import 'package:shop_app/widgets/utility_widgets.dart';
import 'package:stacked/stacked.dart';

import 'record_sale_viewmodel.dart';

class RecordSaleView extends StatelessWidget {
  const RecordSaleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecordSaleViewModel>.reactive(
      viewModelBuilder: () => RecordSaleViewModel(),
      onModelReady: (model) => model.setup(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .38,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Product",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 5),
                                    InkWell(
                                      onTap: () => buildDropDown(
                                          ctx: context,
                                          check: model.storeProducts,
                                          onSelectProduct: (product) {
                                            model.selectedProduct = product;
                                            model.notifyListeners();
                                          }),
                                      child: Container(
                                        height: 50,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration:
                                            BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1.2)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                model.selectedProduct?.product?.name ?? "Select product",
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const Icon(Icons.keyboard_arrow_down_rounded)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 30),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .33,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Quantity",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      height: 50,
                                      child: TextFormField(
                                        controller: model.quantityController,
                                        decoration: InputDecoration(
                                          hintText: "Enter Quantity",
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4),
                                              borderSide: const BorderSide(color: Colors.black, width: 1.5)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4),
                                              borderSide: const BorderSide(color: Colors.black, width: 1.2)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4),
                                              borderSide: const BorderSide(color: Colors.black, width: 1.2)),
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              if (model.selectedProduct != null && model.quantityController.text.isNotEmpty) {
                                model.addProduct(context);
                              } else {
                                flusher("Please select all field to continue", context, color: Colors.red);
                              }
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: const Icon(
                                Icons.add_circle_outline_outlined,
                                size: 40,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      model.records.isNotEmpty
                          ? SizedBox(
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFCBEBD2), width: 1.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: DataTable(
                                    columnSpacing: MediaQuery.of(context).size.width / 25,
                                    border: TableBorder.all(color: Colors.white),
                                    headingRowColor: MaterialStateProperty.all(const Color(0xFF025D20)),
                                    headingTextStyle: const TextStyle(color: Colors.white),
                                    columns: const <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'Product Name',
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Price',
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Quantity',
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Delete',
                                        ),
                                      ),
                                    ],
                                    rows: model.records.map((e) {
                                      model.inputIndex++;
                                      return DataRow(
                                        color: model.inputIndex.isOdd
                                            ? MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) =>
                                                states.contains(MaterialState.selected)
                                                    ? Theme.of(context).colorScheme.primary.withOpacity(0.08)
                                                    : const Color(0xFFD4E4DA))
                                            : null,
                                        cells: <DataCell>[
                                          DataCell(
                                            Text(
                                              e['product'].name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          DataCell(
                                            Text(formatMoney(e['product'].price.toString())),
                                          ),
                                          DataCell(
                                            Text(
                                              e['quantity'].toString(),
                                            ),
                                          ),
                                          DataCell(
                                            InkWell(
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                'assets/icons/delete.svg',
                                                height: 18,
                                              )),
                                              onTap: () {
                                                model.removeProduct(context, e);
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(color: const Color(0xFFEEEEEE), borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total Amount", style: TextStyle(fontWeight: FontWeight.w600)),
                            Text(
                              formatMoney(model.totalAmount.toString()),
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            )
                          ],
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
                      model.records.isNotEmpty
                          ? model.recordSale(context)
                          : flusher(
                              "Please add at least one sale record",
                              context,
                              color: Colors.red,
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
