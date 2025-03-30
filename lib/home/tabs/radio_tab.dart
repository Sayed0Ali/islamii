import 'package:flutter/material.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  int playingIndex = -1;
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          ToggleButtonsSection(
            selectedTab: selectedTab,
            onTabSelected: (index) => setState(() => selectedTab = index),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: selectedTab == 0 ? _buildRadioTiles() : _buildRecitersTiles(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRadioTiles() {
    return [
      _buildRadioTile("Radio ahmad al hothaifa", 0),
      _buildRadioTile("Radio Al-Qaria Yassen", 1),
      _buildRadioTile("Radio Ahmed naser", 2),
      _buildRadioTile("Radio ibrahim al akhdar ", 3),
    ];
  }

  List<Widget> _buildRecitersTiles() {
    return [
      _buildRadioTile("ahmad al hothaifa", 0),
      _buildRadioTile("Al-Qaria Yassen", 1),
      _buildRadioTile("Ahmed naser", 2),
      _buildRadioTile("ibrahim al akhdar", 3),
    ];
  }

  Widget _buildRadioTile(String title, int index) {
    return RadioTile(
      title: title,
      isPlaying: playingIndex == index,
      onTap: () => setState(() => playingIndex = playingIndex == index ? -1 : index),
    );
  }
}

class ToggleButtonsSection extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabSelected;

  const ToggleButtonsSection({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(20, 20, 20, 70),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildToggleButton("Radio", 0),
            const SizedBox(width: 10),
            _buildToggleButton("Reciters", 1),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, int index) {
    return InkWell(
      onTap: () => onTabSelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: BoxDecoration(
          color: selectedTab == index ? const Color(0xffE2BE7F) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffE2BE7F), width: 2),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: selectedTab == index ? Colors.black : const Color(0xffE2BE7F),
          ),
        ),
      ),
    );
  }
}

class RadioTile extends StatelessWidget {
  final String title;
  final bool isPlaying;
  final VoidCallback onTap;

  const RadioTile({
    super.key,
    required this.title,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xffE2BE7F),
            image: DecorationImage(
              image: AssetImage(isPlaying ? 'assets/images/soundWave.png' : 'assets/images/playing.png'),
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(45),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.black),
                          const Icon(Icons.volume_up),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}