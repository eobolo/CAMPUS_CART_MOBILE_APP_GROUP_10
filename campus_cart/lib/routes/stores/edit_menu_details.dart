import 'dart:io';

import 'package:campus_cart/controllers/meal_image_controller.dart';
import 'package:campus_cart/controllers/user_controller.dart';
import 'package:campus_cart/routes/visuals/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final MealImageController mealImageController = Get.find<MealImageController>();

class EditMenuDetailsScreen extends StatefulWidget {
  const EditMenuDetailsScreen({super.key});

  @override
  State<EditMenuDetailsScreen> createState() => _EditMenuDetailsScreen();
}

class _EditMenuDetailsScreen extends State<EditMenuDetailsScreen> {
  final TextEditingController _mealNameController =
      TextEditingController(text: mealImageController.mealName.value);
  final TextEditingController _mealDescriptionController =
      TextEditingController(text: mealImageController.mealDescription.value);
  final TextEditingController _preparationTimeController =
      TextEditingController(
          text: '${mealImageController.preparationTime.value}');
  final TextEditingController _priceController =
      TextEditingController(text: '${mealImageController.price.value}');
  final UserStateController userStateController =
      Get.find<UserStateController>();

  XFile? _mealImage;
  String? downloadedImageUrl;

  Future<void> _pickStoreLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedLogo =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _mealImage = pickedLogo;
    });
  }

  String _selectedCuisine = "Italian";
  String _selectedType = "Appetizer";
  String _selectedDietary = "Vegetarian";

  final List<String> _cuisines = [
    'Italian',
    'Chinese',
    'Mexican',
    'African',
    'Local',
    'International'
  ];
  final List<String> _types = [
    'Appetizer',
    'Main Course',
    'Dessert',
    'Snacks',
    'Drinks',
    'Soups',
    'Salads',
    'Fruits'
  ];
  final List<String> _dietaryOptions = [
    'Vegetarian',
    'Vegan',
    'Gluten-Free',
    'Kosher',
    'Halal',
    'Meat-Eaters'
  ];

  @override
  void dispose() {
    _mealNameController.dispose();
    _mealDescriptionController.dispose();
    _preparationTimeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _editOldMenu() async {
    mealImageController.mealName.value = _mealNameController.text;
    mealImageController.mealDescription.value = _mealDescriptionController.text;
    mealImageController.cuisine.value = _selectedCuisine;
    mealImageController.type.value = _selectedType;
    mealImageController.dietary.value = _selectedDietary;
    mealImageController.preparationTime.value =
        int.parse(_preparationTimeController.text);
    mealImageController.price.value = int.parse(_priceController.text);

    try {
      await mealImageController.editMenuToDb();
      await mealImageController.editUploadImage(
          _mealImage,
          userStateController.loggedInuser.uid,
          mealImageController.editMealId.value);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 116, 255, 121),
          content: Center(
            child: Text(
              "menu edited successfully",
              style: TextStyle(
                color: Color(0xFF202020),
                fontSize: 14,
                fontFamily: "DM Sans",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 255, 63, 49),
          content: Text(
            "menu edition failed: $e",
            style: TextStyle(
              color: Color(0xFF202020),
              fontSize: 14,
              fontFamily: "DM Sans",
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
      }
    }
  }

  void _getAllUserDishes() async {
    try {
      await mealImageController.getAllUserDishes();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(child: Text("All user dishes fetched")),
          backgroundColor: const Color.fromARGB(255, 116, 255, 95),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(child: Text(e.toString())),
          backgroundColor: const Color.fromARGB(255, 255, 55, 55),
        ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllUserDishes();
    setState(() {
      _selectedCuisine = mealImageController.cuisine.value;
      _selectedType = mealImageController.type.value;
      _selectedDietary = mealImageController.dietary.value;
      downloadedImageUrl = mealImageController.imageUrl.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5C147),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Meal Details',
          style: TextStyle(color: Colors.black),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.pop(context),
              color: Colors.black,
              padding: const EdgeInsets.all(10),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create a fresh menu option that will delight your customers.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              const Text(
                'Meal Name',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _mealNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'e.g. Jollof Rice',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Meal Description',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _mealDescriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Tell us more about this meal',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Preparation Time (in minutes)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _preparationTimeController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'e.g. 12',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Price',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'e.g. 50',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Cuisine',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCuisine,
                hint: const Text('Select Cuisine'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: _cuisines.map((cuisine) {
                  return DropdownMenuItem(
                    value: cuisine,
                    child: Text(cuisine),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCuisine = value ?? "";
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Type',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedType,
                hint: const Text('Select Type'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: _types.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value ?? "";
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Dietary Preference',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedDietary,
                hint: const Text('Select Dietary Preference'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: _dietaryOptions.map((dietary) {
                  return DropdownMenuItem(
                    value: dietary,
                    child: Text(dietary),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDietary = value ?? "";
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Meal Image',
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
                              _mealImage == null && downloadedImageUrl == null
                                  ? const Icon(
                                      Icon2.gallery,
                                      color: Color(0xff606060),
                                      size: 30,
                                    )
                                  : ClipOval(
                                      child: _mealImage != null
                                          ? Image.file(
                                              File(_mealImage!.path),
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              downloadedImageUrl!,
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _mealImage == null && downloadedImageUrl == null
                              ? 'Add Meal Image'
                              : 'Change Meal Image',
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
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: _editOldMenu,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minimumSize: const Size(double.infinity, 50.0),
                ),
                child: const Text(
                  'Edit Menu',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
