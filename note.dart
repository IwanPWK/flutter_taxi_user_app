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