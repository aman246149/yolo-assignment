import 'package:flutter/material.dart';
import 'package:yolo/screens/yolo_pay.dart';

class BottomnavScreen extends StatefulWidget {
  const BottomnavScreen({super.key});

  @override
  State<BottomnavScreen> createState() => _BottomnavScreenState();
}

class _BottomnavScreenState extends State<BottomnavScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page', style: TextStyle(color: Colors.white, fontSize: 24)),
    YoloPay(),
    Text('Profile Page', style: TextStyle(color: Colors.white, fontSize: 24)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNav(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNav({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 80),
            painter: BottomNavPainter(),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, "assets/images/home.png", 'home'),
                _buildNavItem(1, "assets/images/qr2.PNG", 'yolo pay'),
                _buildNavItem(2, "assets/images/ginie.png", 'ginie'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String image, String label) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: isSelected ? Colors.white : Colors.grey.shade800,
                  width: 1),
            ),
            child: Image.asset(
              image,
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Path path = Path();

    // Start from bottom left
    path.moveTo(0, size.height);

    // Bottom side
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    // Right side up to the start of the curve
    path.lineTo(size.width, 40);

    // Top curved edge - increased height and curve
    path.quadraticBezierTo(
      size.width / 2, // control point x
      -200, // control point y (increased from -150 for higher arch)
      size.width, // end point x
      40, // end point y
    );

    // Left side
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);

    // Draw the thin white border line at the top
    Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Adjust the border curve to match the main curve
    Path borderPath = Path();
    borderPath.moveTo(0, 20);
    borderPath.quadraticBezierTo(
      size.width / 2,
      -50, // increased from -30 for higher border curve
      size.width,
      20,
    );

    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
