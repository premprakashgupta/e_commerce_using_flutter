import 'package:e_commerce_app/apihandler/api_handler.dart';
import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/screens/catelog/fiter_screen.dart';
import 'package:e_commerce_app/screens/product_screen.dart';
import 'package:e_commerce_app/utils/alert.dart';
import 'package:e_commerce_app/utils/media_query.dart';
import 'package:e_commerce_app/widget/bottom_modal_sheet.dart';
import 'package:e_commerce_app/widget/heading_text.dart';
import 'package:e_commerce_app/widget/para_text.dart';
import 'package:e_commerce_app/widget/subheading_text.dart';
import 'package:flutter/material.dart';

class CatelogScreen extends StatefulWidget {
  final String categoryIndex;
  final String categoryName;
  const CatelogScreen(
      {super.key, required this.categoryIndex, required this.categoryName});

  @override
  State<CatelogScreen> createState() => _CatelogScreenState();
}

class _CatelogScreenState extends State<CatelogScreen> {
  late Future<List<CatelogModel>> categoryWiseData;

  @override
  void initState() {
    try {
      categoryWiseData =
          ApiHandler().fetchCategoryWise(categoryIndex: widget.categoryIndex);
    } catch (e) {
      CustomAlert(context: context).error(error: e.toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> sortList = [
      "Newest First",
      "Oldest First",
      "High to Low Price",
      "Low to High Price"
    ];
    double size = CustomMediaQuery(context).width;
    print(size * .02);

    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        backgroundColor: MyColors.background,
        iconTheme: IconThemeData(
          color: Colors.black, // set the desired color here
        ),
        elevation: 0,
        title: HeadingText(
          text: widget.categoryName,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.black,
          ),
        ],
      ),
      body: FutureBuilder<List<CatelogModel>>(
          future: categoryWiseData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.all(size * .02),
                child: Column(
                  children: [
                    SizedBox(
                      height: size * .06,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              10,
                              (index) => Container(
                                    width: size * .2,
                                    margin: const EdgeInsets.only(right: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.black),
                                    child: ParaText(
                                      text: "T-Shirt",
                                      fontweight: FontWeight.normal,
                                      size: size * .02,
                                      color: Colors.white,
                                    ),
                                  )),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FilterScreen(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(Icons.sort),
                                const SizedBox(width: 5),
                                Text("Filter"),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const RotatedBox(
                                quarterTurns: -1,
                                child: Icon(Icons.compare_arrows_outlined),
                              ),
                              const SizedBox(width: 5),
                              InkWell(
                                  onTap: () {
                                    BottomModalSheet(context).showModal(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(
                                          sortList.length,
                                          (index) => ListTile(
                                            shape: const Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.black12)),
                                            title: ParaText(
                                              text: sortList[index],
                                              size: size * .022,
                                              fontweight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text("Price (Lowest to Highest)")),
                            ],
                          ),
                          const Icon(Icons.apps),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          CatelogModel data = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) => ProductScreen(
                                          productId: data.id.toString())));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: size * .26,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: NetworkImage(data.images[0]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: ParaText(
                                            text: '20% OFF',
                                            color: Colors.white,
                                            fontweight: FontWeight.normal,
                                            size: size * .02,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                blurRadius: 2,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            iconSize: 22,
                                            icon: const Icon(
                                              Icons.favorite_border,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size * .01),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: size * .03,
                                          ),
                                          SizedBox(width: 4),
                                          ParaText(
                                            text: '4.5',
                                            fontweight: FontWeight.normal,
                                            size: size * .02,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: size * .005),
                                      ParaText(
                                        text: 'Drothy Perkins',
                                        color: Colors.black26,
                                        fontweight: FontWeight.normal,
                                        size: size * .021,
                                      ),
                                      SizedBox(height: size * .005),
                                      ParaText(
                                        text: data.title.toString(),
                                        fontweight: FontWeight.bold,
                                        maxLine: 2,
                                      ),
                                      ParaText(
                                        text: '₹ ${data.price.toString()}',
                                        fontweight: FontWeight.w500,
                                        size: size * .03,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: SubHeadingText(text: snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
