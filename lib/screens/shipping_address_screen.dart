import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/media_query.dart';
import 'package:e_commerce_app/widget/bottom_modal_sheet.dart';
import 'package:e_commerce_app/widget/container.dart';
import 'package:e_commerce_app/widget/heading_text.dart';
import 'package:e_commerce_app/widget/para_text.dart';
import 'package:e_commerce_app/widget/subheading_text.dart';

import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: MyColors.white,
        title: const HeadingText(text: 'Shipping Addesses'),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: MyColors.btncolor,
        onPressed: () {
          modal(context);
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future:
            Provider.of<UserProvider>(context, listen: false).fetchUserDataPf(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<UserProvider>(
              builder: (BuildContext context, userProvider, Widget? child) {
                List<dynamic> data = userProvider.user.address;
                int oldId = 0;
                if (userProvider.user.address.length == 1) {
                  oldId = userProvider.user.address[0]['id'];
                } else {
                  for (var element in userProvider.user.address) {
                    if (element['default'] == true) {
                      oldId = element['id'];
                    }
                  }
                }

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    bool? checkBoxCurrValue = data[index]['default'];
                    bool? checkBoxValue = data[index]['default'];
                    return ShadowContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubHeadingText(text: '${data[index]['name']}'),
                              TextButton(
                                onPressed: () async {
                                  if (data[index]['default'] == true) {
                                    print('You can not delete default address');
                                    return;
                                  }
                                  if (data.length < 2) {
                                    print('You can not delete default address');
                                    return;
                                  }
                                  await userProvider.deleteAddressPf(
                                      uid: data[index]['id']);
                                },
                                child: const SubHeadingText(
                                  text: 'Remove',
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          ParaText(text: '${data[index]['address']}'),
                          const SizedBox(height: 10),
                          ParaText(text: '${data[index]['pin_code']}'),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.black,
                                value: data[index]['default'],
                                onChanged: (val) {
                                  userProvider.updateAddressPf(
                                      newId: data[index]['id'], oldId: oldId);
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const ParaText(text: 'use as defaul address'),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void modal(context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController pinController = TextEditingController();
    return BottomModalSheet(context).showModal(child: Consumer<UserProvider>(
      builder: (BuildContext context, userProvider, Widget? child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: ShadowContainer(
                  color: Colors.grey,
                  width: 40,
                  height: 8,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: "Name",
                    label: SubHeadingText(
                      text: 'Name',
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLines: 3,
                controller: addressController,
                decoration: const InputDecoration(
                    hintText: "Address",
                    label: SubHeadingText(
                      text: 'Address',
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: pinController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Pin Code",
                  label: SubHeadingText(
                    text: 'Pin Code',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.btncolor,
                    fixedSize: Size(CustomMediaQuery(context).width * .8, 40),
                  ),
                  onPressed: () async {
                    try {
                      await userProvider.addAddressPf(address: {
                        'name': nameController.text,
                        'address': addressController.text,
                        'pin_code': int.parse(
                          pinController.text,
                        ),
                        'default': false,
                        'id': randomBetween(1111, 999999)
                      });
                    } on FirebaseException catch (e) {
                      CustomAlert(context: context)
                          .error(error: e.message.toString());
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('SUBMIT'),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
