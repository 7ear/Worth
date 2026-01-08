import '../imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DataManager.dataNotifier.addListener(updateUI);
  }

  void updateUI() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'W',
                  style: GoogleFonts.racingSansOne(
                    textStyle: theme.textTheme.titleLarge, 
                    color: mainOrangeColor
                  ),
                ),
                TextSpan(
                  text: "orth",
                  style: GoogleFonts.racingSansOne(
                    textStyle: theme.textTheme.titleLarge
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
              final colorPalette = ColorsForList.palette;
              return Stack(
                children: [
                  CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 300,
                        collapsedHeight: 0,
                        toolbarHeight: 0,
                        flexibleSpace: DoughnutChart(), // Передаем данные в график
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          left: 20, 
                          right: 20, 
                          bottom: 100, 
                          top: 22
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            if (index < 0 || index >= data.length) return const SizedBox.shrink();
                              
                            final item = data[index];
                            final colorIndex = index % colorPalette.length;
                              
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                tileColor: const Color.fromRGBO(20, 20, 20, 1),
                                leading: Icon(
                                  Icons.circle,
                                  color: colorPalette[colorIndex]
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Color.fromARGB(130, 255, 255, 255)
                                  ),
                                  onPressed: () async {
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
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.category,
                                      style: GoogleFonts.inter(
                                        textStyle: theme.textTheme.displayLarge
                                      )
                                    ),
                                    Text(
                                      '${(item.value * 10).round() / 10}\$',
                                      style: GoogleFonts.arimo(
                                        textStyle: theme.textTheme.displayMedium
                                      )
                                    ),
                                  ],
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
                  AddButton(),
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
    super.dispose();
  }
}