import 'package:flutter/material.dart';

campoTexto(texto, controller, icone, {senha}) {
  return TextField(
    controller: controller,
    obscureText: senha != null ? true : false,
    style: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w300,
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(icone, color: Colors.black),
      prefixIconColor: Colors.black,
      labelText: texto,
      labelStyle: const TextStyle(color: Colors.black),
      // border: const OutlineInputBorder(),
      border: const UnderlineInputBorder(),
      focusColor: Colors.black,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 0.0,
        ),
      ),
    ),
  );
}
