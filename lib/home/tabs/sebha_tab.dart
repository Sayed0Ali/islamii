import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  _SebhaTabState createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> with SingleTickerProviderStateMixin {
  final List<String> _tasbeehPhrases = [
    'سَبِّحِ اسْمَ رَبِّكَ الْأَعْلَىَ',
    'فَسَبِّحْ بِحَمْدِ رَبِّكَ',
    'ُقُلْ هُوَ اللَّهُ أَحَدٌ',
    'وَرَبَّكَ فَكَبِّرۡ'
  ];

  final List<String> _tasbeehWords = [
    'سبحان الله',
    'الحمد لله',
    'لا إله إلا الله',
    'الله أكبر',
  ];

  int _currentPhraseIndex = 0;
  int _thikrCount = 1;

  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _handleSebhaTap() {
    setState(() {
      if (_thikrCount < 33) {
        _thikrCount++;
      } else {
        _thikrCount = 1;
        _currentPhraseIndex = (_currentPhraseIndex + 1) % _tasbeehWords.length;
      }
    });
    _rotationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(),
          Column(
            children: [

              const SizedBox(height: 20),
              _buildTasbeehContent(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/img_1.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }



  Widget _buildTasbeehContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTasbeehPhrase(),
        const SizedBox(height: 10),
        _buildMaskImage(),
        _buildSebhaWidget(),
      ],
    );
  }

  Widget _buildTasbeehPhrase() {
    return Text(
      _tasbeehPhrases[_currentPhraseIndex],
      style: GoogleFonts.aBeeZee(
        fontSize: 39,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMaskImage() {
    return Center(
      child: Image.asset(
        'assets/images/head_sebha.png',
        height: 65,
        width: 120,
      ),
    );
  }

  Widget _buildSebhaWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: _handleSebhaTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildRotatingSebha(),
            _buildTasbeehText(),
          ],
        ),
      ),
    );
  }

  Widget _buildRotatingSebha() {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationController.value * (2 * 3.14159 / 33),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.41,

            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sebha.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTasbeehText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 6),
        Text(
          _tasbeehWords[_currentPhraseIndex],
          style: GoogleFonts.elMessiri(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          "$_thikrCount",
          style: GoogleFonts.elMessiri(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}