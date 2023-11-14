
import 'package:flutter/cupertino.dart';

class Barchoice {
   String label;
  Widget page;
  String imagePath;
  String selectedImagePath;
  double imageWidth;
  double imageHeight;
  ImageProvider<Object> get image => AssetImage(imagePath );
  ImageProvider<Object> get selectedImage => AssetImage(selectedImagePath);
  BottomNavigationBarItem get item => BottomNavigationBarItem(
    icon: Container(
      width: imageWidth,
      height: imageHeight,
      child: Image(image: image),
    ),
    activeIcon: Container(
      width: imageWidth,
      height: imageHeight,
      child: Image(image: selectedImage),
    ),
    label: label,
  );


  Barchoice({
    required this.label,
    required this.imagePath,
    required this.selectedImagePath,
    required this.page,
    this.imageWidth = 30.0,
    this.imageHeight = 30.0,


  });
}