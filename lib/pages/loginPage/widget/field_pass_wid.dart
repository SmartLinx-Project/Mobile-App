import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldPassWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final FocusNode? focusNode;

  const FieldPassWidget({super.key, this.controller, this.hintText, this.focusNode});

  @override
  State<FieldPassWidget> createState() => _FieldPassWidgetState();
}

class _FieldPassWidgetState extends State<FieldPassWidget> {
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
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 75.w),
              child: TextField(
                controller: _textController,
                obscureText: _obscureText,
                focusNode: widget.focusNode,
                style: TextStyle(
                  color: Theme.of(context).textTheme.displayMedium?.color,
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: theme.textTheme.displayLarge?.color,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: _hintText,
                  hintStyle: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).textTheme.displayMedium?.color,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
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

