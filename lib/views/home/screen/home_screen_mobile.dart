import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:doda_work/views/home/controller/home_controller.dart';
import 'package:doda_work/views/home/model/home_model.dart';
import 'package:doda_work/views/summary/model/summary_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/basic_import.dart';
import '../widget/category_widget.dart';
import 'home_screen.dart';

class HomeScreenMobile extends GetView<HomeController> {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> statusText = ['Pending', 'Ongoing', 'Completed'];

    return DefaultTabController(
      length: statusText.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.appBarHeight * 1.25),
          child: AppBar(
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: const HomeAppBarWidgetView(),
            actions: [
              GestureDetector(
                onTap: () => Get.toNamed(Routes.notificationScreen),
                child: Container(
                  margin: Dimensions.defaultHorizontalSize.edgeRight,
                  padding: EdgeInsets.all(Dimensions.paddingSize * 0.35),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: CustomColors.primary),
                  ),
                  child: SvgPicture.asset(Assets.icons.group),
                ),
              ),
              Space.width.v10,
            ],
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 12),
                  CategoryWidgetView(),
                  Obx(() => _buildTabBar(controller, statusText)),
                ],
              ),
            ),
          ],
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(statusText.length, (index) {
              final status = statusText[index].toUpperCase();
              return KeepAlivePage(
                child: RefreshIndicator(
                  onRefresh: () async => controller.refreshStatusData(status),
                  child: PagedListView<int, HomeServiceItem>(
                    pagingController: controller.pagingControllers[status]!,
                    builderDelegate: PagedChildBuilderDelegate<HomeServiceItem>(
                      itemBuilder: (context, item, itemIndex) {
                        return CustomStatusCardWidget(
                          index: itemIndex,
                          requestId: item.requestId ?? "",
                          category: item.subcategory ?? "",
                          subCategory: item.serviceCategory?.name ?? "",
                          address: item.address ?? "",
                          image: item.attachments?.firstOrNull,
                          isUser: true,
                          status: status,
                          onTap: () {
                            Get.toNamed(
                              Routes.summaryScreen,
                              arguments: SummaryModel(
                                isUser: true,
                                requestId: item.requestId,
                                categoryIcon: item.serviceCategory?.icon,
                                categoryName: item.serviceCategory?.name,
                                customerPhone: item.customerPhone,
                                customerName: item.customerId?.name,
                                priority: item.priority,
                                address: item.address,
                                subcategory: item.subcategory,
                                description: item.description,
                                attachments: item.attachments,
                              ),
                            );
                          },
                        );
                      },
                      noItemsFoundIndicatorBuilder: (_) => Center(
                        child: Text(
                          "No $status requests found",
                          style: TextStyle(
                            fontSize: Dimensions.titleSmall,
                            color: CustomColors.grayShade,
                          ),
                        ),
                      ),
                      firstPageErrorIndicatorBuilder: (_) => Center(
                        child: Text(
                          "Error loading $status requests",
                          style: TextStyle(
                            fontSize: Dimensions.titleSmall,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      newPageErrorIndicatorBuilder: (_) => Center(
                        child: Text(
                          "Error loading more $status requests",
                          style: TextStyle(
                            fontSize: Dimensions.titleSmall,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(HomeController controller, List<String> statusText) {
    return TabBar(
      tabAlignment: TabAlignment.fill,
      isScrollable: false,
      indicatorColor: Colors.transparent,
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
      enableFeedback: false,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      onTap: (index) => controller.selectedStatus.value = index,
      tabs: List.generate(statusText.length, (index) {
        final isSelected = controller.selectedStatus.value == index;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.defaultHorizontalSize * 0.4),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.widthSize * 1.2,
            vertical: Dimensions.verticalSize * 0.32,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? CustomColors.primary
                : CustomColors.primary.withAlpha(85),
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          ),
          child: Center(
            child: TextWidget(
              statusText[index],
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.titleSmall,
              color: isSelected ? CustomColors.whiteColor : CustomColors.blackColor,
            ),
          ),
        );
      }),
    );
  }
}

/// KeepAlive wrapper to maintain scroll position per tab
class KeepAlivePage extends StatefulWidget {
  final Widget child;
  const KeepAlivePage({required this.child, super.key});

  @override
  State<KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
