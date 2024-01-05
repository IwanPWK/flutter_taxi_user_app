import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../assistants/request_assistant.dart';
import '../globals/global.dart';
import '../globals/map_key.dart';
import '../models/predicted_places.dart';
import '../widgets/place_prediction_tile.dart';

class SearchPlacesScreen extends StatefulWidget {
  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  List<PredictedPlaces> placesPredictedList = [];

  void findPlaceAutoCompleteSearch(String inputText) async {
    Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (inputText.length > 1) //2 or more than 2 input characters
    {
      String urlAutoCompleteSearch =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&location=${cPosition.latitude}%2C${cPosition.longitude}&radius=500&key=$mapKey&components=country:ID";

      var responseAutoCompleteSearch = await RequestAssistant.receiveRequest(urlAutoCompleteSearch);

      if (responseAutoCompleteSearch == "Error Occurred, Failed. No Response.") {
        return;
      }
      // print("latitude longitude ${cPosition.latitude}-${cPosition.longitude}");
      // print("this is response/result: ");
      // print(responseAutoCompleteSearch);
      if (responseAutoCompleteSearch["status"] == "OK") {
        var placePredictions = responseAutoCompleteSearch["predictions"];

        var placePredictionsList = (placePredictions as List).map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();

        setState(() {
          placesPredictedList = placePredictionsList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            //search place ui
            Container(
              height: 160,
              decoration: const BoxDecoration(
                color: Colors.black54,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white54,
                    blurRadius: 8,
                    spreadRadius: 0.5,
                    offset: Offset(
                      0.7,
                      0.7,
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.grey,
                          ),
                        ),

                        // with center widget, it will be in the middle and is not stack each other
                        const Center(
                          child: Text(
                            "Search & Set DropOff Location",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.adjust_sharp,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 18.0,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (valueTyped) {
                                findPlaceAutoCompleteSearch(valueTyped);
                                print(valueTyped);
                              },
                              decoration: const InputDecoration(
                                hintText: "search here...",
                                fillColor: Colors.white54,
                                filled: true,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 11.0,
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //display place predictions result
            (placesPredictedList.isNotEmpty)
                ? Expanded(
                    child: ListView.separated(
                      itemCount: placesPredictedList.length,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PlacePredictionTileDesign(
                          predictedPlaces: placesPredictedList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 1,
                          color: Colors.white,
                          thickness: 1,
                        );
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
