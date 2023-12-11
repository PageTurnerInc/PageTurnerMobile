import 'package:flutter/material.dart';

class StarGenerator extends StatefulWidget {
  final double starsCount;

  const StarGenerator({required this.starsCount, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StarGeneratorState createState() => _StarGeneratorState();
}

class _StarGeneratorState extends State<StarGenerator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        // Menentukan warna bintang berdasarkan rating
        Color starColor = index < widget.starsCount.floor()
            ? Colors.blue
            : Colors.grey;

        return Icon(
          Icons.star,
          color: starColor,
          size: 20,
        );
      }),
    );
  }
}