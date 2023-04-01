import 'package:e_commerce_app/apihandler/api_handler.dart';
import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/screens/catelog/catelog_screen.dart';
import 'package:e_commerce_app/utils/alert.dart';
import 'package:e_commerce_app/utils/media_query.dart';
import 'package:e_commerce_app/widget/heading_text.dart';
import 'package:e_commerce_app/widget/para_text.dart';
import 'package:e_commerce_app/widget/subheading_text.dart';

import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late Future<List<CategoryModal>> categoryData;

  @override
  void initState() {
    try {
      categoryData = ApiHandler().fetchCategory();
    } catch (e) {
      CustomAlert(context: context).error(error: e.toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = CustomMediaQuery(context).width;

    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        backgroundColor: MyColors.background,
        elevation: 0,
        title: const HeadingText(text: 'Category'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.black,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(vertical: size * .02),
            height: size * .2,
            decoration: BoxDecoration(
              color: MyColors.btncolor,
              borderRadius: BorderRadius.circular(size * .02),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SubHeadingText(
                    text: "SUMMER SALE",
                    color: Colors.white,
                  ),
                  ParaText(
                    text: "Get Up to 50% off",
                    color: Colors.white,
                  )
                ]),
          ),
          Flexible(
            child: Center(
              // child: const SizedBox(),
              child: FutureBuilder<List<CategoryModal>>(
                future: categoryData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          CategoryModal data = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CatelogScreen(
                                      categoryIndex: data.id.toString(),
                                      categoryName: data.name,
                                    ),
                                  ));
                            },
                            child: Container(
                              width: double.maxFinite,
                              margin:
                                  EdgeInsets.symmetric(vertical: size * .02),
                              height: size * .2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(size * .02),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 2,
                                      spreadRadius: 1,
                                    ),
                                  ]),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: SubHeadingText(
                                          text: data.name.toString(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: size * .21,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight:
                                                Radius.circular(size * .02),
                                            bottomRight:
                                                Radius.circular(size * .02)),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              data.image.toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
