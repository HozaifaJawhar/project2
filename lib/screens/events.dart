import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/widgets/basics/drawar.dart';
import 'package:ammerha_volunteer/widgets/basics/navBar.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});
  final String name = "ميسان";
  final String image = "assets/images/level1(2).jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text("الفرص", style: TextStyle(color: AppColors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: AppColors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawar(userName: name, userImage: image),
      body: SafeArea(child: Text('data')),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}

// class OpportunitiesPage extends StatelessWidget {
//   const OpportunitiesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
//         title: const Text('الفرص'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications_none),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'انا ابحث عن...',
//                       prefixIcon: const Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.orange.shade300,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.all(8),
//                   child: const Icon(Icons.filter_alt, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 4, // replace with your data
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     elevation: 2,
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: const [
//                                 Text(
//                                   '25 مايو 2025  |  الصحة والتثقيف الصحي',
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                                 SizedBox(height: 6),
//                                 Text(
//                                   'حملة توعية صحية في المدارس',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 SizedBox(height: 6),
//                                 Text(
//                                   '50 متطوع  |  35 متطوع تم قبولهم',
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.asset(
//                               'assets/images/event.jpg',
//                               height: 60,
//                               width: 60,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work_outline),
//             label: 'الفرص',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.emoji_events),
//             label: 'لوحة الشرف',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article_outlined),
//             label: 'الأخبار',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: 'الشخصية',
//           ),
//         ],
//         currentIndex: 1,
//         onTap: (index) {},
//       ),
//     );
//   }
// }
