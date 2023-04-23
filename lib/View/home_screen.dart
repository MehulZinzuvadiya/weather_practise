import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_practise/Model/weather_model.dart';
import 'package:weather_practise/Provider/home_provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  HomeProvider? homeProviderT;
  HomeProvider? homeProviderF;

  @override
  Widget build(BuildContext context) {
    homeProviderT = Provider.of<HomeProvider>(context, listen: true);
    homeProviderF = Provider.of<HomeProvider>(context, listen: false);
    TextEditingController txtname = TextEditingController();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: homeProviderF!.getWeatherData(homeProviderT!.city),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.hasError}");
                } else if (snapshot.hasData) {
                  WeatherModel? wm = snapshot.data;
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: txtname,
                            decoration: InputDecoration(
                              label: Text('enter city'),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade700,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              String city = txtname.text;
                              homeProviderF!.changeLocation(city);
                            },
                            child: Text("Submit")),
                        Text("${wm!.sys.country}"),
                        Text("${wm.name}"),
                        // Text("${wm.weather[index].description}"),
                        Text("${wm.main.humidity}"),
                        Text("${wm.main.temp}"),
                        Text("${wm.wind.speed}"),
                      ],
                    ),
                  );
                }
                return SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    ));
  }
}
