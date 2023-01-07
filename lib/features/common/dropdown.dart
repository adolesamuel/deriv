import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AppDropdown<T> extends StatefulWidget {
  final T? activeValue;
  final List<T> items;
  final String? hintText;
  final Function(T? value)? onChanged;
  final Function(T?)? onSaved;
  final Widget? suffixIcon;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final Color? iconColor;
  final Color? textColor;
  final Widget Function(T)? contentBuilder;
  const AppDropdown({
    super.key,
    required this.items,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.suffixIcon,
    this.borderColor,
    this.iconColor,
    this.textColor,
    this.borderRadius,
    this.contentBuilder,
    this.activeValue,
  });

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      key: widget.key,
      value: widget.activeValue,
      decoration: InputDecoration(
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        suffixIcon: widget.suffixIcon,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(6.0),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(6.0),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
        ),

        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
        fillColor: Colors.white,
        filled: true,
      ),
      isExpanded: true,
      hint: Text(
        widget.hintText ?? '',
        style: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      icon: Icon(
        Icons.expand_more,
        color: widget.iconColor ?? Colors.grey,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      items: widget.items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: widget.contentBuilder != null
                    ? widget.contentBuilder!(item)
                    : Text(item.toString(),
                        style: TextStyle(
                          color: widget.textColor,
                        )),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          // return 'Please select $item';
        }
        return null;
      },
      onChanged: (T? value) {
        widget.onChanged!(value);
      },
      onSaved: (T? value) {
        widget.onSaved!(value);
      },
    );
  }
}
