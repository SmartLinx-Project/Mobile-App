import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function? onSubmitted;
  final FocusNode? focusNode;

  const FieldWidget(
      {super.key,
      this.controller,
      this.hintText,
      this.onSubmitted,
      this.focusNode});

  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
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
      width: double.infinity,
      height: 200.h,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 100.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        focusNode: widget.focusNode,
        controller: _textController,
        onSubmitted: (value) {
          if (widget.hintText == 'Nome') {
            widget.onSubmitted!(1);
          } else if (widget.hintText == 'Cognome') {
            widget.onSubmitted!(2);
          } else if (widget.hintText == 'Email') {
            widget.onSubmitted!(3);
          }
        },
        style: TextStyle(
          color:
              theme.textTheme.displayLarge?.color, // Colore del testo inserito
          fontFamily: theme.textTheme.displayLarge?.fontFamily,
          fontWeight: FontWeight.bold,
        ),
        cursorColor: theme.textTheme.displayMedium?.color,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: _hintText,
          hintStyle: TextStyle(
            fontFamily: theme.textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.normal,
            color: theme.textTheme.displayMedium?.color,
          ),
        ),
      ),
    );
  }
}
