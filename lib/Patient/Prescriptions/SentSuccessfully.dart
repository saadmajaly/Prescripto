import 'package:flutter/material.dart';
import 'package:prescripto/Patient/Home/Home.dart';
import 'package:prescripto/Patient/MainScreen.dart';
import 'package:prescripto/Patient/Prescriptions/Prescriptions.dart';

class PrescriptionSentSuccessfully extends StatefulWidget {
  @override
  _PrescriptionSentSuccessfullyState createState() =>
      _PrescriptionSentSuccessfullyState();
}

class _PrescriptionSentSuccessfullyState
    extends State<PrescriptionSentSuccessfully>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Alignment> _prescAlign;
  late final Animation<double> _checkScale;
  late final Animation<double> _headingFade;
  late final Animation<double> _subtextFade;

  bool _showPrescription = true;
  bool _showShop = true;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    )..forward();

    // Move presc up
    _prescAlign = AlignmentTween(
      begin: Alignment(0, 1.2),
      end: Alignment.center,
    ).animate(CurvedAnimation(
      parent: _ctrl,
      curve: Interval(0.0, 0.4, curve: Curves.easeInOut),
    ));


    _checkScale = CurvedAnimation(
      parent: _ctrl,
      curve: Interval(0.4, 0.6, curve: Curves.elasticOut),
    );

    // Fade
    _headingFade = CurvedAnimation(
      parent: _ctrl,
      curve: Interval(0.6, 0.8, curve: Curves.easeIn),
    );

    // Fade
    _subtextFade = CurvedAnimation(
      parent: _ctrl,
      curve: Interval(0.8, 1.0, curve: Curves.easeIn),
    );

    // hide presc and pharmacy
    _ctrl.addListener(() {
      if (_ctrl.value >= 0.4 && _showPrescription) {
        setState(() {
          _showPrescription = false;
          _showShop = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade200, Colors.white],
          ),
        ),
        child: Stack(
          children: [
            if (_showShop)
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.store,
                  size: 80,
                  color: Colors.blue.shade700,
                ),
              ),

            if (_showPrescription)
              AlignTransition(
                alignment: _prescAlign,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.description,
                    size: 40,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),

            Align(
              alignment: Alignment.center,
              child: ScaleTransition(
                scale: _checkScale,
                child: Icon(
                  Icons.check_circle,
                  size: 60,
                  color: Colors.green.shade400,
                ),
              ),
            ),

            Align(
              alignment: Alignment(0, 0.6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _headingFade,
                    child: Text(
                      'Prescription Sent!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  FadeTransition(
                    opacity: _subtextFade,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Your prescription has been successfully sent to the pharmacy.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  FadeTransition(
                    opacity: _subtextFade,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => Prescriptions())),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        padding:
                        EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Back to Home',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
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
