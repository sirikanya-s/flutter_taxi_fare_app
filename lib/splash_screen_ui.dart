import 'dart:async';
import 'package:flutter/material.dart';
import 'taxi_fare_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    super.initState();
    // หน่วงเวลา 3 วินาที แล้วสลับไปหน้า TaxiFareUi ทันที
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TaxiFareUi()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF7FC), // โทนพื้นหลังสีขาวอมชมพูอ่อนมาก
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ไอคอนแท็กซี่ (ถ้ามีไฟล์รูปภาพในโฟลเดอร์ assets ค่อยสลับมาใช้ Image.asset ได้ครับ)
            const Icon(
              Icons.local_taxi_rounded,
              size: 130,
              color: Color(0xFFF7B500),
            ),
            const SizedBox(height: 24),

            // ข้อความหัวข้อ
            const Text(
              'Taxi Fare Calculator',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4FA8EE),
              ),
            ),
            const SizedBox(height: 6),

            // คำอธิบายภาษาไทย
            const Text(
              'คำนวณค่าโดยสารแท็กซี่',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF6BB5F2),
              ),
            ),
            const SizedBox(height: 32),

            // วงล้อหมุนโหลดสีส้มเหลือง
            const SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                strokeWidth: 3.5,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF7B500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}