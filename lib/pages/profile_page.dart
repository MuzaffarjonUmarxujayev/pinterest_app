import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/model_user.dart';
import '../services/auth_service.dart';
import '../services/hive_db_service.dart';
import '../services/util_service.dart';



class ProfilePage extends StatefulWidget {
  final int crossAxisCount;
  const ProfilePage({Key? key, this.crossAxisCount = 2}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  File? file;
  CameraDevice? device;
  final ImagePicker _picker = ImagePicker();
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  List<ModelUser> user = [];
  @override
  void initState() {
    super.initState();
    _userInfo();
  }

  void _userInfo() async {
    isLoading = true;
    setState(() {});

    user = HiveService.readUsers();

    isLoading = false;
    setState(() {});

  }

  void _deleteUser() async {
    isLoading = true;
    setState(() {});
    AuthService.signOutUser(context);
    await HiveService.deleteAllUsers();
  }



  void _getImage(){
    showModalBottomSheet(context: context,
        builder: (context) => SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: _gallery,
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Camera"),
                onTap: _camera,
              ),
            ],
          ),
        )
    );
  }


  void _gallery() async{
    Navigator.of(context).pop();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      file = File(image.path);
    }
    setState(() {});
  }

  void _camera() async {
    Navigator.of(context).pop();
    final XFile? cameraImg = await _picker.pickImage(source: ImageSource.camera);
    if(cameraImg != null){
      file = File(cameraImg.path);
    }
    setState(() {});
  }

  void _clear()async {
    file = null;
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: (){},
              child: const Text("Save",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 30),
              child: IconButton(onPressed: _clear,
                  icon: const Icon(Icons.clear, color: Colors.black,),
                splashRadius: 20,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
                GestureDetector(
                  onTap: _getImage,
                  child:file == null ? Container(
                    alignment:  Alignment.center,
                    height: 200,
                    width: 200,
                    constraints: const BoxConstraints(
                      minWidth: 150,
                      minHeight: 150,
                      maxHeight: 150,
                      maxWidth: 150,
                    ),
                    decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF5946D2),
                        border: Border.all(color: Colors.white),
                    ),
                    child:  Text(
                      Utils.getFirstLetters('Muzaffar'),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 75,
                      ),
                    ),
                  )
                      : Container(
                    // margin: const EdgeInsets.only(left: 70),
                    clipBehavior: Clip.antiAlias,
                    constraints: const BoxConstraints(
                      minWidth: 150,
                      minHeight: 150,
                      maxHeight: 150,
                      maxWidth: 150,
                    ),
                    decoration:  BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/camera.png"),
                      ),
                    ),
                    child: Image.file(
                      file!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const Text('${'Muzaffar'} ${'Umarxojayev'}', style: TextStyle(fontSize: 30, color: Colors.black),),
                // const SizedBox(height: 5,),
              ],
            ),
            Visibility(
                visible: isLoading,
                child:const Center(child: CircularProgressIndicator(),))
          ],
        ),
      ),
    );
  }
}


