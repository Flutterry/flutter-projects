import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
            bestFood(),
          ],
        ),
      ),
    );
  }

  Widget bestFood() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var food = bestFoodList[index];
          return bestFoodCard(food, () {
            //TODO implement later
          });
        },
        childCount: bestFoodList.length,
      ),
    );
  }

  Widget bestFoodCard(Food food, void Function() onPress) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
          height: bestFoodHeight(context),
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              food.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
          height: bestFoodHeight(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black87,
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 10,
          child: IconCard(
            icon: food.fav ? Icons.favorite : Icons.favorite_border,
            iconColor: red,
            onTap: () {
              //TODO later
            },
          ),
        ),
        Positioned(
          top: 10,
          right: 20,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.yellow[700]),
                SizedBox(width: 5),
                CustomTitle(
                  text: '${food.rate}',
                  size: 14,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                text: food.name,
                color: white,
                weight: FontWeight.w500,
                size: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTitle(text: 'by : ', color: white, size: 14),
                  CustomTitle(
                    text: food.from,
                    color: white,
                    size: 18,
                    weight: FontWeight.w400,
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: 10,
          child: CustomTitle(
            text: '\$${food.price.toStringAsFixed(2)}',
            size: 20,
            weight: FontWeight.bold,
            color: white,
          ),
        )
      ],
    );
  }

  Widget pobularFood() {
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
              itemCount: pobFood.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var food = pobFood[index];
                return PobFoodCard(
                    context: context,
                    food: food,
                    onPress: () {
                      //TODO onFood card click
                    });
              },
            ),
          ),
        ],
      ),
    );
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
          Expanded(child: buildCategories(categories)),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildCategories(List<Category> categories) {
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
  }
}
