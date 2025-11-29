part of '../screen/home_screen.dart';






class CustomStatusCardWidget extends StatelessWidget {
  final int index;
  final bool isUser;
  final String requestId;
  final String category;
  final String subCategory;
  final String address;
  final String? image;
  final String status;
  final void Function()? onTap;
  final VoidCallback? onTapAccept;
  final VoidCallback? onTapDecline;
  final VoidCallback? onTapComplete;

  const CustomStatusCardWidget({
    super.key,
    required this.index,
    required this.isUser,
    required this.requestId,
    required this.category,
    required this.subCategory,
    this.image,
    required this.address,
    required this.status,
    this.onTap,
    this.onTapAccept,
    this.onTapDecline,
    this.onTapComplete,
  });

  @override
  Widget build(BuildContext context) {
    final url = "${ApiEndPoints.baseUrl}$image";
    final fixedUrl = url.replaceAll(r'\', '/');


    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8, right: 8, left: 8, top: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withAlpha(555)),
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 0.8),
                bottomLeft: Radius.circular(Dimensions.radius * 0.8),
              ),
              child: CachedNetworkImage(
                imageUrl: image != null
                    ? fixedUrl
                    : 'https://picsum.photos/200/300?random=${index + 1}',
                width: 100,
                height: 120,
                placeholder: (context, url) => Container(color: Colors.grey.shade300),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade400,
                  child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
                ),
                fit: BoxFit.cover,
              ),
            ),
            Space.width.v5,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextWidget(
                            'Request ID: ',
                            color: CustomColors.primary,
                            fontSize: Dimensions.titleSmall * 0.85,
                          ),
                          TextWidget(requestId, maxLines: 1, fontSize: Dimensions.titleSmall * 0.9),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: CustomColors.primary,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radius * 0.4),
                            bottomRight: Radius.circular(Dimensions.radius * 0.4),
                            bottomLeft: Radius.circular(Dimensions.radius * 0.4),
                          ),
                        ),
                        child: TextWidget(
                          status,
                          fontSize: 12,
                          color: CustomColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  TextWidget(
                    'Category: $category',
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.titleSmall * 0.9,
                  ),
                  TextWidget(
                    'Sub Category: $subCategory',
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.titleSmall * 0.9,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: CustomColors.primary,
                        size: Dimensions.iconSizeSmall * 1.6,
                      ),
                      Flexible(
                        child: TextWidget(
                          address + address + address,
                          color: CustomColors.primary,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: Dimensions.titleSmall * 0.9,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if(!isUser && status == "PENDING")
                    Row(
                      spacing: 12,
                      children: [
                        GestureDetector(
                          onTap: () => _showConfirmationDialog(
                            title: "Accept Request",
                            description: "Are you sure you want to accept this request?",
                            confirmText: "Yes, Accept",
                            onConfirm: () {
                              Get.back();
                              print("object");
                              onTapAccept?.call();
                            },
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: CustomColors.primary),
                              color: CustomColors.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text("Accept", style: TextStyle(color: CustomColors.whiteColor),),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showConfirmationDialog(
                            title: "Decline Request",
                            description: "Are you sure you want to decline this request?",
                            confirmText: "Yes, Decline",
                            onConfirm: () {
                              Get.back();
                              onTapDecline?.call();
                            },
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: CustomColors.primary),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text("Decline"),
                          ),
                        ),
                      ],
                    ),
                  if(!isUser && status == "ONGOING")
                    Row(
                      spacing: 12,
                      children: [
                        GestureDetector(
                          onTap: () => _showConfirmationDialog(
                            title: "Complete Request",
                            description: "Are you sure you want to complete this request?",
                            confirmText: "Yes, Complete",
                            onConfirm: () {
                              Get.back();
                              print("object");
                              onTapComplete?.call();
                            },
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: CustomColors.primary),
                              color: CustomColors.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text("Complete", style: TextStyle(color: CustomColors.whiteColor),),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog({
    required String title,
    required String description,
    required String confirmText,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: Get.width * 0.8,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                TextWidget(
                  description,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onPressed: onConfirm,
                      child: Text(confirmText, style: TextStyle(color: CustomColors.whiteColor),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
