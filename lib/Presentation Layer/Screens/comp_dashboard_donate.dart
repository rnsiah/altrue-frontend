import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';

class CompanyDonationPage extends StatefulWidget {
  const CompanyDonationPage({super.key});

  @override
  State<CompanyDonationPage> createState() => _CompanyDonationPageState();
}

class _CompanyDonationPageState extends State<CompanyDonationPage> {
  String? _company = 'Choose NonProfit';
  String? _project = 'Choos Project To Support';
  bool showProjects = false;
  List<NonProfitProject> projects=[];
  bool showProjectChoicecs = false;
  List<Map<String, String>> choices = [
    {'title': 'love', 'id': '1', 'category': 'health'},
    {'title': 'United Way', 'id': '2', 'category': 'hunger'}
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<NonprofitBloc>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Alture Company Donate'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<NonprofitBloc, NonprofitState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: SmartSelect<String?>.single(
                      modalFilter: true,
                      modalFilterAuto: true,
                      selectedValue: 'The Company',
                      title: 'Choose NonProfit',
                      placeholder: _company!,
                      onChange: (selected) => {
                        setState(() => setState((){
                          _company = selected.title;
                          showProjects = true;
                          
                        }))
                      },
                      choiceItems: S2Choice.listFrom(
                          source: state.nonprofitList,
                          meta: (index, item)=> item,
                          value: (index, item) => item.id.toString(),
                          group: (index, item) => item.category.toString(),
                          title: (index, item) => item.name),
                      groupSortBy: S2GroupSort.byCountInAsc(),
                      modalType: S2ModalType.bottomSheet,
                      tileBuilder: (context, state) => S2Tile<dynamic>(
                        value: state.titleWidget,
                        onTap: (){
                        }
                          
                          
                        ,
                        title: state.selected.toWidget(),
                        isTwoLine: true,
                      ),
                    ),
                  ),
                );
              },
            ),
            showProjects!=false? Padding(
              padding: const EdgeInsets.all(28.0),
              child: Container(
                color: Colors.amber,
                height:300,
                width: 400,
                child: Column(children: [
                  const Text('Do You Want to help fund this organizations specific project'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: (){
                      
                        }, child: const Text('No')),
                      ),
                      ElevatedButton(
                        
                        onPressed: (  
                        ){
                          setState(() {
                            print(projects);
                            showProjectChoicecs = true;
                          });
                        }, child: const Text('Yes'))
                    ],)
                ],),
              ),
            ):const SizedBox(height: 1,),
            showProjectChoicecs ==true? 
            Padding(padding: const EdgeInsets.all(8),
            child: Container(
              child: SmartSelect<String?>.single(
                modalFilter: true,
                modalFilterAuto: true,
                 title: 'Choose A Project',
                 placeholder: _project!,
                selectedValue: 'Pick A Project',
                onChange: (selected)=>{
                  setState(() => setState(() {
                     _project = selected.title;
                  }),),
                },choiceItems: S2Choice.listFrom(
                  source: projects, 
                  value: (index,item)=>item.id.toString(),
                   title: (index, item)=>item.title,
                   
                   ),   modalType: S2ModalType.bottomSheet,
                      tileBuilder: (context, state) => S2Tile<dynamic>(
                        value: state.titleWidget,
                        onTap: state.showModal
                          
                          
                        ,
                        title: state.selected.toWidget(),
                        isTwoLine: true,),
            ),)):const SizedBox(height: 1,)
          ],
        ),
      ),
    );
  }
}
