import 'package:campus_cart/controllers/store_logo_controller.dart';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:campus_cart/routes/visuals/icons.dart';

class SetUpStore extends StatefulWidget {
  const SetUpStore({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SetUpStoreState createState() => _SetUpStoreState();
}

class _SetUpStoreState extends State<SetUpStore> {
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _storeAddressController = TextEditingController();
  final TextEditingController _storeCityController = TextEditingController();
  final TextEditingController _storeDescriptionController =
      TextEditingController();
  final UserStateController userStateController =
      Get.find<UserStateController>();
  final StoreLogoStateController storeLogoStateController =
      Get.find<StoreLogoStateController>();

  XFile? _storeLogo;
  String? downloadedImageUrl;

  Future<void> _pickStoreLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedLogo =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _storeLogo = pickedLogo;
    });
  }

  Future<void> _initializeDownloadedImage() async {
    try {
      await storeLogoStateController
          .retrieveImage(userStateController.loggedInuser.uid);
      setState(() {
        downloadedImageUrl = storeLogoStateController.imageUrl.value;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: const Color.fromARGB(255, 116, 255, 95),
        ));
      }
    }
  }

  void _setUpStore() async {
    try {
      await storeLogoStateController.uploadImage(
          _storeLogo, userStateController.loggedInuser.uid);
      await userStateController.updateCampusUserData(
          _storeNameController.text,
          _storeAddressController.text,
          _storeCityController.text,
          _storeDescriptionController.text,
          userStateController.loggedInuser.uid);
      // update campus user state
      userStateController.campusCartUser["isVendor"] = true;
      userStateController.campusCartUser["vendorName"] =
          _storeNameController.text;
      userStateController.campusCartUser["address"] =
          _storeAddressController.text;
      userStateController.campusCartUser["city"] = _storeCityController.text;
      userStateController.campusCartUser["storeDetails"] =
          _storeDescriptionController.text;
      userStateController.campusCartUser.refresh();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("New vendor '${_storeNameController.text}' created."),
          backgroundColor: const Color.fromARGB(255, 116, 255, 95),
        ));
      }

      // delay for 3 secs
      Future.delayed(Duration(seconds: 2));

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/store_profile');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: const Color.fromARGB(255, 255, 55, 55),
        ));
      }
    }
  }

  void _initStore() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _initializeDownloadedImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xfff6c85b),
              Color(0xffffffff),
            ],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _initStore,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/images/lepra.png',
                      width: 55,
                      height: 55,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Create your Store",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DM Sans',
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Create an online store to complement your physical cart, reach a wider audience, and boost your sales.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff606060),
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Enter Vendor Name',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff606060),
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _storeNameController,
                  decoration: InputDecoration(
                    hintText: "e.g Lore's Kitchen",
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 20.0),
                    hintStyle: const TextStyle(
                      color: Color(0xFF909090),
                      fontSize: 14,
                      fontFamily: "DM Sans",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Enter Address',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff606060),
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _storeAddressController,
                  decoration: InputDecoration(
                    hintText: "e.g No 14, Bwissa Passage",
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 20.0),
                    hintStyle: const TextStyle(
                      color: Color(0xFF909090),
                      fontSize: 14,
                      fontFamily: "DM Sans",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Enter City',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff606060),
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _storeCityController,
                  decoration: InputDecoration(
                    hintText: "e.g Kigali",
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 20.0),
                    hintStyle: const TextStyle(
                      color: Color(0xFF909090),
                      fontSize: 14,
                      fontFamily: "DM Sans",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Enter Store Details',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff606060),
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _storeDescriptionController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Tell about what you are selling",
                    filled: true,
                    fillColor: const Color(0xffE5E5E5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    hintStyle: const TextStyle(
                      color: Color(0xFF909090),
                      fontSize: 14,
                      fontFamily: "DM Sans",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Choose Store Logo',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff606060),
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickStoreLogo,
                  child: Container(
                    height: 124,
                    width: 139,
                    decoration: BoxDecoration(
                      color: const Color(0xffE5E5E5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xffffffff),
                            child:
                                _storeLogo == null && downloadedImageUrl == null
                                    ? const Icon(
                                        Icon2.gallery,
                                        color: Color(0xff606060),
                                        size: 30,
                                      )
                                    : ClipOval(
                                        child: _storeLogo != null
                                            ? Image.file(
                                                File(_storeLogo!.path),
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                storeLogoStateController
                                                    .imageUrl.value,
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _storeLogo == null && downloadedImageUrl == null
                                ? 'Add Store Logo'
                                : 'Change Store Logo',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff606060),
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _setUpStore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff202020),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  child: const Text(
                    'Set Up Store',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
