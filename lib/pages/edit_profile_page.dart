import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController(text: 'Jovi Daniel Jr.');
  final TextEditingController _usernameController = TextEditingController(text: '@joviedan');
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _bioController = TextEditingController(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.black, size: 28),
            onPressed: () {
              // Save profile changes
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Photo
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/women/68.jpg',
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: _changeProfilePhoto,
              child: Text(
                'Change profile photo',
                style: TextStyle(
                  color: Color(0xFF6C5CE7),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 30),

            // Name Field
            _buildTextField(
              label: 'Name',
              controller: _nameController,
            ),

            SizedBox(height: 20),

            // Username Field
            _buildTextField(
              label: 'Username',
              controller: _usernameController,
            ),

            SizedBox(height: 20),

            // Website Field
            _buildTextField(
              label: 'Website',
              controller: _websiteController,
            ),

            SizedBox(height: 20),

            // Bio Field
            _buildTextField(
              label: 'Bio',
              controller: _bioController,
              maxLines: 3,
            ),

            SizedBox(height: 20),

            // Add Link
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add Link',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
            ),

            SizedBox(height: 30),

            // Action Links
            _buildActionLink(
              'Switch to professional account',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Switch to professional account')),
                );
              },
            ),

            SizedBox(height: 20),

            _buildActionLink(
              'Create avatar',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Create avatar')),
                );
              },
            ),

            SizedBox(height: 20),

            _buildActionLink(
              'Personal information settings',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Personal information settings')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xFF6C5CE7), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildActionLink(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFF6C5CE7),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Future<void> _changeProfilePhoto() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change Profile Photo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.camera_alt, color: Color(0xFF6C5CE7)),
              title: Text('Take Photo'),
              onTap: () async {
                Navigator.pop(context);
                try {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Photo captured: ${image.name}'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error capturing photo')),
                  );
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Color(0xFF6C5CE7)),
              title: Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                try {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Photo selected: ${image.name}'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error selecting photo')),
                  );
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Remove Photo', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Photo removed')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _websiteController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}