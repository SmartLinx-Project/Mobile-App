import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../../../services/weather.dart';

class WeatherContainerWidget extends StatefulWidget {
  const WeatherContainerWidget({super.key});

  @override
  State<WeatherContainerWidget> createState() => _WeatherContainerWidgetState();
}

class _WeatherContainerWidgetState extends State<WeatherContainerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoaded = WeatherService.instance.getStatus();
    String lottieUri = '';
    String temperature = '';
    String areaName = '';
    if (isLoaded) {
      lottieUri = WeatherService.instance.getLottieUri();
      temperature = WeatherService.instance.getTemperature();
      areaName =
          '${WeatherService.instance.getCity()}, ${WeatherService.instance.getCountry()}';
    }

    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 115.w),
      alignment: Alignment.center,
      height: 650.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Center(
        child: (isLoaded)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      lottieUri,
                      height: 430.h,
                    ),
                  ),
                  SizedBox(
                    width: 130.w,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 170.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/svg/map_pin.svg',
                              height: 80.h,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            areaName,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$temperature°",
                        style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 200.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Padding(
          padding: EdgeInsets.symmetric(horizontal: 110.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/error.json',
                      height: 400.h, repeat: false),
                  const Spacer(),
                  Text(
                    'Si è verificato\nun errore!',
                    style: TextStyle(
                        fontFamily: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .fontFamily,
                        color: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .color, fontWeight: FontWeight.w500, fontSize: 70.sp),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              Text(
                "Ricontrolla l'indirizzo dell'abitazione",
                style: TextStyle(
                    fontFamily: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .fontFamily,
                    color: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .color, fontWeight: FontWeight.normal, fontSize: 50.sp),
                textAlign: TextAlign.center,
              ),
            ],
          )
        )
      ),
    );
  }
}
