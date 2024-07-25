import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'anasayfa.dart';

class Dil extends StatefulWidget {
  @override
  _DilState createState() => _DilState();
}

class _DilState extends State<Dil> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation; // Slide animasyonu için

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, -1.0), // Yukarıdan aşağıya kayma için
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation, // Slide animasyonunu uygula
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Language/Dil/Sprache',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ).tr(),
                  SizedBox(height: 20),
                  _buildLanguageCard(
                    context,
                    'English',
                    'assets/images/english.png',
                    Locale('en', 'US'),
                  ),
                  _buildLanguageCard(
                    context,
                    'Türkçe',
                    'assets/images/turkish.png',
                    Locale('tr', 'TR'),
                  ),
                  _buildLanguageCard(
                    context,
                    'Deutsch',
                    'assets/images/german.png',
                    Locale('de', 'DE'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard(
      BuildContext context, String language, String imagePath, Locale locale) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        leading: Image.asset(
          imagePath,
          width: 50,
          height: 50,
        ),
        title: Text(
          language,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.blueGrey),
        onTap: () {
          context.setLocale(locale);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AnaSayfa()),
          );
        },
      ),
    );
  }
}
