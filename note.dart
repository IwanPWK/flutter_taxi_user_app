// The right overflow bug in the row widget on the drawer widget has been fixed.

//  Container(
//             height: 165,
//             color: Colors.grey,
//             child: DrawerHeader(
//               decoration: const BoxDecoration(color: Colors.black),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.person,
//                       size: 80,
//                       color: Colors.grey,
//                     ),
//                     const SizedBox(
//                       width: 16,
//                     ),

// -----------------------------------------------------------------------------------------


//main_screen.dart
  // @override
  // void initState() {
  //   super.initState();
    //asked permission
    // checkIfLocationPermissionAllowed(); kesalahan dikarenakan memanggil checkIfLocationPermissionAllowed di file main_screen.dart
    //karena sebagai permission telat untuk meminta permission, karena map sudah terlanjut di load
  // }

 // you can create polylines dynamic, with point dorpoff to current location (dynamic)



// how to use singlechildscrollview
// main_screen.dart

// Column(
//                     children: [
//                       //from
//                       Stack(
//                         children: [
//                           Row(children: [
//                             const Icon(
//                               Icons.add_location_alt_outlined,
//                               color: Colors.grey,
//                             ),
//                             const SizedBox(
//                               width: 12.0,
//                             ),
//                             Expanded(
//                                 child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                   const Text(
//                                     'From',
//                                     style: TextStyle(
//                                         color: Colors.grey, fontSize: 12),
//                                   ),
//                                   SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     child: Text(
//                                       Provider.of<AppInfo>(context)
//                                                   .userPickUpLocation !=
//                                               null
//                                           ? Provider.of<AppInfo>(context)
//                                               .userPickUpLocation!
//                                               .locationName!
//                                           : "Add pick up",
//                                       style: const TextStyle(
//                                           color: Colors.grey, fontSize: 14),
//                                     ),
//                                   ),
//                                 ])),
//                           ]),
//                         ],
//                       ),





  // with center widget, it will be in the middle and is not stack each other

//  Column(
//                   children: [
//                     Stack(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Icon(
//                             Icons.arrow_back,
//                             color: Colors.grey,
//                           ),
//                         ),

                        // with center widget, it will be in the middle and is not stack each other
//                         const Center(
//                           child: Text(
//                             "Search & Set DropOff Location",
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               color: Colors.grey,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),




// search_places_screen.dart
// with expanded widget you can force widget to fill available space

  // Expanded(
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: TextField(
  //                             onChanged: (valueTyped) {
  //                             },
  //                             decoration: const InputDecoration(
  //                               hintText: "search here...",
  //                               fillColor: Colors.white54,
  //                               filled: true,
  //                               border: InputBorder.none,
  //                               contentPadding: EdgeInsets.only(
  //                                 left: 11.0,
  //                                 top: 8.0,
  //                                 bottom: 8.0,