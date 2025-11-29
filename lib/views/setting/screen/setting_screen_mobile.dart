part of 'setting_screen.dart';

class SettingScreenMobile extends GetView<SettingController> {
  const SettingScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Account Setting'),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Space.height.v10,
            _buildSectionCard(
              Icons.lock,
              'Change Password',
                  () => Get.toNamed(Routes.changePasswordScreen),
              false,
            ),
            _buildSectionCard(
              Icons.person,
              'Delete Account',
                  () => _showDeleteDialog(),
              true,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
        ),
        title: TextWidget(
          'Delete Account',
          fontSize: Dimensions.titleLarge,
          fontWeight: FontWeight.w500,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TextWidget(
                'Are you sure you want to Delete Account?',
              ),
            ],
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.defaultHorizontalSize,
            vertical: Dimensions.heightSize * 0.5),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back(); // Works properly now
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
              ),
            ),
            child: TextWidget('No', color: CustomColors.whiteColor),
          ),
          Obx(
                () => ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () => controller.deleteUserAccount(),
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.whiteColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: CustomColors.rejected),
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
                ),
              ),
              child: controller.isLoading.value
                  ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: CustomColors.primary,
                  strokeWidth: 2,
                ),
              )
                  : TextWidget('Yes', color: CustomColors.rejected),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  _buildSectionCard(
      IconData icon,
      String title,
      void Function()? onTap,
      bool isRed,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: Dimensions.heightSize),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.defaultHorizontalSize,
          vertical: Dimensions.heightSize * 0.8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          border: Border.all(color: Colors.grey.withAlpha(150)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isRed ? CustomColors.rejected : CustomColors.primary,
                  ),
                  SizedBox(width: Dimensions.defaultHorizontalSize * 0.5),
                  Expanded(
                    child: TextWidget(
                      title,
                      fontSize: Dimensions.titleSmall * 1.1,
                      color: isRed
                          ? CustomColors.rejected
                          : CustomColors.blackColor,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isRed ? CustomColors.rejected : CustomColors.primary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
