import 'package:flutter/material.dart';

class AppLocale extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void toggleLanguage() {
    _locale = _locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    notifyListeners();
  }

  // Helper method to translate
  static String tr(BuildContext context, String key) {
    final locale = context.dependOnInheritedWidgetOfExactType<_LocaleProvider>()?.locale.languageCode ?? 'en';
    return _translations[locale]?[key] ?? key; // return key if not found
  }
}

class _LocaleProvider extends InheritedWidget {
  final Locale locale;

  const _LocaleProvider({
    required this.locale,
    required super.child,
  });

  @override
  bool updateShouldNotify(_LocaleProvider oldWidget) => locale != oldWidget.locale;
}

class LocalizationWrapper extends StatelessWidget {
  final AppLocale localeController;
  final Widget child;

  const LocalizationWrapper({super.key, required this.localeController, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: localeController,
      builder: (context, child) {
        return _LocaleProvider(
          locale: localeController.locale,
          child: this.child,
        );
      },
    );
  }
}

// Translations Map
const Map<String, Map<String, String>> _translations = {
  'en': {
    "English": "English",
    "العربية": "العربية",
    "Notifications": "Notifications",
    "Applications": "Applications",
    "Home": "Home",
    "Profile": "Profile",
    "Home Screen (Coming Soon...)": "Home Screen (Coming Soon...)",
    "All": "All",
    "Accepted": "Accepted",
    "Rejected": "Rejected",
    "Pending": "Pending",
    "Frontend Developer": "Frontend Developer",
    "Google": "Google",
    "Amazon": "Amazon",
    "Medical Lab": "Medical Lab",
    "April 20, 2024": "April 20, 2024",
    "April 18, 2024": "April 18, 2024",
    "April 10, 2024": "April 10, 2024",
    "UI/UX Design Intern": "UI/UX Design Intern",
    "Lab Assistant": "Lab Assistant",
    "Applied on ": "Applied on ",
    "View Job": "View Job",
    "Application Accepted": "Application Accepted",
    "Your application for Google has been accepted.": "Your application for Google has been accepted.",
    "Your application for Google has been accepted!": "Your application for Google has been accepted!",
    "New Job Alert": "New Job Alert",
    "A new 'Flutter Developer' job was posted.": "A new 'Flutter Developer' job was posted.",
    "Ahmed Khalid": "Ahmed Khalid",
    "Graduated in 2026": "Graduated in 2026",
    "Ain Shams University": "Ain Shams University",
    "Computer Science": "Computer Science",
    "Skills": "Skills",
    "CV": "CV",
    "Add skill...": "Add skill...",
    "Save": "Save",
    "Edit": "Edit",
    "Teamwork": "Teamwork",
    "Java": "Java",
    "Data analysis": "Data analysis",
    "Critical thinking": "Critical thinking",
    "Time management": "Time management",
    "Excel": "Excel",
    "soft skills": "soft skills",
    "Laboratory techniques": "Laboratory techniques",
    "Application View": "Application View",
    "Company X viewed your CV.": "Company X viewed your CV.",
    "2m ago": "2m ago",
    "1h ago": "1h ago",
    "CV Uploaded: ": "CV Uploaded: ",
    "Please upload a CV first.": "Please upload a CV first.",
    "Remote": "Remote",
    "Hybrid": "Hybrid",
    "Job Description": "Job Description",
    "We are looking for a creative developer to join our team in Cairo. This role involves designing and implementing high-quality user interfaces.": "We are looking for a creative developer to join our team in Cairo. This role involves designing and implementing high-quality user interfaces.",
    "See less": "See less",
    "See more >": "See more >",
    "Job Requirements": "Job Requirements",
    "Bachelor's degree in Computer Science.": "Bachelor's degree in Computer Science.",
    "Strong experience with Flutter and Dart.": "Strong experience with Flutter and Dart.",
    "Professional English language.": "Professional English language.",
    "Applied Successfully!": "Applied Successfully!",
    "Applied": "Applied",
    "Apply Now": "Apply Now",
    "View Company Profile": "View Company Profile",
    "Now": "Now",
    "Organic": "Organic",
    "About Organic": "About Organic",
    "A leading manufacturer and distributor of high-quality pharmaceutical products, dedicated to improving public health.": "A leading manufacturer and distributor of high-quality pharmaceutical products, dedicated to improving public health.",
    "Posted Jobs": "Posted Jobs",
    "Pharmaceutical Control": "Pharmaceutical Control",
    "Cairo, Egypt": "Cairo, Egypt",
    "Full-Time": "Full-Time",
    "Quality Analyst": "Quality Analyst",
    "Alexandria, Egypt": "Alexandria, Egypt",
    "Internship": "Internship",
  },
  'ar': {
    "English": "English",
    "العربية": "العربية",
    "Notifications": "الإشعارات",
    "Applications": "التقديمات",
    "Home": "الرئيسية",
    "Profile": "الملف الشخصي",
    "Home Screen (Coming Soon...)": "الشاشة الرئيسية (قريباً...)",
    "All": "الكل",
    "Accepted": "مقبول",
    "Rejected": "مرفوض",
    "Pending": "قيد الانتظار",
    "Frontend Developer": "مطور واجهات أمامية",
    "Google": "جوجل",
    "Amazon": "أمازون",
    "Medical Lab": "معمل طبي",
    "April 20, 2024": "20 أبريل 2024",
    "April 18, 2024": "18 أبريل 2024",
    "April 10, 2024": "10 أبريل 2024",
    "UI/UX Design Intern": "متدرب تصميم واجهات مستخدم",
    "Lab Assistant": "مساعد معمل",
    "Applied on ": "تم التقديم في ",
    "View Job": "عرض الوظيفة",
    "Application Accepted": "تم قبول التقديم",
    "Your application for Google has been accepted.": "تم قبول تقديمك في جوجل.",
    "Your application for Google has been accepted!": "تم قبول تقديمك في جوجل!",
    "New Job Alert": "تنبيه وظيفة جديدة",
    "A new 'Flutter Developer' job was posted.": "تم نشر وظيفة 'مطور فلاتر' جديدة.",
    "Ahmed Khalid": "أحمد خالد",
    "Graduated in 2026": "تخرج في 2026",
    "Ain Shams University": "جامعة عين شمس",
    "Computer Science": "علوم الحاسب",
    "Skills": "المهارات",
    "CV": "السيرة الذاتية",
    "Add skill...": "أضف مهارة...",
    "Save": "حفظ",
    "Edit": "تعديل",
    "Teamwork": "العمل الجماعي",
    "Java": "جافا",
    "Data analysis": "تحليل البيانات",
    "Critical thinking": "التفكير النقدي",
    "Time management": "إدارة الوقت",
    "Excel": "إكسل",
    "soft skills": "مهارات شخصية",
    "Laboratory techniques": "تقنيات معملية",
    "Application View": "مشاهدة التقديم",
    "Company X viewed your CV.": "الشركة X شاهدت سيرتك الذاتية.",
    "2m ago": "منذ دقيقتين",
    "1h ago": "منذ ساعة",
    "CV Uploaded: ": "تم رفع السيرة الذاتية: ",
    "Please upload a CV first.": "يرجى رفع السيرة الذاتية أولاً.",
    "Remote": "عن بُعد",
    "Hybrid": "عمل هجين",
    "Job Description": "وصف الوظيفة",
    "We are looking for a creative developer to join our team in Cairo. This role involves designing and implementing high-quality user interfaces.": "نحن نبحث عن مطور مبدع للانضمام لفريقنا في القاهرة. يتضمن هذا الدور تصميم وتنفيذ واجهات مستخدم عالية الجودة.",
    "See less": "عرض أقل",
    "See more >": "عرض المزيد >",
    "Job Requirements": "متطلبات الوظيفة",
    "Bachelor's degree in Computer Science.": "درجة البكالوريوس في علوم الحاسب.",
    "Strong experience with Flutter and Dart.": "خبرة قوية في فلاتر ودارت.",
    "Professional English language.": "لغة إنجليزية احترافية.",
    "Applied Successfully!": "تم التقديم بنجاح!",
    "Applied": "تم التقديم",
    "Apply Now": "قدم الآن",
    "View Company Profile": "عرض ملف الشركة",
    "Now": "الآن",
    "Organic": "أورجانيك",
    "About Organic": "عن أورجانيك",
    "A leading manufacturer and distributor of high-quality pharmaceutical products, dedicated to improving public health.": "شركة رائدة في تصنيع وتوزيع المنتجات الصيدلانية عالية الجودة، مكرسة لتحسين الصحة العامة.",
    "Posted Jobs": "الوظائف المنشورة",
    "Pharmaceutical Control": "الرقابة الصيدلانية",
    "Cairo, Egypt": "القاهرة، مصر",
    "Full-Time": "دوام كامل",
    "Quality Analyst": "محلل جودة",
    "Alexandria, Egypt": "الإسكندرية، مصر",
    "Internship": "فترة تدريب",
  }
};
