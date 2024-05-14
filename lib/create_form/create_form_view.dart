import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_google_form/model/create_form_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateFormView extends StatefulWidget {
  const CreateFormView({super.key});

  @override
  State<CreateFormView> createState() => _CreateFormViewState();
}

class _CreateFormViewState extends State<CreateFormView> {
  List<bool> isOtherOption = [];

  // controller
  final titleController = TextEditingController();
  final titleDescriptionController = TextEditingController();
  final paragraphController = TextEditingController();

  // focus
  final focusOnBackGround = FocusNode();

  // index bottom bar
  int selectIndex = 0;

  // model
  List<CreateFormModel> createForm = [];

  // list option
  List<String> choiceOption = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    titleDescriptionController.dispose();
    paragraphController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
    switch (index) {
      case 0:
        setState(() {
          createForm.add(CreateFormModel(
              question: 'Untitled Question',
              option: [ListOptionModel(option: 'Option 1', idOption: 'Option 1')]));
        });
        break;
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        Fluttertoast.showToast(msg: 'Functions are not yet developed');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(5),
          child: ListView(
            children: [
              titleFormWidget(),
              const SizedBox(height: 10),
              questionWidget(),
              const SizedBox(height: 10),
              submitWidget()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_sharp), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.send_to_mobile_sharp), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.image_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.list_outlined), label: ''),
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
          border:
              const Border(top: BorderSide(width: 5, color: Colors.purple))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextFormField(
              controller: titleController,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
              decoration: const InputDecoration(
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                border: InputBorder.none,
                labelText: 'Untitled Form',
              ),
              onFieldSubmitted: (value) {
                setState(() {
                  titleController.text = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  titleController.text = value;
                });
              },
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: titleDescriptionController,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              decoration: const InputDecoration(
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                border: InputBorder.none,
                labelText: 'Form Descriptio',
              ),
              onFieldSubmitted: (value) {
                setState(() {
                  titleDescriptionController.text = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  titleDescriptionController.text = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget questionWidget() {
    return Visibility(
      visible: createForm.isNotEmpty,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: createForm.length,
        itemBuilder: (context, index) {
          isOtherOption.add(false);
          choiceOption.add('Multiple choice');

          return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.purple[50],
                          border: const UnderlineInputBorder(),
                          labelText: 'Untitled question',
                        ),
                        onFieldSubmitted: (value) {
                          setState(() {
                            createForm[index].question = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            createForm[index].question = value;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                        onDoubleTap: () {},
                        onTap: () {},
                        child: const Icon(
                          Icons.image_outlined,
                          size: 25,
                        )),
                  ],
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  itemHeight: 60,
                  elevation: 0,
                  value: choiceOption[index],
                  items: <String>['Multiple choice', 'Paragraph']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Icon(
                            value == 'Paragraph'
                                ? Icons.menu_outlined
                                : Icons.check_box_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(value)
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      choiceOption[index] = value!;
                      createForm[index].option?.clear();
                      if (choiceOption[index] == 'Paragraph') {
                        createForm[index].option?.add(ListOptionModel(
                            option: 'Option', isParagraph: true));
                      } else {
                        createForm[index]
                            .option
                            ?.add(ListOptionModel(option: 'Option', idOption: 'Option 1'));
                      }
                      createForm[index]
                          .option!
                          .sort((a, b) => a.idOption!.compareTo(b.idOption!));
                    });
                  },
                ),
                const SizedBox(height: 10),
                choiceOption[index] == 'Paragraph'
                    ? TextFormField(
                        controller: paragraphController,
                        decoration: InputDecoration(
                          fillColor: Colors.purple[50],
                          border: InputBorder.none,
                          focusedBorder: const UnderlineInputBorder(),
                          labelText: 'Long-answer text',
                        ),
                        onFieldSubmitted: (value) {},
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: createForm[index].option?.length,
                            itemBuilder: (context, itemIndex) {
                              final indexOption = itemIndex + 1;
                              final data = createForm[index].option?[itemIndex];
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(
                                    Icons.check_box_outlined,
                                    color: Colors.grey,
                                  ),
                                  title: TextFormField(
                                    readOnly: data!.isOther!,
                                    decoration: InputDecoration(
                                      fillColor: Colors.purple[50],
                                      border: InputBorder.none,
                                      focusedBorder:
                                          const UnderlineInputBorder(),
                                      labelText: data.isOther!
                                          ? data.option
                                          : 'Option $indexOption',
                                    ),
                                    onFieldSubmitted: (value) {
                                      setState(() {
                                        data.option = value;
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        data.option = value;
                                      });
                                    },
                                  ),
                                  trailing: Visibility(
                                    visible:
                                        createForm[index].option!.length > 1,
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            createForm[index]
                                                .option!
                                                .removeAt(itemIndex);
                                            createForm[index].option!.sort((a,
                                                    b) =>
                                                a.idOption!.compareTo(b.idOption!));
                                            if(data.isOther!) {
                                              isOtherOption[index] = false;
                                            }
                                          });
                                        },
                                        child: const Icon(
                                          Icons.cancel,
                                          color: Colors.grey,
                                        )),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icons.radio_button_checked,
                                color: Colors.grey,
                              ),
                              title: isOtherOption[index]
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          createForm[index].option?.add(
                                              ListOptionModel(
                                                  option: 'Option', idOption: 'Option ${createForm[index].option!.length + 1}'));
                                          createForm[index].option!.sort((a,
                                                  b) =>
                                              a.idOption!.compareTo(b.idOption!));
                                        });
                                      },
                                      child: Text(
                                        'Add Option',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ))
                                  : SelectableText.rich(
                                      TextSpan(children: [
                                        TextSpan(
                                            text: 'Add Option',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                setState(() {
                                                  createForm[index].option?.add(
                                                      ListOptionModel(
                                                          option: 'Option', idOption: 'Option ${createForm[index].option!.length + 1}'));
                                                  createForm[index]
                                                      .option!
                                                      .sort((a, b) => a.idOption!
                                                          .compareTo(
                                                              b.idOption!));
                                                }); // will not work here
                                              }),
                                        TextSpan(
                                            text: ' or ',
                                            style: TextStyle(fontSize: 16)),
                                        TextSpan(
                                            text: 'Add "Other option"',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                setState(() {
                                                  createForm[index].option?.add(
                                                      ListOptionModel(
                                                          option: 'Other',
                                                          isOther: true, idOption: 'Other'));
                                                  createForm[index]
                                                      .option!
                                                      .sort((a, b) => a.idOption!
                                                          .compareTo(
                                                              b.idOption!));
                                                  isOtherOption[index] =
                                                      !isOtherOption[index];
                                                }); // will not work here
                                              }),
                                      ]),
                                    ),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget submitWidget() {
    return Visibility(
      visible: createForm.isNotEmpty,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: Text('Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                'Clear Form',
                style: TextStyle(fontSize: 16, color: Colors.purple),
              ))
        ],
      ),
    );
  }
}
