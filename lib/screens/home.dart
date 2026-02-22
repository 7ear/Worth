import '../imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;
  
  @override
  void initState() {
    super.initState();
    DataManager.dataNotifier.addListener(updateUI);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  void updateUI() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: _scrollOffset > 10 ? 0 : 0,
        backgroundColor: scaffoldColor,
        title: Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'W',
                  style: GoogleFonts.racingSansOne(
                    fontSize: 38,
                    fontWeight: FontWeight.w500,
                    color: mainOrangeColor
                  ),
                ),
                TextSpan(
                  text: "orth",
                  style: GoogleFonts.racingSansOne(
                    fontSize: 38,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(248, 248, 255, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ValueListenableBuilder<List<ChartData>>(
            valueListenable: DataManager.dataNotifier,
            builder: (_, data, __) {
              final totalValue = data.fold<double>(
                0, 
                (sum, item) => sum + item.value
              );
              final colorPalette = ColorsForList.palette;
              return Stack(
                children: [
                  ScrollConfiguration(
                    behavior: _NoGlowScrollBehavior(),
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 300,
                          collapsedHeight: 0,
                          toolbarHeight: 0,
                          floating: true,
                          snap: true,
                          pinned: false,
                          stretch: true,
                          backgroundColor: scaffoldColor,
                          flexibleSpace: FlexibleSpaceBar(
                            background: DoughnutChart(),
                            collapseMode: CollapseMode.pin,
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.only(
                            left: 20, 
                            right: 20, 
                            bottom: 100, 
                            top: _scrollOffset > 280 ? 22 : 22,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((context, index) {
                              if (index < 0 || index >= data.length) return const SizedBox.shrink();
                                
                              final item = data[index];
                              final colorIndex = index % colorPalette.length;
                              
                              return TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: 1),
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeOutCubic,
                                builder: (context, value, child) {
                                  return Opacity(
                                    opacity: value,
                                    child: Transform.translate(
                                      offset: Offset(0, 20 * (1 - value)),
                                      child: child,
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color.fromARGB(255, 40, 40, 40), width: 1.3),
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: const Color.fromRGBO(20, 20, 20, 1),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12.0),
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditAsset(
                                              index: index,
                                              item: item,
                                              onSave: (newItem) => DataManager.updateItem(index, newItem),
                                              onDelete: () => DataManager.deleteItem(index)
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                          right: 10,
                                          bottom: 8,
                                          left: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 17,
                                              height: 17,
                                              margin: const EdgeInsets.only(right: 16),
                                              decoration: BoxDecoration(
                                                color: colorPalette[colorIndex],
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    item.category,
                                                    style: GoogleFonts.inter(
                                                      textStyle: theme.textTheme.displayLarge
                                                    )
                                                  ),
                                                  Text(
                                                    '${
                                                    totalValue > 0 
                                                      ? (item.value / totalValue * 100).toStringAsFixed(1) 
                                                      : "0.0"}%',
                                                    style: GoogleFonts.inter(
                                                      textStyle: theme.textTheme.titleSmall
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ),
                                            Text(
                                              '\$${(item.value.round())}',
                                              style: GoogleFonts.arimo(
                                                textStyle: theme.textTheme.displayMedium
                                              )
                                            ),
                                            const SizedBox(width: 5),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              size: 24,
                                              color: Color.fromARGB(130, 255, 255, 255),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: data.length
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    top: _scrollOffset > 10 ? 12 : -50,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: mainOrangeColor,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Pull down to show chart',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15 + MediaQuery.of(context).padding.bottom,
                    left: 20,
                    right: 20,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      transform: Matrix4.translationValues(
                        0,
                        _scrollOffset > 10 ? 0 : 0,
                        0,
                      ),
                      child: AddButton(isItNavigator: true),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    DataManager.dataNotifier.removeListener(updateUI);
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}

class _NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}