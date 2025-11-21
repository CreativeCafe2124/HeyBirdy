import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/content_item.dart';
import '../../../providers/feed_provider.dart';
import '../../../providers/auth_provider.dart';

import '../../components/hb_button.dart';
import '../../components/hb_input.dart';


class CreateScreen extends ConsumerStatefulWidget {
  const CreateScreen({super.key});

  @override
  ConsumerState<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends ConsumerState<CreateScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String _mediaUrl = '';
  int _currentTypeIndex = 0;
  final List<String> _types = ['Post', 'Media'];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _mediaUrl = image.path;
      });
    }
  }

  void _createPost() {
    final user = ref.read(authProvider);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login first')),
      );
      return;
    }
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    if (title.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill title and description')),
      );
      return;
    }
    final item = ContentItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: desc,
      mediaUrl: _mediaUrl,
      creatorId: user.id,
      views: 0,
      affiliateLink: '',
    );
    ref.read(feedProvider.notifier).add(item);
    context.pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _types.asMap().entries.map((entry) {
                int idx = entry.key;
                String type = entry.value;
                return Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _currentTypeIndex = idx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentTypeIndex == idx ? Theme.of(context).primaryColor : Colors.grey[200],
                      foregroundColor: _currentTypeIndex == idx ? Colors.white : Colors.black,
                    ),
                    child: Text(type),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            HBInput(
              controller: _titleController,
              hint: 'Title',
            ),
            const SizedBox(height: 16),
            HBInput(
              controller: _descController,
              hint: 'Description',
            ),
            const SizedBox(height: 16),
            HBButton(
              label: 'Pick Image',
              variant: HBButtonVariant.outline,
              onPressed: _pickImage,
            ),
            if (_mediaUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('Image selected: $_mediaUrl'),
              ),
            const Spacer(),
            HBButton(
              label: 'Create Post',
              onPressed: _createPost,
            ),
          ],
        ),
      ),
    );
  }
}
