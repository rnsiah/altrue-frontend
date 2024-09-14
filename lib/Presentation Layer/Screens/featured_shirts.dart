import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/category_selector.dart';

import '../../Data Layer/Blocs/shirt_group_bloc/bloc/shirtgroup_bloc.dart';
import '../../Data Layer/Models/user_model.dart';
import '../../Data Layer/Repositories/shirt_groups_repository.dart';
import '../Widgets/Featured_Shirts.dart';

class FeaturedShirtScreen extends StatefulWidget {
  final Profile profile;
  final ShirtGroupRepository repository = ShirtGroupRepository();
  FeaturedShirtScreen({super.key, required this.profile});

  @override
  State<FeaturedShirtScreen> createState() => _FeaturedShirtScreenState();
}

class _FeaturedShirtScreenState extends State<FeaturedShirtScreen> {
  @override
  Widget build(BuildContext context) {
    final pageController = PageController(viewportFraction: .8);
    int pageIndex = 0;
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('Altrue'),
          backgroundColor: Colors.black,
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: BlocProvider.value(
          value: context.read<CategoryBloc>(),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CategorySelector(
                                      isShirt: false,
                                      isProject: false,
                                      categoryList: state.categoryList,
                                      isNonProfit: false,
                                      isAtrocity: false,
                                      isCompany: false),);
                  },
                ),
                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     MaterialButton(
                  //         color: Colors.amber,
                  //         child: const Text('All Shirts'),
                  //         onPressed: () {
                  //           context.go('/');
                  //         }),
                  //     Text('Hey'),
                  //     Text('Hey'),
                  //   ],
                  // ),
                
                BlocBuilder<ShirtgroupBloc, ShirtgroupState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .65,
                      child: PageView.builder(
                        itemCount: state.shirtgroups.length,
                        itemBuilder: (context, index) => ShirtGroupsList(
                          groups: state.shirtgroups,
                          profile: widget.profile,
                        ),
                      ),
                    );
                  },
                ),
                
                const Text(
                  'hey',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ));
  }
}
