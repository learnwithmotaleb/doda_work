part of 'all_category_screen.dart';

class AllCategoryScreenMobile extends GetView<AllCategoryController> {
  const AllCategoryScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final categoryController = Get.find<CategoryController>();

    return Scaffold(
      appBar: CommonAppBar(title: 'All Service Category'),
      body: Obx(() {
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

        // Show all categories
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.9,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: categoryController.allCategory.length,
          itemBuilder: (context, index) {
            final category = categoryController.allCategory[index];
            return GestureDetector(
              onTap: () => Get.toNamed(
                  Routes.categoryPreviewScreen,
                  arguments: category.id // use the correct ID field
              ),
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
                          Container(color: Colors.grey.shade300,
                              child: const Icon(Icons.error, color: Colors.red)),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextWidget(
                    textAlign: TextAlign.center,
                    category.name ?? "Unnamed",
                    maxLines: 2,
                    fontSize: Dimensions.titleSmall * 0.8,
                    textOverflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
