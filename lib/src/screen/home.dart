import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_projects/src/screen/details.dart';
import 'package:flutter_projects/src/screen/open_restaurant.dart';
import 'package:flutter_projects/src/service/category_services.dart';
import 'package:flutter_projects/src/service/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils.dart';
import '../widget/widgets.dart';
import '../model/models.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      drawer: MyDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: white,
              floating: true,
              expandedHeight: appBarHeight(context),
              flexibleSpace: mySliverAppBar(),
              toolbarHeight: appBarHeight(context),
            ),
            SliverToBoxAdapter(
              child: pobularFood(),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  CustomTitle(
                    text: ' Best Restaurants',
                    size: 20,
                    color: grey,
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            bestRestaurants(),
          ],
        ),
      ),
    );
  }

  Widget bestRestaurants() {
    return FutureBuilder(
        future: RestaurantServices.instance().getBestRestaurant(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return SliverToBoxAdapter(child: SpinKitThreeBounce(color: red));
          else {
            var bestRestaurants = <Restaurant>[];
            for (var doc in snapshot.data.docs) {
              bestRestaurants.add(Restaurant.fromSnapshot(doc));
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var restaurant = bestRestaurants[index];
                  return BestRestaurantCard(
                      restaurant: restaurant,
                      onPress: () => nav(
                            context,
                            OpenRestaurant(restaurant: restaurant),
                          ));
                },
                childCount: bestRestaurants.length,
              ),
            );
          }
        });
  }

  Widget pobularFood() {
    return FutureBuilder(
        future: FoodServices.instance().getFood(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return SpinKitDualRing(color: red);

          var foods = <Food>[];
          for (var doc in snapshot.data.docs) {
            foods.add(Food.fromSnapshot(doc));
          }

          return Container(
            height: pobFoodHeight(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                CustomTitle(
                  text: ' Pobular Food',
                  color: grey,
                  size: 20,
                ),
                SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    itemCount: foods.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var food = foods[index];
                      return PobFoodCard(
                          food: food,
                          onPress: () {
                            nav(context, Details(food: food));
                          });
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget mySliverAppBar() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(text: ' What would you like to eat ?', size: 20),
              NotificationIcon(
                  notificationNumber: 5,
                  onPress: () {
                    //TODO go to notification screen
                    print('onTop working');
                  }),
            ],
          ),
          SizedBox(height: 10),
          Search(
            hint: 'Find food and restaurent',
            leftIcon: Icons.search,
            rightIcon: Icons.filter_list,
            onSubmitSearch: (value) {
              //TODO search function
              print(value);
            },
            filtterFunction: () {
              //TODO filter function
            },
          ),
          SizedBox(height: 10),
          Expanded(child: buildCategories()),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildCategories() {
    return FutureBuilder(
      future: CategoryServices.instance().getCategories(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var categories = <Category>[];
          for (var doc in snapshot.data.docs) {
            categories.add(Category.fromSnapshot(doc));
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              var category = categories[index];
              return CategoryCard(
                category: category,
                onPress: () {
                  //TODO impelementation of catogory click
                },
              );
            },
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitThreeBounce(color: red),
            ],
          );
        }
      },
    );
  }
}
