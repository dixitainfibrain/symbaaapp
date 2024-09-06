import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:flutter/material.dart';


class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemToString;
  final void Function(T?) onChanged;
  final String? hint;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.itemToString,
    required this.onChanged,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          buttonTheme: ButtonTheme.of(context).copyWith(
            alignedDropdown: false,
          ),
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: DropdownButtonFormField<T>(
        isDense: true,
        isExpanded: false,
        menuMaxHeight: 250,
        alignment: Alignment.bottomRight,
        value: selectedItem,
        onChanged: onChanged,
        dropdownColor: Colors.red,
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: SizedBox(
              // width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemToString(value),
                    style: Fonts.textStyleRegular,
                  ),
                  CommonWidget.getFieldSpacer(height: 10),
                  const Divider(thickness: 1, height: 1)
                  // Divider(color: Colors.black)
                ],
              ),
            ),
          );
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return items.map<Widget>((T value) {
            return Text(
              itemToString(value),
              style: Fonts.textStyleRegular,
            );
          }).toList();
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.appBlackColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.appBlackColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.appBlackColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white, // Background color
        ),
      ),
    );
  }
}
