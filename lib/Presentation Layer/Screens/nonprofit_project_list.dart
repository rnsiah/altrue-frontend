import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';

import '../../Data Layer/Models/non_profit_model.dart';
import '../../Data Layer/Models/user_model.dart';


class NonProfitProjectList extends StatefulWidget {
  final NonProfit nonprofit;
  final Profile profile;
  const NonProfitProjectList({super.key, required this.nonprofit, required this.profile});

  @override
  State<NonProfitProjectList> createState() => _NonProfitProjectListState();
}

class _NonProfitProjectListState extends State<NonProfitProjectList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: (){
          Navigator.of(context).pushNamed('/createProject', arguments: CreateProjectArguments(nonprofit: widget.nonprofit, profile: widget.profile));
        },
      label: const Text('Add ', style: TextStyle(color: Colors.black),),
      icon: 
      IconButton(icon:const Icon(Icons.add, color: Colors.black,) , onPressed: (){},),),
      
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions:   [
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed('/createProject', arguments: CreateProjectArguments(nonprofit: widget.nonprofit, profile: widget.profile));
            },
            child: const Icon(Icons.plus_one,))
        ],
        title: const Text('NonProfit Projects'),
      ),
      body: 
      widget.nonprofit.projects!.isNotEmpty || widget.nonprofit.projects!= null ? 
      ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.nonprofit.projects!.length,
        itemBuilder: ((context, index) => 
      NonProfitProjectCard(widget.nonprofit.projects![index])),
    ): const Text('You Have No Curent Projects'));
  }


  // ignore: non_constant_identifier_names
  Widget NonProfitProjectCard(NonProfitProject project){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: project.isActive==null ||  project.isActive == true ? Colors.amber :Colors.black,
          borderRadius: BorderRadius.circular(14)
        ),
        width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height *.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(project.title, maxLines: 2,  style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22, color: project.isActive==null? Colors.black: Colors.white),)),
              project.cause!=null?
              Text(project.cause!.name!, style: const TextStyle(color: Colors.amber, fontSize: 14),):
              const Text('Choose Cause', style: TextStyle(color: Colors.amber, fontSize: 14),)
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Text(project.isActive==null?'Pending': project.isActive.toString(), style:  TextStyle(fontWeight: FontWeight.bold,color:project.isActive==null? Colors.black: Colors.amber),),
          ),
          Row(
            children: [
               Icon(Icons.people, color:project.isActive==null ? Colors.black: Colors.amber,),
              Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: Text(project.followers!.length.toString(), style:  TextStyle(fontWeight: FontWeight.bold,color:project.isActive==null?Colors.black: Colors.amber),),
              ),
            ],
          )

        ],),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            project.information!, 
            style:  TextStyle(
              color: project.isActive==null? Colors.black: Colors.white),overflow: TextOverflow.ellipsis,maxLines: 2,softWrap: false,),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom:16.0, left:12),
          child: Row(children: [
            Row(
              children: [
                Icon(Icons.account_balance_wallet_outlined,  color:project.isActive==null? Colors.black: Colors.amber,),
                const SizedBox(width: 7,),
                Text('\$${project.currentFunds} / \$${project.fundraisingGoal} raised', style:  TextStyle(color: project.isActive==null? Colors.black: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),),
              ],
            ),
          ],),
        )
        // DropdownButtonHideUnderline(child: DropDownButton2)
      ]),
      ),
    );
  }
}