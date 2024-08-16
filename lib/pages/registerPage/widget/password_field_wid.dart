import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function? onSubmitted;
  final FocusNode? focusNode;

  const PasswordFieldWidget(
      {super.key,
      this.controller,
      this.hintText,
      this.onSubmitted,
      this.focusNode});

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  late TextEditingController _textController;
  late String? _hintText;
  bool _obscureText = true;

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
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 100.w),
              child: TextField(
                controller: _textController,
                obscureText: _obscureText,
                focusNode: widget.focusNode,
                onSubmitted: (value) {
                  if (widget.hintText == 'Password') {
                    widget.onSubmitted!(4);
                  }
                },
                style: TextStyle(
                  color: theme.textTheme.displayMedium?.color,
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: theme.textTheme.displayMedium?.color,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: _hintText,
                  hintStyle: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).textTheme.displayMedium?.color),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Padding(
              padding: EdgeInsets.only(right: 70.w),
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ],
      ),
    );
  }
}
