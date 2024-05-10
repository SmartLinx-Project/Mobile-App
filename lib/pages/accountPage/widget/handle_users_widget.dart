import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/changeName/change_name.dart';
import 'package:smartlinx/pages/changePassword/change_password.dart';

class HandleUserButton extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;

  const HandleUserButton({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
  }) : super(key: key);

  @override
  _HandleUserButtonState createState() => _HandleUserButtonState();
}

class _HandleUserButtonState extends State<HandleUserButton> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 120.w, right: 120.w),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ChangeAccountName(),
                ),
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.account_circle,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(width: 70.w),
                Text(
                  '${widget.firstName} ${widget.lastName}',
                  style: TextStyle(
                    fontFamily: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.fontFamily,
                    color: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.color,
                    fontSize: 75.sp,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(height: 100.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mail_outline,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 70.w),
              Text(
                (widget.email.length <= 26)
                    ? widget.email
                    : '${widget.email.substring(0, 26)}...',
                style: TextStyle(
                  fontFamily: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.fontFamily,
                  color: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.color,
                  fontSize: MediaQuery.of(context).size.width / 20,
                ),
              ),
              const Spacer(),
            ],
          ),
          SizedBox(height: 100.w),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ChangePassword(),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(width: 70.w),
                Text(
                  "Cambia Password",
                  style: TextStyle(
                    fontFamily: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.fontFamily,
                    color: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.color,
                    fontSize: 75.sp,
                  ),
                ),
                const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}