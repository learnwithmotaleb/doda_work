

import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../core/utils/basic_import.dart';
import '../../../core/utils/extensions.dart';
import '../../../routes/routes.dart';
import '../../category/controller/category_controller.dart';
import '../controller/home_controller.dart';

class CategoryWidgetView extends GetView<HomeController> {
  const CategoryWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final categoryController = Get.find<CategoryController>();

    return Padding(
      padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                'Service Categories',
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.titleMedium,
              ),
              TextWidget(
                'View All',
                onTap: () => Get.toNamed(Routes.allCategoryScreen),
                color: CustomColors.primary,
                fontSize: Dimensions.titleSmall * 0.95,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Space.height.v10,
          Obx(() {
            if (categoryController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (categoryController.filteredCategory.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No categories found.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => categoryController.getCategory(),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Fetch Again"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return SizedBox(
              height: screenWidth * 0.25, // height for horizontal list
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categoryController.allCategory.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final category = categoryController.allCategory[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(Routes.allCategoryScreen),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: category.icon != null
                                ? ApiEndPoints.baseUrl + (category.icon ?? "")
                                : "https://picsum.photos/200/300?random=$index",
                            width: screenWidth * 0.16,
                            height: screenWidth * 0.16,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Container(color: Colors.grey.shade300),
                            errorWidget: (context, url, error) =>
                                Container(color: Colors.grey.shade300, child: const Icon(Icons.error, color: Colors.red)),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextWidget(
                          (category.name != null && category.name!.length > 5)
                              ? '${category.name!.substring(0, 5)}...'
                              : category.name ?? "Unnamed",
                          fontSize: Dimensions.titleSmall * 0.8,
                          fontWeight: FontWeight.w500,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
