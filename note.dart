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