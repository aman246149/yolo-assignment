import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_animate/flutter_animate.dart';

class YoloPay extends StatefulWidget {
  const YoloPay({super.key});

  @override
  State<YoloPay> createState() => _YoloPayState();
}

class _YoloPayState extends State<YoloPay> {
  bool isCardSelected = true;
  bool isCardFrozen = true;
  bool isCvvVisible = false;
  List<String> fakeCardNumber = ['1234', '5678', '9012', '3456'];
  String fakeCardExpiry = '01/24';
  String fakeCardCVV = '123';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'select payment mode',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'choose your preferred payment method to\nmake payment.',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),
              _buildPaymentOptions(),
              const SizedBox(height: 48),
              _buildCardSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Row(
      children: [
        _buildCustomButton('pay', !isCardSelected),
        const SizedBox(width: 12),
        _buildCustomButton('card', isCardSelected),
      ],
    );
  }

  Widget _buildCustomButton(String text, bool isSelected) {
    return StatefulBuilder(builder: (context, setState) {
      bool isPressed = false;

      return GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),
        onTap: () {
          this.setState(() {
            isCardSelected = text == 'card';
          });
        },
        child: CustomPaint(
          painter: GradientBorderPainter(
            isSelected: isSelected,
            isPressed: isPressed,
            strokeWidth: 1,
            borderRadius: 40,
          ),
          child: Container(
            width: 96,
            height: 45,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? const Color(0xFFA90808) : Colors.white,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCardSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR DIGITAL DEBIT CARD',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    blurRadius: 14,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/rupee_card_3.png',
                    height: 295,
                    width: 186,
                    fit: BoxFit.cover,
                  ),
                  if (isCardFrozen)
                    Container(
                      height: 295,
                      width: 186,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        backgroundBlendMode: BlendMode.screen,
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .scale(
                            begin: const Offset(1.2, 1.2),
                            end: const Offset(1.0, 1.0))
                        .shimmer(
                          duration: 1.5.seconds,
                          color: Colors.white.withOpacity(0.3),
                        ),
                  if (isCardFrozen)
                    Image.asset(
                      'assets/images/freeze_card2.png',
                      height: 295,
                      width: 186,
                      fit: BoxFit.cover,
                    )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .scale(
                            begin: const Offset(1.2, 1.2),
                            end: const Offset(1.0, 1.0))
                        .shimmer(
                          duration: 2.seconds,
                          color: Colors.white.withOpacity(0.2),
                        ),
                  if (!isCardFrozen) ...[
                    // Card number positions
                    ...fakeCardNumber.asMap().entries.map((entry) {
                      int index = entry.key;
                      String number = entry.value;
                      return Positioned(
                        top: 70 + (index * 30),
                        left: 20,
                        right: 0,
                        bottom: 0,
                        child: Text(
                          number,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            .animate()
                            .fadeIn(
                              duration: 400.ms,
                              delay: (100 * index).ms,
                            )
                            .slideX(
                              begin: -0.2,
                              end: 0,
                              duration: 400.ms,
                              delay: (100 * index).ms,
                            ),
                      );
                    }).toList(),

                    // CVV and Expiry section
                    Positioned(
                      top: 70,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "expiry",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            fakeCardExpiry,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "cvv",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 39,
                                child: isCvvVisible
                                    ? Text(
                                        fakeCardCVV,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ).animate().fadeIn(duration: 300.ms)
                                    : Image.asset(
                                        'assets/images/star.png',
                                        width: 39,
                                      ).animate().fadeIn(duration: 300.ms),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCvvVisible = !isCvvVisible;
                                  });
                                },
                                child: Icon(
                                  isCvvVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Color(0xFFA90808),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).animate().fadeIn(duration: 600.ms).slideX(
                            begin: 0.2,
                            end: 0,
                            duration: 600.ms,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCardFrozen = !isCardFrozen;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 58,
                          width: 58,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF000000),
                            border: Border.all(
                              color: isCardFrozen
                                  ? const Color(0xFFA90808)
                                  : Colors.white,
                              width: 1,
                            ),
                          ),
                        )
                            .animate(
                              target: isCardFrozen ? 1 : 0,
                            )
                            .shimmer(
                              duration: 1.5.seconds,
                              color: isCardFrozen
                                  ? const Color(0xFFA90808).withOpacity(0.3)
                                  : Colors.white.withOpacity(0.3),
                            ),
                        Icon(
                          Icons.ac_unit,
                          color: isCardFrozen
                              ? const Color(0xFFA90808)
                              : Colors.white,
                          size: 24,
                        )
                            .animate(
                              target: isCardFrozen ? 1 : 0,
                            )
                            .rotate(
                              duration: 600.ms,
                              curve: Curves.easeInOut,
                            ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isCardFrozen ? 'unfreeze' : 'freeze',
                    style: TextStyle(
                      color:
                          isCardFrozen ? const Color(0xFFA90808) : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final bool isSelected;
  final bool isPressed;
  final double strokeWidth;
  final double borderRadius;

  GradientBorderPainter({
    required this.isSelected,
    required this.isPressed,
    required this.strokeWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final RRect rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    if (isSelected) {
      // Create a gradient for selected buttons (red to completely transparent)
      paint.shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(0, size.height),
        [
          const Color(0xFFA90808), // Full red at top
          const Color(0x66A90808), // 40% opacity red at middle
          Color(0x66A90808)
              .withOpacity(0.1), // Completely transparent at bottom
        ],
        [0.0, 0.6, 1.0], // Adjusted stops for faster fade-out
      );

      // Apply a subtle scale down effect when pressed
      if (isPressed) {
        canvas.save();
        final scaleFactor = 0.98;
        // canvas.scale(scaleFactor, scaleFactor, size.width / 2, size.height / 2);
      }
    } else {
      // Non-selected buttons (white/gray to completely transparent)
      paint.shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(0, size.height),
        [
          Colors.grey.shade400, // Light grey at top
          Colors.grey.withOpacity(0.5), // 50% opacity grey at middle
          Colors.grey.withOpacity(0.1), // Completely transparent at bottom
        ],
        [0.0, 0.5, 0.85], // Adjusted stops for faster fade-out
      );
    }

    canvas.drawRRect(rrect, paint);

    if (isPressed) {
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
