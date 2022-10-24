import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ows_myshopline/core/widgets/avtar_image.dart';
import 'package:ows_myshopline/constant.dart';
import 'package:ows_myshopline/core/constatnts/colors.dart';
import 'package:ows_myshopline/core/widgets/custom_formfield.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ows_myshopline/home_screen.dart';
import 'package:ows_myshopline/core/widgets/term_n_condition.dart';
import 'package:ows_myshopline/pages/splash_page.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _termsChecked = false;
  bool agree = false;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool isHindi = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        centerTitle: true,
        title:   SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          height: 50,
          child: Image.asset("assets/logo1.jpg"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*.01,
            ),
            Center(
              child: Container(
                height: kSpacingUnit.w * MediaQuery.of(context).size.height*.015,
                width: kSpacingUnit.w * MediaQuery.of(context).size.height*.015,
                margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {},
                      child: AvatarImagePD(
                        'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
                        radius: kSpacingUnit.w * 5,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: kSpacingUnit.w * 2.5,
                        width: kSpacingUnit.w * 2.5,
                        child: Center(
                          heightFactor: kSpacingUnit.w * 1.5,
                          widthFactor: kSpacingUnit.w * 1.5,
                          child: Icon(
                            LineAwesomeIcons.camera,
                            color: kDarkPrimaryColor,
                            size: (ScreenUtil()
                                .setSp(kSpacingUnit.w * 1.5)
                                .toDouble()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            SizedBox(
              height: 50,
              child: CustomFormField(
                  controlller: _controllerName,
                  errorMsg: 'Enter Your Name',
                  labelText: 'Name',
                  readOnly: false,
                  icon: Icons.person,
                  textInputType: TextInputType.text),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Colors.redAccent,
                    primaryColorDark: Colors.red,
                  ),
                  child: new TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _controllerPassword,
                    onChanged: (v) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        labelText: 'Email',
                        prefixText: ' ',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        suffix: InkWell(
                          onTap: () {},
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        suffixStyle: const TextStyle(color: Colors.red)),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Colors.redAccent,
                    primaryColorDark: Colors.red,
                  ),
                  child: new TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _controllerPassword,
                    onChanged: (v) {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        labelText: 'Password',
                        prefixText: ' ',
                        prefixIcon: Icon(
                          Icons.lock_open,
                          color: Colors.blue,
                        ),
                        suffixStyle: const TextStyle(color: Colors.green)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Text('Choose Language',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 20,
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 5, bottom: 5, top: 5),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * .2,
                        width: MediaQuery.of(context).size.width * .4,
                        child: Card(
                          elevation: 10,
                          color: isHindi ? Colors.green : Colors.black12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Colors.white),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isHindi = true;
                                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SplashPage()));
                              });
                            },
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Hindi',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    isHindi
                        ? Column(
                          children: [
                            Positioned(
                                top: 0,
                                left: 5,
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Checkbox(
                                    activeColor: Colors.green,
                                    value: isHindi,
                                    onChanged: (value) {
                                      setState(() {
                                        isHindi = value ?? false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                          ],
                        )
                        : Container(), //C
                  ],
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, bottom: 5, top: 5),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * .2,
                        width: MediaQuery.of(context).size.width * .4,
                        child: Card(
                          elevation: 10,
                          color: isHindi ? Colors.black12 : Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Colors.white),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isHindi = false;
                              });
                              // Scaffold.of(context).showSnackBar(
                              //     SnackBar(content: Text("Selected Ite")));
                            },
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'English',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    isHindi
                        ? Container()
                        : Column(
                          children: [
                            Positioned(
                                top: 0,
                                left: 5,
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Checkbox(
                                    activeColor: Colors.green,
                                    value: isHindi ? false : true,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ), //C
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .10,
                  ),
                  Center(
                    child: Checkbox(
                      activeColor: Colors.green,
                      value: agree,
                      onChanged: (value) {
                        setState(() {
                          agree = value ?? false;
                        });
                      },
                    ),
                  ),
                  Expanded(child: TermAndCondition()),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: 45,
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => HomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor,
                        textStyle: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold)),
                    child: Text(
                      "Registration",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
            //   child: Text(
            //     agree ? '' : 'please select',
            //     style: TextStyle(color: Color(0xFFe53935), fontSize: 12),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
