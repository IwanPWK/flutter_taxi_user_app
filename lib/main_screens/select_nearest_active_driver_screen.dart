import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../globals/global.dart';
import '../utils/fare_amount_util.dart';

class SelectNearestActiveDriversScreen extends StatefulWidget {
  const SelectNearestActiveDriversScreen({super.key});

  @override
  State<SelectNearestActiveDriversScreen> createState() => _SelectNearestActiveDriversScreenState();
}

class _SelectNearestActiveDriversScreenState extends State<SelectNearestActiveDriversScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: const Text(
          "Nearest Online Drivers",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            //delete/remove the ride request from database

            Navigator.pop(context);
            dList.clear();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: dList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.grey,
            elevation: 3,
            shadowColor: Colors.green,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Image.asset(
                  "images/${dList[index]["car_details"]["type"]}.png",
                  width: 70,
                ),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    dList[index]["name"],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    dList[index]["car_details"]["car_model"],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                  ),
                  SmoothStarRating(
                    rating: 3.5,
                    color: Colors.black,
                    borderColor: Colors.black,
                    allowHalfRating: true,
                    starCount: 5,
                    size: 15,
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    FareAmount.getFareAmountAccordingToVehicleType(index),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    tripDirectionDetailsInfo != null ? tripDirectionDetailsInfo!.distanceText! : '0 km',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    tripDirectionDetailsInfo != null ? tripDirectionDetailsInfo!.durationText! : '0 min',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
