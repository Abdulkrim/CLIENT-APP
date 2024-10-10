import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';

import '../../../../../generated/assets.dart';
import '../../../../../main.dart';
import '../../../../../main.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/app_ink_well_widget.dart';
import '../../../../../widgets/container_setting.dart';
import '../../../data/models/entity/suggestion_item_image.dart';
import '../../blocs/products/products_bloc.dart';
class ImageSectionWidget extends StatefulWidget {
    ImageSectionWidget({super.key, required this.logo});
    final String? logo;

  @override
  State<ImageSectionWidget> createState() => _ImageSectionWidgetState();
}

class _ImageSectionWidgetState extends State<ImageSectionWidget> with ImagesConditions {
  SuggestionItemImage? _selectedImageSuggestion;

  XFile selectedImage = XFile('');

  @override
  Widget build(BuildContext context) {
    final imasg = context.read<ProductsBloc>().suggestionItemImages;
    return ContainerSetting(
        blur: 20,
        padding: const EdgeInsets.all(16),
        maxWidth: 470,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Image'),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                      child: AppInkWell(
                        onTap: () async {
                          final result = await pickImageFromGallery();

                          if (result.image != null) {
                            _selectedImageSuggestion = null;
                            setState(() => selectedImage = (result.image!));
                          } else if (result.errorMessage != null) {
                            context.showCustomeAlert(result.errorMessage!);
                          }
                        },
                        child: DottedBorder(
                          // todo: merge with image selection widget
                          borderType: BorderType.RRect,
                          dashPattern: [6, 6],
                          radius: const Radius.circular(10),
                          color: Colors.black,
                          child: DecoratedBox(
                            decoration:
                            BoxDecoration(color: AppColors.gray2, borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SvgPicture.asset(
                                  Assets.iconsUploadImage,
                                  width: 30,
                                  color: AppColors.black,
                                ),
                                const SizedBox(height: 8),
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.black, strokeAlign: 2)),
                                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                                      SvgPicture.asset(
                                        Assets.iconsUploadImage,
                                        width: 10,
                                        color: AppColors.black,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text('Upload Image'),
                                    ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: _selectedImageSuggestion != null
                                    ? NetworkImage(_selectedImageSuggestion!.imageUrl)
                                    : selectedImage.path.isNotEmpty
                                    ? !context.isPhone
                                    ? NetworkImage(selectedImage.path)
                                    : FileImage(File(selectedImage.path))
                                    : widget.logo != null
                                    ? NetworkImage(widget.logo!)
                                    : const AssetImage(Assets.bgPlaceholderImage),
                                fit: BoxFit.cover)),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // if (state is GetItemSuggestionsImageStates && state.isLoading) const LoadingWidget(),
            if (context.read<ProductsBloc>().suggestionItemImages.isNotEmpty)
              Wrap(
                children: context
                    .read<ProductsBloc>()
                    .suggestionItemImages
                    .map(
                      (e) => AppInkWell(
                    onTap: () {
                      selectedImage = XFile('');

                      setState(() => _selectedImageSuggestion = e);
                    },
                    child: Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image:
                            DecorationImage(image: NetworkImage(e.imageUrl), fit: BoxFit.cover))),
                  ),
                )
                    .toList(),
              ),
            const SizedBox(height: 16),
          ],
        ));
  }
}
