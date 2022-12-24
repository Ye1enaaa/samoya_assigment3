import 'package:crud_sqlite_joes/model/user.dart';
import 'package:crud_sqlite_joes/services/user_service.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var userNameController = TextEditingController();
  var userContactController = TextEditingController();
  var userDescriptionController = TextEditingController();
  bool validateName = false;
  bool validateContact = false;
  bool validateDescription = false;
  var userService=UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: ListView(
            children: [
              TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                        validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                  controller: userContactController,
                  decoration: InputDecoration(
                    hintText: 'Enter Contact',
                    labelText: 'Contact',
                    errorText: validateContact
                        ? 'Contact Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        if (validateName == false &&
                            validateContact == false &&
                            validateDescription == false) {
                          var _user = User();
                          _user.name = userNameController.text;
                          _user.contact = userContactController.text;
                          var result=await userService.SaveUser(_user);
                         Navigator.pop(context,result);
                        }
                      },
                      child: const Text('SUBMIT')),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              )
    );
  }
}
