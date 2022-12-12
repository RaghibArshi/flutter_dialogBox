import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_view_flutter/saveData_Screen.dart';
import 'package:web_view_flutter/webview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String errorMsg = '';
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            dialogPopUp('Enter Your Value');
          },
          child: const Text('Click to Open Dialog'),
        ),
      ),
    );
  }

  dialogPopUp(String textMsg){
    errorMsg = '';
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setStateForDialog) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  scrollable: true,
                  title: Text(textMsg, textAlign: TextAlign.center,),
                  // titlePadding: EdgeInsets.only(top: 10, left: 10, bottom: 20),
                  contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  content: Column(
                    children: [
                      //Text Field
                      SizedBox(
                        height: 45.0,
                        child: TextField(
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                          // restrict user to type only numbers inside the textfield

                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],

                          // restrict user to paste anything inside the textfield
                          enableInteractiveSelection: false,
                          controller: textFieldController,
                          decoration: InputDecoration(
                            counterText: '',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                        ),
                      ),
                      //Error Text
                      Visibility(
                          visible: errorMsg == ''?false:true,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(errorMsg, style: TextStyle(color: Colors.red),),
                            ],
                          )
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      //Save data button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width/1.6,
                            50,
                          ),
                        ),
                        onPressed: (){
                          setStateForDialog((){
                            if (textFieldController.text == "") {
                              errorMsg =
                              'Please a valid number !';
                            } else if (textFieldController.text == '0' || textFieldController.text == '00'){
                              errorMsg = 'You cannot use 0 !';
                            }
                            else{
                              errorMsg = '';
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return SaveDataScreen(dialogData: textFieldController.text,);
                              }));
                            }
                          });
                        },
                        child: Text('Save Data'),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      //Cancle button
                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                            },
                          child: Text('Cancle'))
                    ],
                  ),
                );
              }
          );
        }
    );
  }
}
