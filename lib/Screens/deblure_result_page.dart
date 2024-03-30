import 'package:flutter/material.dart';

class DeblureResultPage extends StatefulWidget {
  final String deblurredImagePath;
  const DeblureResultPage({super.key, required this.deblurredImagePath});


  @override
  State<DeblureResultPage> createState() => _DeblureResultPageState();
}

class _DeblureResultPageState extends State<DeblureResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deblurred Image'),
      ),
      body: Center(
        //child: Image.network(deblurredImagePath), // Display deblurred image
      ),
    );
  }
}
