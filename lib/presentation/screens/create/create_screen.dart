import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/content_item.dart';
import '../../../providers/feed_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../core/constants/colors.dart';
import '../../components/hb_app_bar.dart';
import '../../components/hb_tab_bar.dart';

import '../../components/hb_media_upload.dart';
import '../../components/hb_description_input.dart';
import '../../components/hb_pricing_settings.dart';
import '../../components/hb_affiliate_settings.dart';
import '../../components/hb_publishing_options.dart';
import '../../components/hb_content_types.dart';
import '../../components/forms/hb_title_input.dart';

class CreateScreen extends ConsumerStatefulWidget {
  const CreateScreen({super.key});

  @override
  ConsumerState<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends ConsumerState<CreateScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _affiliateController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String _mediaUrl = '';
  int _currentTypeIndex = 0;
  bool _isFreeContent = true;
  bool _enableAffiliate = false;
  bool _isPublishing = false;

  final List<String> _types = ['Post', 'Media', 'Live', 'Course'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titleController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _affiliateController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _mediaUrl = image.path;
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _mediaUrl = video.path;
      });
    }
  }

  void _createPost() async {
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

    if (!_isFreeContent && _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please set a price for paid content')),
      );
      return;
    }

    if (_enableAffiliate && _affiliateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter affiliate link')),
      );
      return;
    }

    setState(() {
      _isPublishing = true;
    });

    try {
      final item = ContentItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: desc,
        mediaUrl: _mediaUrl,
        creatorId: user.id,
        views: 0,
        affiliateLink: _enableAffiliate ? _affiliateController.text : '',
      );

      ref.read(feedProvider.notifier).add(item);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Content published successfully!')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPublishing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: HBAppBar(
        title: 'Create Content',
        onClosePressed: () {
          context.pop();
        },
        onPublishPressed: _isPublishing ? null : _createPost,
        isPublishing: _isPublishing,
      ),
      body: Column(
        children: [
          HBTabBar(
            tabController: _tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBasicContent(),
                _buildAdvancedSettings(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HBContentTypes(
            types: _types,
            currentTypeIndex: _currentTypeIndex,
            onTypeSelected: (index) {
              setState(() {
                _currentTypeIndex = index;
              });
            },
          ),

          const SizedBox(height: 24),

          // Media Upload
          HBMediaUpload(
            mediaUrl: _mediaUrl,
            onPickImage: _pickImage,
            onPickVideo: _pickVideo,
            onClearMedia: () {
              setState(() {
                _mediaUrl = '';
              });
            },
          ),

          const SizedBox(height: 24),

          HBTitleInput(
            controller: _titleController,
          ),

          const SizedBox(height: 24),

          HBDescriptionInput(
            controller: _descController,
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildAdvancedSettings() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pricing Settings
          HBPricingSettings(
            isFreeContent: _isFreeContent,
            onFreeContentChanged: (value) {
              setState(() {
                _isFreeContent = value;
              });
            },
            priceController: _priceController,
          ),

          const SizedBox(height: 24),

          // Affiliate Settings
          HBAffiliateSettings(
            enableAffiliate: _enableAffiliate,
            onEnableAffiliateChanged: (value) {
              setState(() {
                _enableAffiliate = value;
              });
            },
            affiliateController: _affiliateController,
          ),

          const SizedBox(height: 24),

          // Publishing Options
          const HBPublishingOptions(),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
