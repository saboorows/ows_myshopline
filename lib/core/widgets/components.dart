import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AppCodes {
  static BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black26),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  static widgetSelectDialogBox(String initialData, List<String> list, var function,
      var maxHeight, var maxWidth) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Theme(
          data: new ThemeData(
            primaryColor: Colors.redAccent,
            primaryColorDark: Colors.red,
          ),
          child: Container(
            margin: const EdgeInsets.all(1.0),
            padding: const EdgeInsets.only(left: 5.0),
            decoration: AppCodes.myBoxDecoration(),
            height: 60,
            //
            width: maxWidth,
            //          <// --- BoxDecoration here
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: DropdownButton(
                // Initial Value
                menuMaxHeight: maxHeight,
                value: initialData,
                dropdownColor: Colors.white,
                focusColor: Colors.blue,
                isExpanded: true,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                items: list.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: function,
              ),
            ),
          ),
        ));
  }


  static void showToast({
    required String msg,
  }) async =>
      await Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(170, 195, 188, 188),
          textColor: Colors.deepOrange,
          fontSize: 16.0);
}
