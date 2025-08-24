import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// colour palette
Color purpleshade = const Color(0xFF9D6E90);
Color greenshade = const Color(0xFFC7F6B6);
Color redshade = const Color(0xFFF397AB);
Color blueshade = const Color(0xFFADD8E6);
Color pinkshade = const Color(0xFFF936AB);
Color landingfont = const Color(0xFFCDE6E8);
Color landingsubfont = const Color(0xFF90c9cf);
Color bgcolor = const Color(0xFF0F2573);

// space
SizedBox height10 = const SizedBox(height: 10);
SizedBox height20 = const SizedBox(height: 20);
SizedBox height50 = const SizedBox(height: 50);
SizedBox width10 = const SizedBox(width: 10);

OutlineInputBorder textfieldBorderStyle = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.circular(10));

ButtonStyle btnStyle = ButtonStyle(
    minimumSize: const MaterialStatePropertyAll(Size(200, 55)),
    elevation: const MaterialStatePropertyAll(5),
    backgroundColor: MaterialStatePropertyAll(greenshade));

// custom alerts

// SUCCESS
class SuccessAlert extends StatelessWidget {
  final String mssg;
  const SuccessAlert({
    super.key,
    required this.mssg,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: AlertDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: SizedBox(
            height: 100,
            width: 100,
            child: Lottie.asset("assets/files/success.json")),
        content: Center(
            child: Text(
          mssg,
          style: GoogleFonts.caveatBrush(fontSize: 25),
        )),
        actions: [
          MaterialButton(
              color: Colors.green,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK", style: TextStyle(color: Colors.black)))
        ],
      ),
    );
  }
}

// ATTENTION
class AttentionAlert extends StatelessWidget {
  final String mssg;
  const AttentionAlert({super.key, required this.mssg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            "assets/files/attention.json",
            height: 80,
            width: 80,
          ),
          const SizedBox(height: 12),
          Text(
            mssg,
            style: GoogleFonts.caveatBrush(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        Center(
          child: MaterialButton(
            color: Colors.red,
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}

// textfield widget
Widget buildTextField(
    String label, Function(String?) onSave, TextInputType inputType) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      keyboardType: inputType,
      onSaved: onSave,
      validator: (val) => val!.isEmpty ? 'Required' : null,
    ),
  );
}

// dropdown button decoration

InputDecoration dropdownDecoration(String label) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Colors.black),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
  );
}
