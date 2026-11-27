import 'package:flutter/material.dart';

class TaxiFareUi extends StatefulWidget {
  const TaxiFareUi({super.key});

  @override
  State<TaxiFareUi> createState() => _TaxiFareUiState();
}

class _TaxiFareUiState extends State<TaxiFareUi> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _trafficController = TextEditingController();

  double _totalFare = 0.0;
  bool _showErrorBanner = false;

  void _calculateFare() {
    String distanceText = _distanceController.text.trim();
    String trafficText = _trafficController.text.trim();

    // ตรวจสอบว่ากรอกข้อมูลครบหรือไม่
    if (distanceText.isEmpty || trafficText.isEmpty) {
      setState(() {
        _showErrorBanner = true;
      });
      return;
    }

    double? distance = double.tryParse(distanceText);
    double? traffic = double.tryParse(trafficText);

    if (distance == null || traffic == null || distance < 0 || traffic < 0) {
      setState(() {
        _showErrorBanner = true;
      });
      return;
    }

    setState(() {
      _showErrorBanner = false;
    });

    double fare = 0.0;

    // คำนวณค่าโดยสารแบบขั้นบันไดตามกฎกระทรวง
    if (distance <= 1) {
      fare = 35.0;
    } else if (distance <= 10) {
      fare = 35.0 + (distance - 1) * 6.50;
    } else if (distance <= 20) {
      fare = 35.0 + (9 * 6.50) + (distance - 10) * 7.00;
    } else if (distance <= 40) {
      fare = 35.0 + (9 * 6.50) + (10 * 7.00) + (distance - 20) * 8.00;
    } else if (distance <= 60) {
      fare = 35.0 + (9 * 6.50) + (10 * 7.00) + (20 * 8.00) + (distance - 40) * 8.50;
    } else if (distance <= 80) {
      fare = 35.0 + (9 * 6.50) + (10 * 7.00) + (20 * 8.00) + (20 * 8.50) + (distance - 60) * 9.00;
    } else {
      fare = 35.0 + (9 * 6.50) + (10 * 7.00) + (20 * 8.00) + (20 * 8.50) + (20 * 9.00) + (distance - 80) * 10.50;
    }

    // คิดค่าเวลารถติด (นาทีละ 3 บาท)
    fare += (traffic * 3.00);

    setState(() {
      _totalFare = fare;
    });
  }

  void _resetFields() {
    setState(() {
      _distanceController.clear();
      _trafficController.clear();
      _totalFare = 0.0;
      _showErrorBanner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF7FC),
      appBar: AppBar(
        title: const Text(
          'Taxi Fare',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: const Color(0xFFF7B500),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: _showErrorBanner
          ? Container(
              height: 48,
              color: const Color(0xFFEB3B30),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.yellow, size: 22),
                  SizedBox(width: 8),
                  Text(
                    'กรุณากรอกข้อมูลให้ครบถ้วน',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            const Icon(
              Icons.local_taxi_rounded,
              size: 110,
              color: Color(0xFFF7B500),
            ),
            const SizedBox(height: 12),

            const Text(
              'คำนวณค่าโดยสารแท็กซี่',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),

            // ช่องกรอกระยะทาง
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: const TextSpan(
                  text: 'ระยะทาง (กิโลเมตร) ',
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                  children: [
                    TextSpan(text: '🛣️'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _distanceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'กรุณากรอกระยะทาง',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 14),

            // ช่องกรอกเวลารถติด
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: const TextSpan(
                  text: 'เวลารถติด (นาที) ',
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                  children: [
                    TextSpan(text: '⏰'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _trafficController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'กรุณากรอกเวลารถติด',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 18),

            // ปุ่มคำนวณค่าโดยสาร
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF7B500),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _calculateFare,
                child: const Text('คำนวณค่าโดยสาร', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),

            // ปุ่มยกเลิก
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E9195),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _resetFields,
                child: const Text('ยกเลิก', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 18),

            // กล่องแสดงผลลัพธ์สีเหลืองอ่อน
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE8A9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    'ค่าโดยสารแท็กซี่',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _totalFare.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEB3B30),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'บาท',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}