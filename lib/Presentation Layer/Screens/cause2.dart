import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/category_repository.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/functionality_router.dart';
import 'package:lovelovelove/Presentation%20Layer/Routers/router.dart';

import '../../Data Layer/Models/category_model.dart';
import '../../Data Layer/Models/quiz_model.dart';
import '../../Data Layer/Models/user_model.dart';

class CauseDetails2 extends StatefulWidget {
  final Category cause;
  final Profile profile;
  final String causeId;
  const CauseDetails2({super.key, required this.cause, required this.profile, required this.causeId});

  @override
  State<CauseDetails2> createState() => _CauseDetails2State();
}

class _CauseDetails2State extends State<CauseDetails2> {
  CategoryRepository categoryRepository = CategoryRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            snap: true,
            pinned: false,
            floating: true,
            backgroundColor: Colors.amber,
            expandedHeight: 250,
            flexibleSpace: Stack(children: [
              Positioned(
                bottom: 10,
               
                left:20,
                child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: MediaQuery.of(context).size.height*.05,),
            Text(widget.cause.name!, style: const TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),),
            const Text('Cause', style: TextStyle(color: Colors.white, fontSize: 10),),
            const SizedBox(height: 10,),
            SizedBox(width:MediaQuery.of(context).size.width*.65 ,
            child: Text(widget.cause.blurb!, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),),
            Padding(
              padding: const EdgeInsets.only(top:35.0, bottom: 15),
              child: SizedBox(width: MediaQuery.of(context).size.width*.5,
              // ignore: sized_box_for_whitespace
              child: Container(height:50,
                child: ElevatedButton(
                  
                
                  style: ButtonStyle(
                    
                    elevation: MaterialStateProperty.all(6),
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                    child: const Text('Take the Quiz', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                   onPressed: (){
                    print(widget.cause.id);
                    List<Quiz>allQuizes = <Quiz>[];
                   
                    Future<List<Quiz>> quizes =  categoryRepository.fetchQuizList(widget.cause);
                    quizes.then((value) => context.go('/allNpProjects/quizList', extra: QuizListScreenArguments(quizes: value, profile: widget.profile)));
                   },),
              ),),
              )]),
              ),
              Positioned(
          right:-30,
          bottom: 10,
          
          child: Container(height: 200, width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(widget.cause.image!))),),
        ),
            ]),
          ),SliverList(delegate: SliverChildListDelegate(
            [
               Center(child: Container(
                transform: Matrix4.translationValues(0, -5, 0),
          
              decoration: const BoxDecoration(
                
              ),
              height: 120, width: MediaQuery.of(context).size.width*.9,
              child: Card(elevation: 10,
              color: Colors.black,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:10.0),
                    child:  Text('${widget.cause.name} Statistics', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                      Column(children:[
                        const  Text('NonProfits',style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white ),),
                        Text(widget.cause.nonprofitCount.toString(),style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize:24))]),
                  
                        Column(children:[
                        const Text('Raised',style: TextStyle( fontWeight: FontWeight.bold,color: Colors.white  )),
                         Text('\$${widget.cause.donationTotal!}', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize:24),),
                        ]),
                        Column(
                        children: [
                        const Text('Projects',style: TextStyle( fontWeight: FontWeight.bold,color: Colors.white  )),
                          Text(widget.cause.projectCount.toString(),style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize:24)),
                        ],
                      ),
                      
                    ],),
                  ),
                ]),
              ),
            )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ExpandablePanel(
                  header: const Text('The Info', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                  theme: const ExpandableThemeData(iconColor: Colors.amber),
                  collapsed:Text(widget.cause.information!, maxLines: 6, softWrap: true, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),) ,expanded:Text(widget.cause.information!, style: const TextStyle(color: Colors.white)) ,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Top Non Profits', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: GestureDetector(child: const Text('See All', style: TextStyle(color:Colors.amber, fontSize: 18),),),
                      )
                    ],
                  ),),
              ),
             
            ]
          ),
          ),
           SliverGrid(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
              mainAxisExtent: 100, mainAxisSpacing: 10,crossAxisSpacing: 10 ),
              delegate: SliverChildBuilderDelegate(
                
                (context, index) => GestureDetector(
                  onTap: (){
                    // Navigator.of(context).puhsName
                  },
                  child: Container(decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(.43), BlendMode.dstATop),
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.cause.nonprofitList![index].logo))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(widget.cause.nonprofitList![index].name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
                childCount: widget.cause.nonprofitCount!>4?6:3),),

                
          SliverList(delegate: SliverChildListDelegate(
            [
              const Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text('Top Projects', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
              ),
             
            ]
          )),
           SliverGrid(delegate: SliverChildBuilderDelegate(
                
                (context, index) => GestureDetector(
                  onTap: (){
                    // Navigator.of(context).puhsName
                  },
                  child: Container(decoration: BoxDecoration(
                    color: Colors.black12,
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(.43), BlendMode.dstATop),
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.cause.projects![index].projectImage!))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(widget.cause.projects![index].title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
                childCount: widget.cause.projects!.length.clamp(0, 6)), gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
              mainAxisExtent: 100, mainAxisSpacing: 10,crossAxisSpacing: 10 ),)
        ],
        
      ),
    );
  }
}