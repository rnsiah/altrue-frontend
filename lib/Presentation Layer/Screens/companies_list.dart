import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/bloc/company_list_bloc.dart';

import '../../Data Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import '../../Data Layer/Models/company_model.dart';
import '../../Data Layer/Models/user_model.dart';
import '../Widgets/category_selector.dart';

class CompaniesListScreen extends StatefulWidget {
  final Profile profile;
  final List<ForProfitCompany>? companies;
  const CompaniesListScreen({super.key, required this.profile, this.companies});

  @override
  State<CompaniesListScreen> createState() => _CompaniesListScreenState();
}

class _CompaniesListScreenState extends State<CompaniesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Altrue Companies'),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
            color: Colors.amber,
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                return CategorySelector(
                  isNonProfit: false,
                  isAtrocity: false,
                  isCompany: true,
                  categoryList: state.categoryList,
                  isShirt: false,
                  isProject: false,
                );
              }),
              const SizedBox(
                height: 10,
              ),
              const Text('Love'),
              Expanded(
                child: BlocConsumer<CompanyListBloc, CompanyListState>(
                    buildWhen: (p, c) => p.companies != c.companies,
                    builder: (context, state) {
                      if (state.categoryCompanyList.isNotEmpty) {
                        return buildCompanyListByCateogory(state);
                      } else if (state.categoryCompanyList.isEmpty &&
                          state.companies.isNotEmpty) {
                        return buildCompanyList(state);
                      }
                      return buildCompanyList(state);
                    },
                    listener: (context, state) => {}),
              ),
            ]));
  }

  Expanded buildCompanyList(CompanyListState state) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: GridView.builder(
            itemCount: state.companies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 27,
                childAspectRatio: .75,
                mainAxisSpacing: 13,
                crossAxisCount: 2),
            itemBuilder: (context, index) => CompanyCard(
                  company: state.companies[index],
                  press: () => Navigator.of(context).pushNamed(
                      '/companyDetails',
                      arguments: state.companies[index]),
                )),
      ),
    );
  }

  Expanded buildCompanyListByCateogory(CompanyListState state) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: GridView.builder(
          itemCount: state.companies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 27,
              mainAxisSpacing: 13,
              childAspectRatio: .75,
              crossAxisCount: 2),
          itemBuilder: (context, index) => CompanyCard(
              company: state.companies[index],
              press: () => Navigator.of(context).pushNamed('/companyDetails',
                  arguments: state.companies[index]))),
    ));
  }
}

class CompanyCard extends StatelessWidget {
  final ForProfitCompany company;
  final Function press;
  const CompanyCard({super.key, required this.company, required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.network(
              company.logo!,
              scale: .7,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              company.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
