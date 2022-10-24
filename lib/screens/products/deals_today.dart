import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:ows_myshopline/core/constatnts/components.dart';
import 'package:ows_myshopline/jsons/products.dart';
import 'package:ows_myshopline/models/models.dart';
import 'package:ows_myshopline/pages/chat_pages/chat_page.dart';
import 'package:ows_myshopline/providers/providers.dart';
import 'package:ows_myshopline/screens/home/today_deals_card.dart';
import 'package:ows_myshopline/screens/products/view_top_products.dart';
import 'package:ows_myshopline/providers/product_provider.dart';
import 'package:provider/provider.dart';

class DealsToday extends StatefulWidget {
  const DealsToday({Key? key}) : super(key: key);

  @override
  State<DealsToday> createState() => _DealsTodayState();
}

class _DealsTodayState extends State<DealsToday> {
  late ProductProvider productProvider;
  late HomeProvider homeProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productProvider = context.read<ProductProvider>();
    homeProvider = context.read<HomeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  const Text(
                    "Deals Today",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ViewTopProducts(
                                title: "Deals Today",
                              )));
                    },
                    child: const Text(
                      "View All",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                  ),
                ],
              )),
          Container(
            height: 130,
            child: StreamBuilder<QuerySnapshot>(
              stream: productProvider.getProducts(10),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if ((snapshot.data?.docs.length ?? 0) > 0) {
                    var listMessage = snapshot.data!.docs;
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, right: 5.0, left: 5.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        reverse: true,
                        itemBuilder: (context, index) =>
                            buildItem(index, snapshot.data!.docs[index]),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("No Product Found"),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.themeColor,
                    ),
                  );
                }
              },
            ),
          ),
          // Container(
          //     height: 130,
          //     child: ListView.builder(
          //         scrollDirection: Axis.horizontal,
          //         shrinkWrap: true,
          //         physics: ScrollPhysics(),
          //         itemCount: products.length,
          //         itemBuilder: (context, index) {
          //           return InkWell(
          //             child: TodayDealsCard(
          //               image: products[index]['image'],
          //               details: products[index]['detail'],
          //               productName: products[index]['name'],
          //             ),
          //             onTap: () async {
          //               alertDialog(context, products[index]);
          //             },
          //           );
          //         })),
        ],
      ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    return InkWell(
      child: TodayDealsCard(
        image: document['productUrl']??'',
        details: document['productDescription'],
        productName: document['productName'],
      ),
      onTap: () async {
        alertDialog(context, document,true);
      },
    );
  }

  alertDialog(BuildContext context, var products,bool getBestPrice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height * .6,
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                      child: Row(
                        children: [
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.close))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .25,
                      color: Colors.grey.shade200,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .6,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .20,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .5,
                        child: Image.network(products['productUrl']!,fit: BoxFit.contain,),
                      ),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Container(
                          color: Colors.pink,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                '70% off',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Center(
                              child: Text(
                                'Rs 299/-',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    'MRP: ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    'RS-499',
                                    style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Center(
                              child: Text(
                                products['productName']!,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                'Sold By: RCM Mobiles',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    getBestPrice ? Container(
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.primaryColor,
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            if (mounted) {
                              setState(() {
                                getBestPrice = false;
                              });
                            }
                          },
                          child: Text('Get Best Price')),
                    ) : Container(),
                    getBestPrice ? Container() :  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.primaryColor,
                                textStyle: TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.bold)),
                            onPressed: () {},
                            child: Icon(Icons.phone)),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.primaryColor,
                                textStyle: TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.bold)),
                            onPressed: () {},
                            child: Icon(Icons.whatsapp)),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.primaryColor,
                                textStyle: const TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.bold)),
                            onPressed: () async{
                              UserChat? user= await homeProvider.getUserDetails(products['userId']);
                              navigateTo(
                                  context,
                                  ChatPage(
                                    isImageSend: true,
                                    imageUrl: products['productUrl']!,
                                    arguments: ChatPageArguments(
                                      peerId: user!.id,
                                      peerAvatar: user!.photoUrl,
                                      peerNickname: user!.nickname,
                                    ),
                                  ));
                            },
                            child: Icon(Icons.chat_bubble_outline)),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }
}
