import 'package:crud_sqlite_joes/model/user.dart';
import 'package:crud_sqlite_joes/services/user_service.dart';
import 'package:flutter/material.dart';
class EditUser extends StatefulWidget {
  final User user;
  const EditUser({Key? key,required this.user}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var userNameController = TextEditingController();
  var userContactController = TextEditingController();
  
  bool validateName = false;
  bool validateContact = false;
  bool validateDescription = false;
  var userService=UserService();

  @override
  void initState() {
    setState(() {
      userNameController.text=widget.user.name??'';
      userContactController.text=widget.user.contact??'';
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit New User',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                    validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: userContactController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
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
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          userNameController.text.isEmpty
                              ? validateName = true
                              : validateName = false;
                          userContactController.text.isEmpty
                              ? validateContact = true
                              : validateContact = false;
                        });
                        if (validateName == false &&
                            validateContact == false &&
                            validateDescription == false) {
                          // print("Good Data Can Save");
                          var _user = User();
                          _user.id=widget.user.id;
                          _user.name = userNameController.text;
                          _user.contact = userContactController.text;
                          var result=await userService.UpdateUser(_user);
                          Navigator.pop(context,result);
                        }
                      },
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
