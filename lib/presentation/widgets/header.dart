import 'package:flutter/material.dart';
import '../widgets/fotoUsuario.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String? subtitle;
  final double titleSize;

  HeaderWidget({required this.title, required this.imageUrl, this.subtitle, this.titleSize = 28});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700],
                  ),
                ),
              Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                  color: Colors.purple,
                ),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
        Fotousuario(imageUrl: imageUrl),
      ],
    );
  }
}
