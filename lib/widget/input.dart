import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextInputType textInputType;
  final TextEditingController controller;
  final String vitoreJetaLekhaThakbe;
  const InputField({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.vitoreJetaLekhaThakbe,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: vitoreJetaLekhaThakbe,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.orange),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.brown),
        ),
      ),
    );
  }
}
