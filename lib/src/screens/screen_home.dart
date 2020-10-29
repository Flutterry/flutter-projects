import 'package:flutter/material.dart';
import 'package:flutter_projects/src/data/application_data.dart';
import 'package:flutter_projects/src/data/assets.dart';
import 'package:flutter_projects/src/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _icons = <IconData>[
    Icons.account_circle,
    Icons.notifications_none_outlined,
    Icons.calendar_today,
    Icons.home,
  ];
  var _selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: _icons.asMap().keys.map((e) {
            return BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color:
                        _selectedScreen == e ? Colors.grey[200] : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _icons[e],
                    color:
                        e == _selectedScreen ? Colors.blue : Colors.grey[400],
                  ),
                ),
                label: '');
          }).toList(),
          onTap: (index) {
            setState(() {
              _selectedScreen = index;
            });
          },
          selectedItemColor: Colors.transparent,
          unselectedItemColor: Colors.transparent,
          currentIndex: _selectedScreen,
          showUnselectedLabels: true,
          selectedFontSize: 0,
          unselectedFontSize: 0,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildTitle(),
            _buildSearch(),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(Assets.home),
            )),
            SliverToBoxAdapter(
              child: _buildSectionContainer(),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                      spacing: 10,
                      children: doctors
                          .map(
                            (e) => FullDoctorCard(deviceSize.width * .45, e),
                          )
                          .toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionContainer() => Container(
        height: 35,
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFlatButton('كل الأطباء', false, left: true),
            _buildFlatButton(
              'المتاحين',
              false,
            ),
            _buildFlatButton('المنشغلين', true, right: true),
          ],
        ),
      );

  Widget _buildFlatButton(title, isSelected, {left, right}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(1),
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: left == true
                  ? BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    )
                  : right == true
                      ? BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        )
                      : BorderRadius.zero),
          child: ArabicTitle(
            text: title,
            size: 16,
            isBold: false,
            color: !isSelected
                ? Colors.white
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          onPressed: () {},
          color: isSelected
              ? Colors.white
              : Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }

  Widget _buildSearch() => SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: TextField(
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              isCollapsed: true,
              prefixIcon: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(16),
                        height: 300,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ArabicTitle(
                                text: 'اللغه',
                                size: 18,
                                isBold: true,
                                color: Colors.black),
                            Row(
                              children: [
                                Expanded(
                                  child: RoundedOutLineButton(
                                      onPress: () {},
                                      title: 'العربيه',
                                      borderWidth: 1,
                                      borderColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      backgroundColor: Colors.white,
                                      fontColor: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: RoundedButton(
                                      onPress: () {},
                                      title: 'الانجليزيه',
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontColor: Colors.white),
                                ),
                              ],
                            ),
                            ArabicTitle(
                                text: 'الجنس',
                                size: 18,
                                isBold: true,
                                color: Colors.black),
                            Row(
                              children: [
                                Expanded(
                                  child: RoundedOutLineButton(
                                      onPress: () {},
                                      title: 'ذكر',
                                      borderWidth: 1,
                                      borderColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      backgroundColor: Colors.white,
                                      fontColor: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: RoundedButton(
                                      onPress: () {},
                                      title: 'انثي',
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontColor: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    context: context,
                  );
                },
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              suffixIcon: Icon(
                Icons.search,
                size: 35,
                color: Colors.grey,
              ),
              hintText: 'ابحث عن طبيبك المفضل',
              hintStyle: TextStyle(color: Colors.grey),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ),
      );

  Widget _buildTitle() => SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ArabicTitle(
              text: 'الرئيسية',
              size: 30,
              isBold: true,
              color: Colors.white,
            ),
          ),
        ),
      );
}
