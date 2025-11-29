part of 'update_screen.dart';

class UpdateScreenMobile extends GetView<UpdateController> {
  const UpdateScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Update Profile'),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Space.height.betweenInputBox,

            Center(
              child: Stack(
                children: [
                  Obx(
                        () => ClipOval(
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: controller.selectedImg.value != null
                            ? Image.file(
                          controller.selectedImg.value!,
                          fit: BoxFit.cover,
                        )
                            : CachedNetworkImage(
                          imageUrl: 'https://picsum.photos/200/300?random=${DateTime.now().millisecondsSinceEpoch}',
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey.shade300),
                          errorWidget: (context, url, error) => Icon(
                            Icons.person,
                            size: 110,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 4,
                    right: 0,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.pickImg();
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.paddingSize * 0.1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: CustomColors.whiteColor.withAlpha(88),
                          ),
                          color: CustomColors.primary,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: CustomColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Space.height.betweenInputBox,

            PrimaryInputFieldWidget(
              label: "Name",
              controller: controller.nameController,
              focusNode: controller.nameFocus,
              hintText: "Enter your name",
            ),
            Space.height.betweenInputBox,
            TextWidget(
              padding: EdgeInsetsGeometry.only(
                bottom: Dimensions.spaceBetweenInputTitleAndBox * 0.6,
              ),
              "Select Location",
              maxLines: 2,
              textOverflow: TextOverflow.ellipsis,
              fontSize: Dimensions.titleMedium * 0.8,
              fontWeight: FontWeight.w500,
              color: CustomColors.blackColor,
            ),

            Obx(() {
              final isPick = controller.selectedAddress.isNotEmpty;
              return GestureDetector(
                onTap: () {
                  _openPicker(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                    border: Border.all(
                      color: isPick
                          ? CustomColors.primary
                          : CustomColors.disableColor,
                      width: 1.4,
                    ),
                  ),
                  child: Text(
                    isPick
                        ? controller.selectedAddress.value
                        : "Pick Service Address",
                    style: TextStyle(
                      fontSize: Dimensions.titleSmall,
                      fontWeight: FontWeight.w500,
                      color: isPick
                          ? CustomColors.blackColor
                          : CustomColors.blackColor.withAlpha(888),
                    ),
                  ),
                ),
              );
            }),
            Space.height.betweenInputBox,

            Space.height.betweenInputBox,
            Obx(
              () => PrimaryButtonWidget(
                title: 'Update',
                isLoading: controller.isLoading.value,
                onPressed: () => controller.userUpdateProfile(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openPicker(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapLocationPicker(
          config: MapLocationPickerConfig(
            apiKey: "AIzaSyC_qKHmzl-HHB9hr8-fWGmhETSVR2H0894",
            onNext: (result) {
              if (result != null &&
                  result.geometry?.location.lat != null &&
                  result.geometry?.location.lat != null) {
                controller.selectedLatLng.value = LatLng(
                  result.geometry!.location.lat,
                  result.geometry!.location.lng,
                );

                controller.selectedAddress.value =
                    result.formattedAddress ?? "";
              }
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          geoCodingConfig: GeoCodingConfig(
            apiKey: "AIzaSyC_qKHmzl-HHB9hr8-fWGmhETSVR2H0894",
          ),
          searchConfig: SearchConfig(
            apiKey: "AIzaSyC_qKHmzl-HHB9hr8-fWGmhETSVR2H0894",
          ),
        ),
      ),
    );
  }
}
