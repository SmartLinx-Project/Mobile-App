import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? titoloSuperiore;

  const ChangePasswordField(
      {super.key, this.controller, this.hintText, this.titoloSuperiore});

  @override
  State<ChangePasswordField> createState() => _CambiaPasswordField();
}

class _CambiaPasswordField extends State<ChangePasswordField> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 75.h, top: 75.h),
          child: Text(
            widget.titoloSuperiore ?? '',
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
              color: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.color!
                  .withOpacity(1),
              fontWeight: FontWeight.w500,
              fontSize: 65.sp,
            ),
          ),
        ),

        Container(
          width: double.infinity,
          height: 200.h,
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 50.w),
                  child: TextField(
                    controller: _textController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: _hintText,
                      hintStyle: const TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
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
        ),
      ],
    );
  }
}
