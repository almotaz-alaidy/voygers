import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lottie/lottie.dart';

import '../constant/images.dart';
import '../controller/HomeController.dart';
import '../model/current_weather_data.dart';

class MyList extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => VerticalDivider(
          color: Colors.transparent,
          width: 5,
        ),
        itemCount: controller.dataList.length,
        itemBuilder: (context, index) {
          CurrentWeatherData? data;
          (controller.dataList.length > 0)
              ? data = controller.dataList[index]
              : data = null;
          return Container(
            width: 140,
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      (data != null) ? '${data.name}' : '',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: 'flutterfonts',
                          ),
                    ),
                    Text(
                      (data != null)
                          ? '${(data.main!.temp! - 273.15).round().toString()}\u2103'
                          : '',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontFamily: 'flutterfonts',
                          ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(
                          "https://toppng.com/uploads/preview/clouds-sun-and-rain-drops-weather-icon-115330395929z6pn6pvwa.png"),
                    ),
                    Text(
                      (data != null) ? '${data.weather![0].description}' : '',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.black45,
                            fontFamily: 'flutterfonts',
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
