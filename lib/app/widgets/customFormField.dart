import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:metters_check/app/utils/screen_util.dart';

import '../data/constant.dart';


class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.readOnly,
    this.controller,
    this.type, this.lab, this.hint
  }) : super(key: key);
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final bool? readOnly;
  final TextInputType? type;
  final TextEditingController? controller;
  final String? lab, hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SWS.height(45),
      width: Get.width,
      child: TextFormField(
        inputFormatters: inputFormatters,
        validator: validator,
        onChanged: onChanged,
        readOnly: readOnly!,
        keyboardType: type,
        controller: controller,
        style: TextStyle(
          fontSize: SWS.fontSize(13),
          //fontWeight: FontWeight.bold
        ),
        decoration: InputDecoration(
            labelText: lab,
            hintText: hint,
            contentPadding: EdgeInsets.only(top: SWS.height(5), left: SWS.width(15)),
            hintStyle: TextStyle(
                fontSize: SWS.fontSize(13),
                color: Colors.grey.shade400
            ),
            labelStyle: TextStyle(
                fontSize: SWS.fontSize(13),
                color: Colors.black
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: primaryColor
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(7)
            ),
            errorMaxLines: 1,
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red
                ),
              borderRadius: BorderRadius.circular(7)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black
                ),
                borderRadius: BorderRadius.circular(3)
            )
        ),
      ),
    );
  }
}

class CustomAuthField extends StatelessWidget {
  CustomAuthField({
    Key? key,
    required this.hintText,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.controller,
    this.iconData, this.obscurText,
    this.type, this.lab, this.hint,
    this.toogleMethod, this.suffix
  }) : super(key: key);
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? toogleMethod;
  final Function(String?)? onChanged;
  final TextInputType? type;
  final TextEditingController? controller;
  final String? lab, hint;
  final IconData? iconData;
  final bool? suffix, obscurText;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 45,
      width: Get.width,
      child: TextFormField(
        obscureText: obscurText!,
        inputFormatters: inputFormatters,
        validator: validator,
        onChanged: onChanged,
        keyboardType: type,
        controller: controller,
        style: TextStyle(
          fontSize: 13,
          //fontWeight: FontWeight.bold
        ),
        decoration: InputDecoration(
            labelText: lab,
            hintText: hint,
            prefixIcon: Icon(iconData, color: primaryColor,),
            suffixIcon: suffix! ?
            InkWell(
              onTap: toogleMethod,
              child: Icon(
                  obscurText! ?
                  EvaIcons.eyeOutline : EvaIcons.eyeOff2Outline
              ),
            ) : Text(""),
            contentPadding: EdgeInsets.only(top: 5, left: 15),
            hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade400
            ),
            labelStyle: TextStyle(
                fontSize: 13,
                color: Colors.black
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: primaryColor
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(7)
            ),
            errorMaxLines: 1,
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red
                ),
                borderRadius: BorderRadius.circular(7)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black
                ),
                borderRadius: BorderRadius.circular(3)
            )
        ),
      ),
    );
  }
}

// class CustomFormFieldDate extends StatelessWidget {
//   CustomFormFieldDate({
//     Key? key,
//     this.inputFormatters,
//     this.validator,
//     this.maxTime,
//     this.controller,
//     this.type, this.lab, this.hint
//   }) : super(key: key);
//   final List<TextInputFormatter>? inputFormatters;
//   final String? Function(String?)? validator;
//   final TextInputType? type;
//   final TextEditingController? controller;
//   final String? lab, hint;
//   final bool? maxTime;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//      // height: 45,
//       width: Get.width,
//       child: TextFormField(
//         inputFormatters: inputFormatters,
//         validator: validator,
//         keyboardType: type,
//         controller: controller,
//         readOnly: true,
//         onTap: (){
//           DatePicker.showDatePicker(Get.context!,
//               locale: LocaleType.fr,
//               maxTime: maxTime! ? DateTime.now() : null,
//               onConfirm: (_date){
//                 controller!.text =  formatDate(_date);
//               }
//           );
//         },
//         style: TextStyle(
//           fontSize: 13,
//           //fontWeight: FontWeight.bold
//         ),
//         decoration: InputDecoration(
//             labelText: lab,
//             hintText: hint,
//             contentPadding: EdgeInsets.only(top: 5, left: 15),
//             hintStyle: TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey.shade400
//             ),
//             labelStyle: TextStyle(
//                 fontSize: 13,
//                 color: Colors.black
//             ),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                     color: primaryColor
//                 )
//             ),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(7)
//             ),
//             errorMaxLines: 1,
//             errorBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                     color: Colors.red
//                 ),
//               borderRadius: BorderRadius.circular(7)
//             ),
//             border: OutlineInputBorder(
//                 borderSide: BorderSide(
//                     color: Colors.black
//                 ),
//                 borderRadius: BorderRadius.circular(3)
//             )
//         ),
//       ),
//     );
//   }
// }

class CustomDropdownField extends StatelessWidget {
  CustomDropdownField({
    Key? key,
    this.inputFormatters,
    this.validator, this.func,
    this.controller,
    this.type, this.lab, this.hint, this.libKey,
    this.items, this.value, this.valKey
  }) : super(key: key);
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? func;
  final TextInputType? type;
  final TextEditingController? controller;
  final String? lab, hint, libKey, valKey;
  final List? items;
  final Rxn? value;

  @override
  Widget build(BuildContext context) {
    return Container(
     // height: 45,
      width: Get.width,
      child: DropdownButtonFormField2<String?>(
        validator: validator,
        value: value!.value,
        style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade700),
        onChanged: (newVal){
          value!.value = newVal!;
          func != null ? func!() : null;
        },
        items: items!.map(
                (element) => DropdownMenuItem<String?>(
              value: valKey == null ? element : '${element[valKey]}',
              child: Text('${libKey == null ? element : element[libKey]}'.capitalize!),
            )
        ).toList(),
        decoration: InputDecoration(
            labelText: lab,
            contentPadding: EdgeInsets.only(top: 5, left: 15),
            hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade400
            ),
            labelStyle: TextStyle(
                fontSize: 13,
                color: Colors.black
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: primaryColor
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(7)
            ),
          errorMaxLines: 1,
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red
              ),
              borderRadius: BorderRadius.circular(7)
          ),
        ),
        isExpanded: true,

        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 25,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}




extension extString on String? {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this!);
  }

  bool get isValidName{
    final nameRegExp = new RegExp("[a-zA-Z]");
    return nameRegExp.hasMatch(this!);
  }

  bool get isNumeric{
    final nameRegExp = new RegExp("[0-9]");
    return nameRegExp.hasMatch(this!);
  }


  bool get isValidQuantity{
    final nameRegExp = new RegExp("[0-9]");
    return nameRegExp.hasMatch(this!);
  }

  bool get isValidPassword{
    final passwordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this!);
  }

  bool get isNotNull{
    return this != "";
  }

  bool get isNotNull2{
    return this != null;
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^(?:[+0])?[0-9]{10}$");
    return phoneRegExp.hasMatch(this!);
  }

  bool get minLength {
    return this!.length > 2;
  }

  bool get isEmailValid {
    String pattern =
        r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(this!);
  }

}