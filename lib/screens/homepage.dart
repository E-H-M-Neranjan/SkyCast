import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:sky_cast/consts/images.dart';
import 'package:sky_cast/consts/strings.dart';
import 'package:sky_cast/controllers/main_controller.dart';
import 'package:sky_cast/models/current_weather_model.dart';
import 'package:sky_cast/models/hourly_weather_model.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var date = DateFormat("yMMMMd").format(DateTime.now());
    var theme = Theme.of(context);
    var controller = Get.put(MainController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: date.text.color(Colors.black).size(28).make(),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Obx(
          () => controller.isloaded.value == true
              ? Container(
                  padding: const EdgeInsets.all(12),
                  child: FutureBuilder(
                    future: controller.currentWeatherData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        CurrentWeatherData data = snapshot.data;

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data.name}"
                                  .text
                                  .uppercase
                                  .fontFamily("poppins_bold")
                                  .size(38)
                                  .letterSpacing(3)
                                  .color(Colors.black)
                                  .make(),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/weather/${data.weather![0].icon}.png",
                                    width: 80,
                                    height: 80,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${data.main!.temp}$degree",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 64,
                                            fontFamily: "poppins",
                                          ),
                                        ),
                                        TextSpan(
                                          text: " ${data.weather![0].main}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 3,
                                            fontSize: 14,
                                            fontFamily: "poppins",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    onPressed: null,
                                    icon: Icon(Icons.expand_less_rounded,
                                        color: theme.iconTheme.color),
                                    label: "${data.main!.tempMax}$degree"
                                        .text
                                        .color(theme.iconTheme.color)
                                        .make(),
                                  ),
                                  TextButton.icon(
                                    onPressed: null,
                                    icon: Icon(Icons.expand_more_rounded,
                                        color: theme.iconTheme.color),
                                    label: "${data.main!.tempMin}$degree"
                                        .text
                                        .color(theme.iconTheme.color)
                                        .make(),
                                  )
                                ],
                              ),
                              20.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                  3,
                                  (index) {
                                    var iconsList = [
                                      clouds,
                                      humidity,
                                      windspeed
                                    ];
                                    var values = [
                                      "${data.clouds!.all}%",
                                      "${data.main!.humidity}%",
                                      "${data.wind!.speed} km/h"
                                    ];
                                    return Column(
                                      children: [
                                        Image.asset(
                                          iconsList[index],
                                          width: 60,
                                          height: 60,
                                        )
                                            .box
                                            .gray200
                                            .padding(const EdgeInsets.all(8))
                                            .roundedSM
                                            .make(),
                                        10.heightBox,
                                        values[index].text.gray400.make(),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              20.heightBox,
                              const Divider(),
                              30.heightBox,
                              FutureBuilder(
                                future: controller.hourlyWeatherData,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    HourlyWeatherData hourlyData =
                                        snapshot.data;

                                    return SizedBox(
                                      height: 160,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: hourlyData.list!.length > 6
                                            ? 6
                                            : hourlyData.list!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var time = DateFormat.jm().format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                hourlyData.list![index].dt!
                                                        .toInt() *
                                                    1000),
                                          );

                                          return Container(
                                            padding: const EdgeInsets.all(8),
                                            margin:
                                                const EdgeInsets.only(right: 4),
                                            decoration: BoxDecoration(
                                              color: Vx.gray200,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Column(
                                              children: [
                                                time.text.make(),
                                                Image.asset(
                                                  "assets/weather/${hourlyData.list![index].weather![0].icon}.png",
                                                  width: 80,
                                                ),
                                                10.heightBox,
                                                "${hourlyData.list![index].main!.temp}$degree"
                                                    .text
                                                    .make(),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                              20.heightBox,
                              const Divider(),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
