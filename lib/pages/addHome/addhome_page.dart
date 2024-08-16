import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/addHome/widget/FinishedButton.dart';
import 'package:smartlinx/pages/loginPage/widget/field_wid.dart';

class AddHomePage extends StatefulWidget {
  const AddHomePage({super.key});

  @override
  State<AddHomePage> createState() => _AddHomePageState();
}

class _AddHomePageState extends State<AddHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      if (nameController.text.isEmpty) {
        addressController.text = '';
      }
      setState(() {});
    });
    addressController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.w),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Aggiungi Casa",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.displayLarge?.fontFamily,
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 130.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 120.h),
                Text(
                  "Nome",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayMedium?.fontFamily,
                    color: Theme.of(context).textTheme.displayMedium?.color,
                    fontWeight: FontWeight.w500,
                    fontSize: 70.sp,
                  ),
                ).animate().fade(duration: 700.ms, delay: 0.ms),
                SizedBox(height: 80.h),
                FieldWidget(
                  controller: nameController,
                  hintText: 'Nome casa',
                ).animate().fade(duration: 700.ms, delay: 0.ms),
                SizedBox(height: 120.h),
                if (nameController.text.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Indirizzo",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.displayMedium?.fontFamily,
                          color:
                              Theme.of(context).textTheme.displayMedium?.color,
                          fontWeight: FontWeight.w500,
                          fontSize: 70.sp,
                        ),
                      ).animate().fade(duration: 700.ms, delay: 0.ms),
                      SizedBox(height: 70.h),
                      FieldWidget(
                        controller: addressController,
                        hintText: 'Indirizzo',
                      ).animate().fade(duration: 700.ms, delay: 0.ms),
                    ],
                  ),
                SizedBox(height: 950.h),
                if (addressController.text.isNotEmpty)
                  Center(
                    child: FinishedButton(nameController: nameController, addressController: addressController,)
                        .animate()
                        .fade(duration: 700.ms, delay: 0.ms),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
