import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sky_cast/consts/colors.dart';
import 'package:sky_cast/consts/images.dart';

import '../consts/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('en', null);
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.yMMMMd('en');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            formatter.format(now),
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.light_mode,
                color: Colors.black87,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sri Lanka",
                  style: TextStyle(
                    fontFamily: 'poppins_bold',
                    fontSize: 32,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/weather/01d.png',
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "37$degree",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 64,
                              fontFamily: 'poppins',
                            ),
                          ),
                          TextSpan(
                            text: "Sunny",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              fontFamily: 'poppins_light',
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.expand_less_rounded,
                          color: Colors.black87),
                      label: const Text(
                        "41$degree",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.expand_more_rounded,
                          color: Colors.black87),
                      label: const Text("26$degree",
                          style: TextStyle(color: Colors.black87)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(3, (index) {
                    var iconsList = [clouds, humidity, windspeed];
                    var values = ["78%", "40%", "3.5 km/h"];
                    return Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            iconsList[index],
                            width: 60,
                            height: 60,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          values[index],
                          style: const TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${index + 1} AM",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontFamily: 'poppins',
                                //fontWeight: FontWeight.w200,
                              ),
                            ),
                            Image.asset(
                              "assets/weather/09n.png",
                              width: 80,
                            ),
                            const Text(
                              "38$degree",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'poppins',
                                //fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Next 7 Days",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("View All"),
                    )
                  ],
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      var day = DateFormat("EEEE").format(
                          DateTime.now().add(Duration(days: index + 1)));
                      return Card(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  day,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: null,
                                  icon: Image.asset(
                                    "assets/weather/50n.png",
                                    width: 40,
                                  ),
                                  label: const Text(
                                    "26$degree",
                                    style: TextStyle(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "37$degree /",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "poppins",
                                          fontSize: 16,
                                        )),
                                    TextSpan(
                                        text: " 26$degree",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: "poppins",
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
