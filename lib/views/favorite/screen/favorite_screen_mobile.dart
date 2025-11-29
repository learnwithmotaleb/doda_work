part of 'favorite_screen.dart';

class FavoriteScreenMobile extends GetView<FavoriteController> {
  const FavoriteScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Favorite'),
      body: SafeArea(
        child: Obx(() {
          // Loading
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // Empty state
          if (controller.favoriteList.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => controller.fetchFavoriteCategories(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 250),
                  Center(child: Text("No favorites found")),
                ],
              ),
            );
          }

          // ListView with RefreshIndicator
          return RefreshIndicator(
            onRefresh: () => controller.fetchFavoriteCategories(),
            child: ListView.separated(
              padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.favoriteList.length,
              separatorBuilder: (_, __) => DividerWidget(),
              itemBuilder: (context, index) {
                final item = controller.favoriteList[index];

                return ListTile(
                  trailing: Icon(Icons.favorite, color: CustomColors.primary),
                  contentPadding: EdgeInsets.zero,
                  title: TextWidget(
                    item.name,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.primary,
                  ),
                  subtitle: TextWidget(
                    item.icon,  // you can show another field here
                    fontSize: Dimensions.titleSmall,
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
