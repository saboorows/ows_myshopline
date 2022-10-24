import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


class SearchBarProduct extends StatefulWidget {
  const SearchBarProduct({Key? key}) : super(key: key);
  @override
  State<SearchBarProduct> createState() => _SearchBarProductState();
}

class _SearchBarProductState extends State<SearchBarProduct> {
  TextEditingController _controllerSearch = TextEditingController();
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
      _controllerSearch.text = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
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
              controller: _controllerSearch,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.indigoAccent,
                ),
                suffixIcon: InkWell(
                  onTap: () {},
                  child: Container(
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
    );
  }
}
