import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koperasi/views/component/theme/color.dart';

class FormCom extends StatefulWidget {
  const FormCom({
    Key? key,
    required this.controller,
    required this.label,
    required this.valid,
    required this.icon,
    required this.obscure,
    required this.textCapitalization,
    this.type,
    this.format,
  }) : super(key: key);
  final List<TextInputFormatter>? format;
  final TextInputType? type;
  final TextEditingController controller;
  final String? Function(String?) valid;
  final bool icon, obscure;
  final String label;
  final TextCapitalization textCapitalization;

  @override
  State<FormCom> createState() => _FormComState();
}

class _FormComState extends State<FormCom> {
  bool _passwordVisible = true;
  bool _icon = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: TextFormField(
        onChanged: (e) {
          if (e.isNotEmpty) {
            setState(() {
              _icon = true;
            });
          } else {
            setState(() {
              _icon = false;
            });
          }
        },
        inputFormatters: widget.format,
        keyboardType: widget.type,
        textCapitalization: widget.textCapitalization,
        textAlign: TextAlign.left,
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: grey,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: white),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: white),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: white),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: white),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18.5),
          hintText: widget.label,
          hintStyle: const TextStyle(
            fontSize: 15,
          ),
          isDense: true,
          suffixIcon: widget.icon
              ? _icon
                  ? GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          _passwordVisible = false;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          _passwordVisible = true;
                        });
                      },
                      child: Icon(
                        _passwordVisible ? Icons.visibility_off : Icons.visibility,
                        color: black,
                      ),
                    )
                  : null
              : null,
        ),
        // autovalidateMode: submit ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
        obscureText: widget.obscure ? _passwordVisible : false,
        // onChanged: (e) {
        //   setState(() {
        //     !submit;
        //   });
        // },
        validator: widget.valid,
      ),
    );
  }
}

class FormComDate extends StatefulWidget {
  const FormComDate({
    Key? key,
    required this.controller,
    required this.label,
    required this.onTap,
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  final Function() onTap;

  @override
  State<FormComDate> createState() => _FormComDateState();
}

class _FormComDateState extends State<FormComDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              // onTap: widget.onTap,
              readOnly: true,
              textAlign: TextAlign.left,
              controller: widget.controller,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: widget.onTap,
                  icon: Icon(
                    Icons.calendar_month,
                    color: black,
                  ),
                ),
                fillColor: grey,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: white),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: white),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: white),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18.5),
                hintText: widget.label,
                hintStyle: const TextStyle(
                  fontSize: 15,
                ),
                isDense: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Tanggal lahir tidak boleh kosong';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FormComDropdown extends StatefulWidget {
  const FormComDropdown({
    Key? key,
    required this.label,
    required this.data,
    this.value,
  }) : super(key: key);
  final String label;
  final Function(String?) data;
  final String? value;

  @override
  State<FormComDropdown> createState() => _FormComDropdownState();
}

class _FormComDropdownState extends State<FormComDropdown> {
  String? jenisKelamin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
          borderRadius: BorderRadius.circular(10),
          decoration: InputDecoration(
            fillColor: grey,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: white),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: white),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: white),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: white),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18.5),
            hintText: widget.label,
            hintStyle: const TextStyle(
              fontSize: 15,
            ),
            isDense: true,
          ),
          value: widget.value!.isEmpty ? jenisKelamin : widget.value,
          items: [
            DropdownMenuItem(
              value: "Pria",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Pria"),
                  Icon(Icons.man),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "Wanita",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Wanita"),
                  Icon(Icons.woman),
                ],
              ),
            ),
          ],
          onChanged: widget.data,
          validator: (e) {
            if (e == null) {
              return 'Tanggal lahir tidak boleh kosong';
            }
            return null;
          },
        ),
      ),
    );
  }
}
