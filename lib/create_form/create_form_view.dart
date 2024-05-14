import 'package:flutter/material.dart';

class CreateFormView extends StatefulWidget {
  const CreateFormView({super.key});

  @override
  State<CreateFormView> createState() => _CreateFormViewState();
}

class _CreateFormViewState extends State<CreateFormView> {
  final titleController = TextEditingController();
  final titleDescriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(5),
        child: ListView(
          children: [
            titleFormWidget()
          ],
        ),
      ),
    );
  }

  Widget titleFormWidget() {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: const Border(top: BorderSide(width: 5, color: Colors.purpleAccent))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
          )
        ],
      ),
    );
  }

}
