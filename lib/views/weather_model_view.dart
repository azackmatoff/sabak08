import 'package:flutter/material.dart';
import 'package:sabak08/models/weather_model.dart';
import 'package:sabak08/repository/weather_repo.dart';

//OOP = Object Oriented Programming

class WeatherModelView extends StatefulWidget {
  const WeatherModelView({Key key}) : super(key: key);

  @override
  _WeatherModelViewState createState() => _WeatherModelViewState();
}

class _WeatherModelViewState extends State<WeatherModelView> {
  final _formKey = GlobalKey<FormState>();
  final _weatherController = TextEditingController();
  Future<WeatherModel> _weather;

  String _city = 'Bishkek';

  @override
  initState() {
    super.initState();
    getWeatherModel();
    print('initState');
  }

  @override
  dispose() {
    //asdas
    super.dispose();
  }

  Future<void> getWeatherModel() async {
    // Future<WeatherModel> _data = weatherRepo.getWeatherModel(_city);
    // _weather = _data;
    _weather = weatherRepo.getWeatherModel(_city);
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Model View'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: TextFormField(
                controller: _weatherController,
                // onChanged: (value) {
                //   setState(() {
                //     _city = value;
                //   });
                // },
                // onSaved: (value) {
                //   setState(() {
                //     _city = value;
                //   });
                // },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city';
                  }

                  if (value.length < 3) {
                    return 'City has to be at least 3 characters';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // _formKey.currentState.save();
                  _city = _weatherController.text;

                  print('validate true: ${_weatherController.text}');
                  _weather = weatherRepo.getWeatherModel(_city);

                  setState(() {});
                } else {
                  print('validate false');
                }
              },
              child: Text('enter'),
            ),
            const SizedBox(height: 50.0),
            FutureBuilder<WeatherModel>(
              future: _weather,
              builder:
                  (BuildContext context, AsyncSnapshot<WeatherModel> snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  WeatherModel weatherModel = snapshot.data;

                  print('weatherModel: ${weatherModel.cityName}');

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'City: ${weatherModel.cityName}',
                        ),
                        Text(
                          'Celcius: ${weatherModel.celcius}',
                        ),
                        Text(
                          'Wind speed: ${weatherModel.windSpeed}',
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: Text('Data null'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
