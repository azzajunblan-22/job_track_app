import 'package:flutter/material.dart';
import 'job_details_screen.dart';
import '../../localization.dart';
import '../../widgets/language_toggle.dart';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({super.key});
  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  String selectedFilter = "All";
  final List<Map<String, dynamic>> apps = [
    {"title": "Frontend Developer", "company": "Google", "status": "Accepted", "color": Colors.green, "date": "April 20, 2024"},
    {"title": "UI/UX Design Intern", "company": "Amazon", "status": "Pending", "color": Colors.orange, "date": "April 18, 2024"},
    {"title": "Lab Assistant", "company": "Medical Lab", "status": "Rejected", "color": Colors.red, "date": "April 10, 2024"},
  ];

  @override
  Widget build(BuildContext context) {
    var filteredApps = selectedFilter == "All" ? apps : apps.where((a) => a['status'] == selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFEBEEF4),
     appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  // إزالة العنوان النصي Applications
  title: null, 
  leadingWidth: 100, // مساحة إضافية للوجو في جهة اليسار
  leading: Padding(
    padding: const EdgeInsets.only(left: 15.0),
    child: Image.asset(
      'assets/images/logo.jpg', // المسار اللي ذكرتيه
      fit: BoxFit.contain,
      color: const Color(0xFFEBEEF4),
      colorBlendMode: BlendMode.multiply,
    ),
  ),
  actions: [
    const LanguageToggle(),
    IconButton(
      icon: const Icon(Icons.notifications_active_outlined, color: Color(0xFFFDA00C), size: 24),
     onPressed: () {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.all(20),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocale.tr(context, "Notifications"), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(AppLocale.tr(context, "Application Accepted")),
                  subtitle: Text(AppLocale.tr(context, "Your application for Google has been accepted.")),
                ),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.blue),
                  title: Text(AppLocale.tr(context, "New Job Alert")),
                  subtitle: Text(AppLocale.tr(context, "A new 'Flutter Developer' job was posted.")),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
},
    ),
  ],
),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ["All", "Accepted", "Rejected", "Pending"].map((f) {
                bool isS = selectedFilter == f;
                return TextButton(
                  onPressed: () => setState(() => selectedFilter = f),
                  child: Column(
                    children: [
                      Text(AppLocale.tr(context, f), style: TextStyle(color: isS ? const Color(0xFF229BD8) : const Color(0xFF7E848E), fontSize: 14, fontWeight: FontWeight.bold)),
                      if (isS) Container(height: 2, width: 20, color: const Color(0xFF229BD8)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: filteredApps.length,
              itemBuilder: (context, i) => _buildCard(filteredApps[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Map app) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(backgroundColor: Color(0xFFEBEEF4), child: Icon(Icons.business, color: Color(0xFF229BD8))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(AppLocale.tr(context, app['title']), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text(AppLocale.tr(context, app['company']), style: const TextStyle(color: Color(0xFF7E848E), fontSize: 12))])),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: app['color'].withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(AppLocale.tr(context, app['status']), style: TextStyle(color: app['color'], fontWeight: FontWeight.bold, fontSize: 11))),
            ],
          ),
          const Divider(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${AppLocale.tr(context, 'Applied on ')}${AppLocale.tr(context, app['date'])}", style: const TextStyle(color: Color(0xFF7E848E), fontSize: 12)),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => JobDetailsScreen(title: AppLocale.tr(context, app['title']), company: AppLocale.tr(context, app['company']), location: "Remote"))),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF229BD8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                child: Text(AppLocale.tr(context, "View Job"), style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}