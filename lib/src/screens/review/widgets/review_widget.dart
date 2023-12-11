import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    Key? key,
    required this.image,
    required this.name,
    required this.onPressed,
  }) : super(key: key);
  final String image;
  final String name;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(360),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(image),
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}
