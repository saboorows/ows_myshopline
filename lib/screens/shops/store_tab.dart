import 'package:flutter/material.dart';
import 'package:ows_myshopline/jsons/products.dart';
import 'package:ows_myshopline/jsons/stores.dart';
import 'package:ows_myshopline/screens/home/store_shop_by_categ_card.dart';
import 'package:ows_myshopline/screens/home/today_deals_card.dart';
import 'package:ows_myshopline/screens/home/top_rated_shop_card.dart';
import 'package:ows_myshopline/screens/shops/view_toprated_shops.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class StoreTab extends StatefulWidget {
  const StoreTab({Key? key,required this.controller}) : super(key: key);
final controller;
  @override
  State<StoreTab> createState() => _StoreTabState();
}

class _StoreTabState extends State<StoreTab> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      widget.controller.text=result.recognizedWords;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0,top:8,bottom: 8),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .85,
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                margin: EdgeInsets.only(left: 5, right: 2),
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  controller: widget.controller,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.indigoAccent,
                    ),
                    suffixIcon:  InkWell(
                      onTap: () {},
                      child:  Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Image(
                          image: AssetImage(
                            'assets/google_lens.png',
                          ),
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ),
                    hintText: 'Search Product',
                    hintStyle: TextStyle(color: Colors.black12),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: _speechToText.isNotListening
                    ? _startListening
                    : _stopListening,
                child: Container(
                  width: MediaQuery.of(context).size.width * .1,
                  child: Icon(
                      _speechToText.isNotListening ? Icons.mic_off : Icons.mic),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 90,
            child: Image.asset('assets/banner3.JPG',
                height: 80,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    "Top Rated Shop",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ViewTopRatedShop(title: "Top Rated Shop",)));
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.red),
                    ),
                  ),
                ],
              )),
        ),
        Container(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: stores.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: TodayRatedShopCard(
                      image: stores[index]['image'],
                      details: stores[index]['detail'],
                      productName: stores[index]['name'],
                    ),
                    onTap: () async {},
                  );
                })),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    "Shop By Category",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ViewTopRatedShop(title: "Shop By Category",)));
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.red),
                    ),
                  ),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Container(
            height: 300,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(6, (index) {
                  return Container(
                    child: TodayRatedShopCard2(
                      image: stores[index+1]['image'],
                      details: stores[index+1]['detail'],
                      productName: stores[index+1]['name'],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Recently Viewed",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )),
        ),
        Container(
            height: 130,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: stores.length-1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: TodayDealsCard(
                      image: stores[index+1]['image'],
                      details: stores[index]['detail'],
                      productName: stores[index]['name'],
                    ),
                    onTap: () async {},
                  );
                })),
      ],
    );
  }
}
