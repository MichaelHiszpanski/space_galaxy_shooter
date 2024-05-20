import 'package:flutter/material.dart';

class CustomFloatingButton extends StatefulWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final String heroTag; // Add a parameter for the hero tag

  const CustomFloatingButton({
    Key? key,
    required this.onPressed,
    required this.buttonName,
    required this.heroTag, // Initialize the hero tag
  }) : super(key: key);

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: widget.heroTag,
      onPressed: widget.onPressed,
      label: Container(
        alignment: Alignment.center,
        height: 300.0,
        width: 300.0,
        child: Text(
          widget.buttonName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      elevation: 10.0,
    );
  }
}
