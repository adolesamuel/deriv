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
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<T>(
        key: widget.key,
        value: widget.activeValue,
        borderRadius: BorderRadius.circular(6.0),
        decoration: InputDecoration(
          isDense: true,
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(6.0),
            borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(6.0),
            borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0,
          ),
          child: Text(
            widget.hintText ?? '',
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        icon: Icon(
          Icons.expand_more,
          color: widget.iconColor ?? Colors.grey,
        ),
        iconSize: 30,
        items: widget.items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: widget.contentBuilder != null
                      ? widget.contentBuilder!(item)
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(item.toString(),
                              style: TextStyle(
                                color: widget.textColor,
                                fontSize: 15.0,
                              )),
                        ),
                ))
            .toList(),
        onChanged: (T? value) {
          widget.onChanged!(value);
        },
      ),
    );
  }
}
