import 'package:flutter/material.dart';

class DeblureResultPage extends StatefulWidget {
  final String deblurredImagePath;
  const DeblureResultPage({Key? key, required this.deblurredImagePath}) : super(key: key);

  @override
  _DeblureResultPageState createState() => _DeblureResultPageState();
}

class _DeblureResultPageState extends State<DeblureResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deblurred Image'),
      ),
      body: Center(
        child: Image.network(widget.deblurredImagePath), // Updated to use the widget property
      ),
    );
  }
}
