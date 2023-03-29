import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../data/constant.dart';
import 'customFormField.dart';

List<Widget> formBuilder(RxMap setData) {

  List formData = formBuilderData;

  List<Widget> fields = <Widget>[];

  int count = 0;

  List selected = [];



  for (Map<String, dynamic> field in formData) {


    if (field['type'].toString().toLowerCase() == "text" ||
        field['type'].toString().toLowerCase() == "number" ||
        field['type'].toString().toLowerCase() == "textarea") {
      fields.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomFormField(
                  //controller: controllers2[field['name']],
                  readOnly: false,
                  lab: field['label'],
                  type: field['type'].toString().toLowerCase() == "number"
                      ? TextInputType.number
                      : TextInputType.text,
                  onChanged: (val){
                    print('val ===> $val');
                    setData[field['name']] = val;
                  },
                  validator: (s){
                    if(field['required'] && !s.isNotNull){
                      return "Ce champs est requis";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          )
        ],
      ));
      count++;
    }


    if (field['type'].toString().toLowerCase() == "date") {
      fields.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomFormFieldDate(
          //   lab: field['label'],
          //   onChanged: (date){
          //     final _date = DateFormat('dd/MM/yyyy').format(date!);
          //     setData[field['name']] = _date;
          //   },
          //   value: edit ? controllers2[field['name']].text : setData[field['name']] != null ? setData[field['name']] : "",
          //   validator: (s){
          //     if(field['required'] && !s.isNotNull) return "Ce champs est requis";
          //     return null;
          //   },
          // ),
          SizedBox(
            height: 15,
          )
        ],
      ));
    }

    if (field['type'].toString().toLowerCase() == "radio-group") {
      //
      //setData[field['name']] = controllers2[field['name']];
      print("set data ================> $setData");
      fields.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                    "${field["label"]}:",
                    style: TextStyle( fontSize: 14, color: Colors.grey.shade700),
                  ),
              ),
              //SizedBox(width: 15,),
              Expanded(
                child: Container(
                    height: 25,
                    width: Get.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: field["values"] == null ? 0 : field["values"].length,
                        itemBuilder: (ctx, i) {
                          final item = field["values"][i];
                          return Row(
                            children: [
                              Text(
                                item["label"],
                                style: TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              InkWell(
                                onTap: () {
                                  // _.selectRadio(i);
                                  // setData[field['name']] = item['value'];
                                  // print(i);
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade100,
                                      border: Border.all(color: Colors.grey)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primaryColor
                                      //color: (controllers2.containsKey(field['name']) && controllers2[field['name']] == item["value"]) ? primaryColor : _.radioSelected.value != i ? Colors.transparent : primaryColor
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              )
                            ],
                          );
                        })
                ),
              )

            ],
          ),
          SizedBox(
            height: 15,
          )
        ],
      ));
    }


    if (field['type'].toString().toLowerCase() == "select") {
      //print(field['values'][0]['value']);
      //List items = field["values"];
      fields.add(Column(
        children: [
          // Row(
          //   children: [
          //     Text(
          //       field["label"],
          //       style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          //     ),
          //     Text(
          //       (field['required'] != null && field["required"]) ? " *" : "",
          //       style: TextStyle(
          //           fontWeight: FontWeight.w700,
          //           fontSize: 13,
          //           color: Colors.red),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 5,
          // ),
          Container(
            // height: 45,
            width: Get.width,
            child: DropdownButtonFormField2<String?>(
              validator: (v){
                return null;
              },
              value: field['values'][0]['value'],
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700),
              onChanged: (newVal){
                setData[field["name"]] = newVal;
              },
              items: field['values'] == null ? [] : field['values'].map<DropdownMenuItem<String>>(
                      (element) => DropdownMenuItem(
                    value: '${element['value']}',
                    child: Text('${element['label']}'.capitalize!),
                  )
              ).toList(),
              decoration: InputDecoration(
                labelText: field['label'].toString().capitalize!,
                contentPadding: EdgeInsets.only(top: 5, left: 15),
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400
                ),
                labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700
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
              // icon: const Icon(
              //   Icons.arrow_drop_down,
              //   color: Colors.black45,
              // ),
              // iconSize: 25,
              // dropdownDecoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(15),
              // ),
            ),
          ),
          // Container(
          //     height: 40,
          //     width: Get.width,
          //     padding: EdgeInsets.symmetric(horizontal: 10),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //         border: Border.all(color: Colors.grey.shade300),
          //         color: Colors.grey.shade100),
          //     child: DropdownButtonFormField2<String?>(
          //       decoration: InputDecoration(
          //           isDense: true,
          //           contentPadding: EdgeInsets.zero,
          //           border: InputBorder.none
          //
          //       ),
          //       isExpanded: true,
          //       hint: Text(
          //         "Select type",
          //         style: TextStyle(fontSize: 12),
          //       ),
          //       //iconSize: 25,
          //       buttonHeight: 40,
          //       dropdownDecoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       //value: field['values'][0]['value'],
          //       value: controllers2[field['name']] == null ? field['values'] == null ? null :
          //       field['values'][0]['value'] : controllers2[field['name']],
          //       items: field['values'] == null ? [] : field['values']
          //           .map<DropdownMenuItem<String>>(
          //               (item) => DropdownMenuItem<String>(
          //             value: item['value'],
          //             child: Text(
          //               item['label'],
          //               style: TextStyle(fontSize: 12),
          //             ),
          //           ))
          //           .toList(),
          //       onChanged: (value) {
          //         setData[field["name"]] = value;
          //       },
          //     )),
          SizedBox(
            height: 15,
          )
        ],
      ));
    }


    if (field['type'].toString().toLowerCase() == "checkbox-group") {

      fields.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${field["label"]}:",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Expanded(
                child: Container(
                    height: 25,
                    width: Get.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: field["values"].length,
                        itemBuilder: (ctx, i) {
                          final item = field["values"][i];
                          return Row(
                            children: [
                              Obx(() => InkWell(
                                onTap: () {


                                  // _.selectCheck(item['value']);
                                  //
                                  // setData[field['name']] = _.checked.value;
                                  // print("set data ==================> $setData");

                                },
                                child: Row(
                                  children: [
                                    Text(
                                      item["label"],
                                      style: TextStyle(fontSize: 14, color: Colors.black54),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 18,
                                      width: 18,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: Colors.grey.shade100,
                                          border: Border.all(color:
                                          Colors.grey.shade300)),
                                      child: Container(),
                                    ),
                                  ],
                                ),
                              )),
                              SizedBox(
                                width: 25,
                              )
                            ],
                          );
                        })
                ),
              ),
              // Text(
              //   (field['required'] != null && field["required"]) ? " *" : "",
              //   style: TextStyle(
              //       fontWeight: FontWeight.w700,
              //       fontSize: 13,
              //       color: Colors.red),
              // ),
            ],
          ),

          SizedBox(
            height: 15,
          )
        ],
      ));
    }
    //count++;
  }

  return fields;
}

// class FieldController extends GetxController {
//
//   RxInt radioSelected = RxInt(-1);
//   RxList checked = [].obs;
//   //RxInt checkBoxSelected = RxInt(-1);
//
//   selectRadio(int index){
//     radioSelected.value = index;
//     update();
//   }
//
//   selectCheck(String val){
//     if(checked.contains(val)){
//       checked.remove(val);
//     } else {
//       checked.add(val);
//     }
//   }
//
//
//
// }
