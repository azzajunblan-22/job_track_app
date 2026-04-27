import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import '../../localization.dart';
import '../../widgets/language_toggle.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditingMode = false;

  // البيانات التي سيتم تعديلها
  String name = "Ahmed Khalid";
  String graduation = "Graduated in 2026";
  String university = "Ain Shams University";
  String major = "Computer Science";
  
  List<String> skills = ["Teamwork", "Java", "Data analysis", "Critical thinking", "Time management", "Excel", "soft skills", "Laboratory techniques"];
  
  final TextEditingController _skillController = TextEditingController();

  Uint8List? _profileImageBytes;
  String? _cvFileName;
  String? _cvFilePath;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() => _profileImageBytes = bytes);
    }
  }

  Future<void> _pickCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null) {
      setState(() {
        _cvFilePath = result.files.single.path;
        _cvFileName = result.files.single.name;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("CV Uploaded: $_cvFileName")));
    }
  }

  Future<void> _viewCV() async {
    if (_cvFilePath != null) {
      await OpenFile.open(_cvFilePath);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please upload a CV first.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEEF4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 15),
              // الهيدر: اللوجو على اليسار والجرس على اليمين
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.arrow_back_ios, size: 18, color: Color(0xFFFDA00C)),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/images/logo.jpg', 
                        height: 45,
                        color: const Color(0xFFEBEEF4),
                        colorBlendMode: BlendMode.multiply,
                      ), 
                    ],
                  ),
                  Row(
                    children: [
                      const LanguageToggle(),
                      IconButton(
                        icon: const Icon(Icons.notifications_active_outlined, color: Color(0xFFFDA00C), size: 24),
                        onPressed: () => _showNotifications(context),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // صورة البروفايل الجديدة
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage: _profileImageBytes != null ? MemoryImage(_profileImageBytes!) as ImageProvider : const AssetImage('assets/images/pro.jpg'), // الصورة المطلوبة
                      ),
                    ),
                    if (isEditingMode)
                      GestureDetector(
                        onTap: _pickImage,
                        child: const CircleAvatar(
                          backgroundColor: Color(0xFFFDA00C),
                          radius: 18,
                          child: Icon(Icons.camera_alt, size: 18, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // الاسم والبيانات (تعديل مباشر)
              _buildEditableInfo(),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Divider(thickness: 1, color: Colors.black12),
              ),

              // العناوين: Skills & CV
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(AppLocale.tr(context, "Skills"), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(AppLocale.tr(context, "CV"), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
              const SizedBox(height: 15),

              // المهارات والـ CV
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // صندوق المهارات (تعديل الحذف والإضافة)
                  Expanded(
                    child: _buildSectionCard(
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 6,
                            runSpacing: 8,
                            children: skills.map((s) => _buildSkillTag(s)).toList(),
                          ),
                          if (isEditingMode) ...[
                            const SizedBox(height: 15),
                            TextField(
                              controller: _skillController,
                              style: const TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                hintText: AppLocale.tr(context, "Add skill..."),
                                isDense: true,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.add_circle, color: Colors.blue),
                                  onPressed: () {
                                    if (_skillController.text.isNotEmpty) {
                                      setState(() {
                                        skills.add(_skillController.text);
                                        _skillController.clear();
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // صندوق الـ CV
                  Expanded(
                    child: _buildSectionCard(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Icon(Icons.description, size: 70, color: _cvFileName != null ? const Color(0xFF229BD8) : Colors.grey),
                          if (_cvFileName != null) 
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(_cvFileName!, style: const TextStyle(fontSize: 10, color: Colors.black54), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(onTap: _viewCV, child: const Icon(Icons.visibility_outlined, color: Colors.black54)),
                              if (isEditingMode) GestureDetector(onTap: _pickCV, child: const Icon(Icons.edit, size: 18, color: Colors.black54)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // زر التعديل
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () => setState(() => isEditingMode = !isEditingMode),
                  icon: Icon(isEditingMode ? Icons.check : Icons.edit, size: 18),
                  label: Text(AppLocale.tr(context, isEditingMode ? "Save" : "Edit")),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF229BD8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // بناء حقول النصوص القابلة للتعديل
  Widget _buildEditableInfo() {
    return Column(
      children: [
        isEditingMode 
          ? _editField(name, (v) => name = v, bold: true)
          : Text(AppLocale.tr(context, name), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        
        const SizedBox(height: 8),
        
        isEditingMode 
          ? Column(
              children: [
                _editField(graduation, (v) => graduation = v),
                _editField(university, (v) => university = v),
                _editField(major, (v) => major = v),
              ],
            )
          : Text("${AppLocale.tr(context, graduation)}\n${AppLocale.tr(context, university)}\n${AppLocale.tr(context, major)}", 
              textAlign: TextAlign.center, 
              style: const TextStyle(color: Color(0xFF7E848E), height: 1.5, fontSize: 12)),
      ],
    );
  }

  // حقل تعديل فرعي
  Widget _editField(String initialValue, Function(String) onChanged, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: IntrinsicWidth(
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: bold ? 20 : 14,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: bold ? Colors.black : Colors.grey,
          ),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF229BD8))),
          ),
          controller: TextEditingController(text: initialValue)..selection = TextSelection.collapsed(offset: initialValue.length),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildSectionCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: child,
    );
  }

  // المهارات (تم تثبيت الخط وجعلها قابلة للحذف)
  Widget _buildSkillTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12, width: 1.5), // خط أتقل شوية
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocale.tr(context, label), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)), // خط أسمك
          if (isEditingMode) ...[
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () => setState(() => skills.remove(label)),
              child: const Icon(Icons.close, size: 14, color: Colors.red),
            ),
          ],
        ],
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Text(AppLocale.tr(context, "Notifications"), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  _notificationItem(AppLocale.tr(context, "New Job Alert"), AppLocale.tr(context, "A new job matches your profile."), AppLocale.tr(context, "2m ago")),
                  _notificationItem(AppLocale.tr(context, "Application View"), AppLocale.tr(context, "Company X viewed your CV."), AppLocale.tr(context, "1h ago")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationItem(String title, String body, String time) {
    return ListTile(
      leading: const CircleAvatar(backgroundColor: Colors.orange, child: Icon(Icons.work, color: Colors.white)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(body),
      trailing: Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }
}