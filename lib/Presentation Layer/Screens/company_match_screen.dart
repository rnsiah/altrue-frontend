import 'package:awesome_select/awesome_select.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/np_projects_bloc/bloc/np_projects_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonProfit_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/np_project_card.dart';


import '../../Data Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import '../../Data Layer/Models/non_profit_model.dart';
import '../../Data Layer/Models/nonprofit_project_model.dart';
import '../../Data Layer/Models/send_company_nonprofitMatch_model.dart';
import '../../Data Layer/Models/user_model.dart';
import '../Widgets/company_match_screen/maximum_amount_field.dart';

class CompanyMatchScreen extends StatefulWidget {
  final ForProfitCompany company;
  final Profile profile;

  const CompanyMatchScreen({
    super.key,
    required this.profile,
    required this.company,
  });

  @override
  State<CompanyMatchScreen> createState() => _CompanyMatchScreenState();
}

class _CompanyMatchScreenState extends State<CompanyMatchScreen> {
  final _controller = TextEditingController();
  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  int? matchAmount = 0;
  List<String> lis = ['projects', 'atrocities', 'nonprofits'];
  bool? isAtrocity = false;
  bool? isNonProfit = false;
  bool? isProject = false;
  String? _nonprofit = 'Choose NonProfit Organization';
  String? _atrocity = 'Choose Atrocity To Support';
  String? _project = 'Choose A Project To Support';
  Atrocity? theAtrocity;
  double maximumAmount= 0;
  NonProfitProject? theProject;
  NonProfit? theNonprofit;
  List<Map<String, String>> matchAmounts = [
    {'id': '1', 'amount': '10%'},
    {'id': '2', 'amount': '20%'},
    {'id': '3', 'amount': '50%'},
    {'id': '4', 'amount': '100%'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: const Image(
            image: AssetImage('images/Altrue Logo White.png'),
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 7),
              onPressed: () => print('Search'),
              icon: const Icon(Icons.search),
              iconSize: 30,
              color: Colors.black,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Choose To Support',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      color: Colors.amber,
                      onPressed: () {
                        setState(() {
                          isProject = false;
                          isAtrocity = true;
                          isNonProfit = false;
                        });
                      },
                      child: const Text(
                        'Atrocities',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.amber,
                      onPressed: () {
                        setState(() {
                          isNonProfit = true;
                          isAtrocity = false;
                          isProject = false;
                        });
                      },
                      child: const Text('Non Profits',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    MaterialButton(
                      color: Colors.amber,
                      onPressed: () {
                        setState(() {
                          isProject = true;
                          isAtrocity = false;
                          isNonProfit = false;
                        });
                      },
                      child: const Text('Projects',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              (isNonProfit == true)
                  ? buildNonProfitForm(context)
                  : (isAtrocity == true)
                      ? BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            return buildAtrocityForm(context, state.profile!);
                          },
                        )
                      : (isProject == true)
                          ? buildProjectMatchForm(context)
                          : const SizedBox(),
            ],
          ),
        ));
  }

  Column buildAtrocityForm(BuildContext context, Profile profile) {
    final NonProfitRespository repo = NonProfitRespository();
    return Column(
      children: [
        MaximumAmountField(onAmountSelected: (value){
          maximumAmount = double.parse(value);
        },),
        const Divider(
          indent: 30,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .25,
          child: BlocBuilder<AtrocityBlocBloc, AtrocityBlocState>(
              builder: (context, state) => SmartSelect<dynamic>.single(
                    selectedValue: 'The Atrocity',
                    title: _atrocity!,
                    placeholder: _atrocity!,
                    modalFilter: true,
                    modalFilterAuto: true,
                    choiceItems: S2Choice.listFrom(
                        source: state.atrocities,
                        value: (index, item) => item.id.toString(),
                        title: (index, item) => item.title,
                        meta: (index, item) => item),
                    groupSortBy: S2GroupSort.byNameInAsc(),
                    modalType: S2ModalType.bottomSheet,
                    choiceLayout: S2ChoiceLayout.wrap,
                    choiceDirection: Axis.vertical,
                    modalHeader: true,
                    onChange: (selected) => setState(() {
                      _atrocity = selected.title;
                    }),
                    tileBuilder: (context, state) => S2Tile.fromState(
                      state,
                      isTwoLine: true,
                      // onTap: (){
                      //   setState(() {
                      //     theAtrocity = state.selected.choice!.meta;
                      //   });
                      // },
                      title: Text(
                        _atrocity!,
                        style: const TextStyle(color: Colors.amber),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(16),
                        child: _atrocity == 'Choose Atrocity To Support'
                            ? const Text('Choose Atrocity To Support',
                                style: TextStyle(color: Colors.amber))
                            : Text('You have chosen to support $_atrocity',
                                style: const TextStyle(color: Colors.amber)),
                      ),
                    ),
                    choiceBuilder: (context, state, choice) {
                      return InkWell(
                        onTap: () {
                          choice.select?.call(true);
                          setState(() {
                            theAtrocity = choice.meta;
                          });
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3))
                              ],
                              image: DecorationImage(
                                  // colorFilter:
                                  //      const ColorFilter.mode(Colors.yellow, BlendMode.darken),
                                  image: NetworkImage(choice.meta.imageUrl),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                choice.meta.title,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    backgroundColor:
                                        Colors.black.withOpacity(.4)),
                              ),
                            )),
                      );
                    },
                  )),
        ),
        theAtrocity != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${theAtrocity!.title} is supported by ${theAtrocity!.nonprofitList!.length} organizations. Funds donated will be spread proportionately amongst these organizations',
                  style: const TextStyle(color: Colors.amber),
                ),
              )
            : const Text(
                'nothing',
                style: TextStyle(color: Colors.amber),
              ),
        theAtrocity != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: theAtrocity!.nonprofitList!.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          NonProfit nonprofit = await repo.fetchNonProfit(
                              theAtrocity!.nonprofitList![index].id);
                          print(profile.username);
                          print(theAtrocity!.nonprofitList![index].id);

                          Navigator.of(context).pushNamed('/nonProfitView',
                              arguments: NonProfitDetailArguments(
                                  nonProfit: nonprofit, profile: profile));
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(theAtrocity!
                                      .nonprofitList![index].logo))),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }

  Column buildProjectMatchForm(BuildContext context) {
    return Column(children: [
       MaximumAmountField(onAmountSelected: (amouont){
        maximumAmount = double.parse(amouont);
       },),
      const Divider(indent: 30),
      SizedBox(
        height: MediaQuery.of(context).size.height * .25,
        child: BlocBuilder<NpProjectsBloc, NpProjectsState>(
            builder: (context, state) => SmartSelect<String?>.single(
                  selectedValue: 'The Project',
                  modalFilter: true,
                  modalFilterAuto: true,
                  title: 'Choose Project',
                  placeholder: _project!,
                  onChange: (selected) {
                    setState(() => setState(() => _project = selected.title));
                  },
                  choiceItems: S2Choice.listFrom(
                      source: state.projects,
                      value: (index, item) => item.id.toString(),
                      title: (index, item) => item.title,
                      meta: (index, item) => item),
                  groupSortBy: S2GroupSort.byNameInAsc(),
                  modalType: S2ModalType.bottomSheet,
                  choiceLayout: S2ChoiceLayout.wrap,
                  choiceDirection: Axis.vertical,
                  modalHeader: true,
                  choiceBuilder: (context, state, choice) {
                    return InkWell(
                      onTap: () {
                        choice.select?.call(true);
                        setState(() {
                          theProject = choice.meta;
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3))
                            ],
                            image: DecorationImage(
                                // colorFilter:
                                //      const ColorFilter.mode(Colors.yellow, BlendMode.darken),
                                image: NetworkImage(choice.meta.projectImage),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              choice.meta.title,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  backgroundColor:
                                      Colors.black.withOpacity(.4)),
                            ),
                          )),
                    );
                  },
                  tileBuilder: (context, state) => S2Tile.fromState(
                    state,
                    isTwoLine: true,
                    title: Text(
                      _project!,
                      style: const TextStyle(color: Colors.amber),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(16),
                      child: _project == 'Choose A Project To Support'
                          ? const Text(
                              'Choose A Project To Support',
                              style: TextStyle(color: Colors.amber),
                            )
                          : Text(
                              'You have chosen to support the $_project project',
                              style: const TextStyle(color: Colors.amber),
                            ),
                    ),
                  ),
                )),
      )
    ]);
  }

  Column buildNonProfitForm(BuildContext context) {
    return Column(
      children: [
         MaximumAmountField(onAmountSelected:(amount){
          maximumAmount=double.parse(amount);
         } ,),
        const Divider(
          indent: 30,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .2,
          child: BlocBuilder<NonprofitBloc, NonprofitState>(
            builder: (context, state) {
              return SmartSelect<String?>.single(
                choiceStyle: const S2ChoiceStyle(
                    raised: true,
                    subtitleStyle: TextStyle(color: Colors.amber),
                    titleStyle: TextStyle(color: Colors.amber)),
                selectedValue: 'The NonProfit',
                modalFilter: true,
                modalFilterAuto: true,
                title: 'Choose NonProfit',
                placeholder: _nonprofit!,
                onChange: (selected) => {
                  setState(() => setState(() => _nonprofit = selected.title))
                },
                choiceItems: S2Choice.listFrom(
                    source: state.nonprofitList,
                    value: (index, item) => item.id.toString(),
                    title: (index, item) => item.name,
                    meta: (index, item) => item),
                choiceBuilder: (context, state, choice) {
                  return ListTile(
                    title: Text(choice.meta.name),
                    onTap: () {
                      choice.select?.call(true);
                      setState(() {
                        theNonprofit = choice.meta;
                      });
                    },
                    leading: Image(image: NetworkImage(choice.meta.logo)),
                  );
                },
                groupSortBy: S2GroupSort.byCountInAsc(),
                modalType: S2ModalType.bottomSheet,
                tileBuilder: (context, state) => S2Tile<dynamic>(
                  body: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: _nonprofit == 'Choose NonProfit Organization'
                        ? const Text(
                            'Please choose an organization to build a matching relationship with',
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'You have chosen ${_nonprofit!} to build a matching relationship with.',
                            style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  value: state.titleWidget,
                  onTap: state.showModal,
                  title: Text(
                    _nonprofit!,
                    style: const TextStyle(color: Colors.amber, fontSize: 18),
                  ),
                  isTwoLine: true,
                ),
              );
            },
          ),
        ),
        const Divider(
          indent: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .15,
          child: SmartSelect<int?>.single(
            placeholder: 'Choose An Amount',
            title: 'Choose Match Amount',
            selectedValue: matchAmount!,
            choiceLayout: S2ChoiceLayout.wrap,
            modalType: S2ModalType.bottomSheet,
            choiceDirection: Axis.vertical,
            modalHeader: true,
            onChange: (selected) => {
              setState(() => setState(
                    () => matchAmount = selected.value,
                  ))
            },
            choiceItems: S2Choice.listFrom<int, Map<dynamic, dynamic>>(
                source: matchAmounts,
                value: (index, item) => index,
                title: (index, item) => (item['amount']) ?? '',
                meta: (index, item) => item),
            choiceBuilder: (context, state, choice) {
              return Card(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                color: choice.selected ? Colors.black : Colors.amber,
                child: GestureDetector(
                  onTap: () => choice.select?.call(true),
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * .9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 3)),
                            child: Text(
                              choice.meta['amount'],
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: choice.selected
                                      ? Colors.white
                                      : Colors.black),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Text(
                          'Choose to match ${choice.meta['amount']} of user donations until your funds are exhausted',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                          softWrap: true,
                        ))
                      ],
                    ),
                  ),
                ),
              );
            },
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                title: const Text(
                  'Match Amount',
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                body: state.selected.choice == null
                    ? const Text('Choose Amount To Match')
                    : Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Text(
                          'Currently matching ${state.selected.choice!.meta['amount']} of users donation',
                          style: const TextStyle(
                              color: Colors.amber, fontSize: 18),
                        ),
                      ),
                // title: Text('Choose Amount', style: TextStyle(color: Colors.amber, fontSize: 15),)
              );
            },
          ),
        ),
        const Divider(
          indent: 10,
        ),
        theNonprofit != null
            ? Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16, bottom: 9),
                child: Text(
                  'By supporting the ${theNonprofit!.name} you are helping fund ${theNonprofit!.projects!.length} different projects. Funds donated will be spread proportionately amongst these projects',
                  style: const TextStyle(color: Colors.amber),
                ),
              )
            : const Text(
                'nothing',
                style: TextStyle(color: Colors.amber),
              ),
        theNonprofit != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: theNonprofit!.projects!.length,
                      itemBuilder: (context, index) => NpProjectCard(
                            profile: widget.profile,
                            project: theNonprofit!.projects![index],
                            isForMatchScreen: true,
                          )),
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: MediaQuery.of(context).size.height * .08,
          width: MediaQuery.of(context).size.width * .85,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber)),
              onPressed: () {
                context.read<ProfileBloc>().add(CreateCompanyMatch(
                  relationship: SendCompanyNonProfitRelationShip(
                    nonprofit:theNonprofit!,
                    company: widget.company,
                    matchLevel: matchAmount!,
                    fundingLimit:  maximumAmount)));
              },
              child: const Text(
                'Complete',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),
        )
      ],
    );
  }
}
