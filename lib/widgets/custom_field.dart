import 'package:digium/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomField extends StatefulWidget {
  const CustomField({
    Key? key,
    required this.label,
    required this.hintText,
    this.errorText,
    this.inputFormatters,
    this.isLoading = false,
    this.isPassword = false,
    required this.controller,
    required this.prefixIcon,
    this.onChanged,
  }) : super(key: key);
  final String hintText;
  final String label;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final bool isLoading;
  final bool isPassword;
  final TextEditingController controller;
  final IconData prefixIcon;
  final Function(String?)? onChanged;

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: medium,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: subtitleColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Row(
              children: [
                Icon(
                  widget.prefixIcon,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    onChanged: widget.onChanged,
                    readOnly: widget.isLoading,
                    obscureText: widget.isPassword,
                    controller: widget.controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration.collapsed(
                      hintText: widget.hintText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          widget.errorText ?? "",
          style: TextStyle(
            color: dangerColor,
          ),
        ),
      ],
    );
  }
}
