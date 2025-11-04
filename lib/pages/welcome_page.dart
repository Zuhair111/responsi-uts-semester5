import 'package:flutter/material.dart';
import 'create_account_screen.dart';
import 'sign_in_screen.dart'; // ✅ Tambahkan import ini agar bisa navigasi ke halaman Sign In

// Model data untuk setiap halaman onboarding
class OnboardingPageData {
  final String title;
  final String description;
  final String imagePath;
  final String waveShapePath = 'assets/bg-shape.png'; // Gelombang sama

  OnboardingPageData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

// Data untuk 3 halaman onboarding
final List<OnboardingPageData> pages = [
  OnboardingPageData(
    title: 'Hello, And Welcome to Soziety.',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    imagePath: 'assets/pic1.png',
  ),
  OnboardingPageData(
    title: "People's First Preference Is Soziety",
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    imagePath: 'assets/pic1.png',
  ),
  OnboardingPageData(
    title: 'Expand Your Network With Soziety',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    imagePath: 'assets/pic1.png',
  ),
];

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (next != _currentPage) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Widget pembantu untuk indikator titik
  Widget _buildDot(int index) {
    final Color color = index == _currentPage
        ? const Color(0xFFFE8F5F)
        : Colors.grey[300]!;

    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final pageData = pages[index];

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // ==========================
                // Bagian Atas (Gambar + Gelombang)
                // ==========================
                Container(
                  color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: screenHeight * 0.42,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(pageData.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -22,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          pageData.waveShapePath,
                          fit: BoxFit.fitWidth,
                          height: 110,
                          color: Colors.white,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),

                // ==========================
                // Bagian Bawah (Teks & Tombol)
                // ==========================
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 25.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        pageData.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        pageData.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          pages.length,
                          (i) => _buildDot(i),
                        ),
                      ),
                      const SizedBox(height: 35),

                      // Tombol CREATE ACCOUNT
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CreateAccountScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFE8F5F),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'CREATE ACCOUNT',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // ✅ Tombol SIGN IN (menuju halaman SignInScreen)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE0E0E0),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF757575),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Forgot your account?',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
