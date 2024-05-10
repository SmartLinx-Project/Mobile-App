import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditNameField extends StatefulWidget {

  final TextEditingController? controller;
  final String? hintText;

  const EditNameField({super.key, this.controller, this.hintText});

  @override
  State<EditNameField> createState() => _CambiaNomeField();
}

class _CambiaNomeField extends State<EditNameField> {
  TextEditingController _textController = TextEditingController();
  String? _hintText;

  @override
  void initState() {
    super.initState();
    _textController = widget.controller ?? TextEditingController();
    _hintText = widget.hintText;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 200.h,
      padding: EdgeInsets.only(left: 100.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _textController,
        style: TextStyle(
          color: theme.textTheme.displayLarge?.color,
          fontFamily: theme.textTheme.displayLarge?.fontFamily,
          fontWeight: FontWeight.bold,
        ),
        cursorColor: theme.textTheme.displayLarge?.color,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: _hintText,
          hintStyle: TextStyle(
            fontFamily: theme.textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.w500,
            color: theme.textTheme.displayMedium?.color!.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}

