import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_google_form/launch_form/launch_form_view.dart';
import 'package:flutter_google_form/model/create_form_model.dart';
import 'package:flutter_google_form/utils/constants.dart';
import 'package:flutter_google_form/utils/screen_argument.dart';
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

  // formKey
  final formKeyTitle = GlobalKey<FormState>();
  final formKeyTitleDescription = GlobalKey<FormState>();

  // focusNode
  final FocusNode focusNodeTitle = FocusNode();
  final FocusNode focusNodeTitleDescription = FocusNode();

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
              option: [
                ListOptionModel(option: 'Option 1', idOption: 'Option 1')
              ]));
        });
        break;
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        Fluttertoast.showToast(
            msg: 'Functions are not yet developed', gravity: ToastGravity.TOP);
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
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border:
              const Border(top: BorderSide(width: 5, color: Colors.purple))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            key: formKeyTitle,
            controller: titleController,
            focusNode: focusNodeTitle,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            decoration: const InputDecoration(
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                border: InputBorder.none,
                labelText: 'Untitled Form',
                contentPadding: EdgeInsets.zero),
            onFieldSubmitted: (value) {
              setState(() {
                titleController.text = value;
              });
              focusNodeTitleDescription.requestFocus();
            },
            onChanged: (value) {
              setState(() {
                titleController.text = value;
              });
            },
          ),
          TextFormField(
            key: formKeyTitleDescription,
            controller: titleDescriptionController,
            focusNode: focusNodeTitleDescription,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            decoration: const InputDecoration(
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                border: InputBorder.none,
                labelText: 'Form Description',
                contentPadding: EdgeInsets.zero),
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
          choiceOption.add(Constants.multipleChoice);

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
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: 'Functions are not yet developed',
                              gravity: ToastGravity.TOP);
                        },
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
                  items: <String>[Constants.multipleChoice, Constants.paragraph]
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Icon(
                            value == Constants.paragraph
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
                      if (choiceOption[index] == Constants.paragraph) {
                        createForm[index].isParagraph = true;
                        createForm[index].option?.add(ListOptionModel(
                            option: 'Option', isParagraph: true));
                      } else {
                        createForm[index].isParagraph = false;
                        createForm[index].option?.add(ListOptionModel(
                            option: 'Option', idOption: 'Option 1'));
                      }
                      createForm[index]
                          .option!
                          .sort((a, b) => a.idOption!.compareTo(b.idOption!));
                    });
                  },
                ),
                const SizedBox(height: 10),
                choiceOption[index] == Constants.paragraph
                    ? TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          fillColor: Colors.purple[50],
                          border: InputBorder.none,
                          focusedBorder: const UnderlineInputBorder(),
                          labelText: 'Long-answer text',
                        ),
                        onFieldSubmitted: (value) {
                          setState(() {
                            createForm[index].option?[0].option = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            createForm[index].option?[0].option = value;
                          });
                        },
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
                                            createForm[index].option!.sort(
                                                (a, b) => a.idOption!
                                                    .compareTo(b.idOption!));
                                            if (data.isOther!) {
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
                                          if (createForm[index].option!.length >
                                              5) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Option length cannot be greater than 5',
                                                gravity: ToastGravity.TOP);
                                          } else {
                                            createForm[index].option?.add(
                                                ListOptionModel(
                                                    option: 'Option',
                                                    idOption:
                                                        'Option ${createForm[index].option!.length + 1}'));
                                            createForm[index].option!.sort(
                                                (a, b) => a.idOption!
                                                    .compareTo(b.idOption!));
                                          }
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
                                                          option: 'Option',
                                                          idOption:
                                                              'Option ${createForm[index].option!.length + 1}'));
                                                  createForm[index]
                                                      .option!
                                                      .sort((a, b) =>
                                                          a.idOption!.compareTo(
                                                              b.idOption!));
                                                }); // will not work here
                                              }),
                                        TextSpan(
                                            text: ' or ',
                                            style: TextStyle(fontSize: 16)),
                                        TextSpan(
                                            text: 'Add "Other"',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                setState(() {
                                                  createForm[index].option?.add(
                                                      ListOptionModel(
                                                          option: 'Other',
                                                          isOther: true,
                                                          idOption: 'Other'));
                                                  createForm[index]
                                                      .option!
                                                      .sort((a, b) =>
                                                          a.idOption!.compareTo(
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
                      ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              createForm.removeAt(index);
                            });
                          },
                          child: const Icon(Icons.delete,
                              color: Colors.grey, size: 25)),
                      const SizedBox(width: 8),
                      Container(
                        width: 0.5,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Required',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 33,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Switch(
                            value: createForm[index].isRequired!,
                            activeColor: Colors.purple,
                            onChanged: (bool value) {
                              print('value: $value');
                              setState(() {
                                createForm[index].isRequired = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
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
          TextButton(
              onPressed: () {
                setState(() {
                  createForm.clear();
                  isOtherOption.clear();
                  titleController.clear();
                  titleDescriptionController.clear();
                });
              },
              child: const Text(
                'Clear Form',
                style: TextStyle(fontSize: 16, color: Colors.purple),
              )),
          SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                bool validate = validateData();
                if (validate) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => LaunchFormView(
                                data: ScreenArguments(
                                    arg1: createForm,
                                    arg2: titleController.text,
                                    arg3: titleDescriptionController.text),
                              )));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text('Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  bool validateData() {
    if (titleController.text.isEmpty) {
      Scrollable.ensureVisible(formKeyTitle.currentContext!);
      Fluttertoast.showToast(
          msg: 'Untitled Form can not empty', gravity: ToastGravity.TOP);
      focusNodeTitle.requestFocus();
      return false;
    }

    if (titleDescriptionController.text.isEmpty) {
      Scrollable.ensureVisible(formKeyTitleDescription.currentContext!);
      Fluttertoast.showToast(
          msg: 'Form Description can not empty', gravity: ToastGravity.TOP);
      focusNodeTitleDescription.requestFocus();
      return false;
    }

    return true;
  }
}
