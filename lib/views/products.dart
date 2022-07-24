import 'package:elbrit_central/components/search_bar.dart';
import 'package:elbrit_central/controllers/app_bar.dart';
import 'package:elbrit_central/controllers/product_tile.dart';
import 'package:elbrit_central/models/product_info.dart';
import 'package:elbrit_central/services/api.dart';
import 'package:elbrit_central/views/product_details.dart';

import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductModel> productModels = [];

  @override
  void initState() {
    super.initState();
    getProductInfo();
  }

  Future<void> getProductInfo() async {
    productModels = await Api().getProducts();
    print('productModels: ${productModels.length}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 3,
          flexibleSpace: SafeArea(
            child: Container(
              child: const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: NewAppBar(),
              ),
            ),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffE9EEF3), width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffE9EEF3),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: IconButton(
                      icon: const Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.search)),
                      onPressed: () {
                        showSearch(
                            context: context, delegate: CustomSearchDelegate());
                      },
                    ),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productModels.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: ProductTile(
                          picture:
                              "https://elbrit.devcorn.live/uploads/carton/${productModels[index].cartonImage!}",
                          title: productModels[index].productName!,
                          brandPromo: productModels[index].others!,
                          medicineName: productModels[index].labelClaim!,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (
                                context,
                              ) =>
                                  ProductDetails(
                                // id: productModels[index].id.toString(),
                                productModel: productModels[index],
                                // productModels: productModels[index],
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
