import 'package:flutter/material.dart';

class CreateFormView extends StatefulWidget {
  const CreateFormView({super.key});

  @override
  State<CreateFormView> createState() => _CreateFormViewState();
}

class _CreateFormViewState extends State<CreateFormView> {
  // controller
  final titleController = TextEditingController();
  final titleDescriptionController = TextEditingController();

  //index bottom bar
  int selectIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
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
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_sharp),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send_to_mobile_sharp),
              label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.image_outlined),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video_outlined),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_outlined),
              label: ''
          ),
        ],
        currentIndex: selectIndex,
        selectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget titleFormWidget() {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: const Border(top: BorderSide(width: 5, color: Colors.purple))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text('Untitled Form', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text('Form Description', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),),
          )
        ],
      ),
    );
  }

}
