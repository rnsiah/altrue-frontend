import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';

class ProjectsFollowingCard extends StatelessWidget {
  final NonProfitProjectRep project;
  const ProjectsFollowingCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 80,
        width: MediaQuery.of(context).size.width*.8  ,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(38.5),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 12,
              color: Colors.black.withOpacity(.84),
            ),
          ],
        ),
          child:ClipRRect(borderRadius: BorderRadius.circular(38.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(padding: const EdgeInsets.only(left: 10,right: 5),
            child: Row(children: [
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title, 
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,),),
                  Text(project.title, style: const TextStyle(color: Colors.amber),
                  ),Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('${project.id} of ${project.id} raised so far', style: const TextStyle(fontSize: 10, color: Colors.white),),
                  ), const SizedBox(height: 5,)],
              ), ), 
              SizedBox(height: 80,
                child: Image.network(
                  'https://patch.com/img/cdn20/getty/790386/20211130/040455/styles/patch_image/public/gettyimages-1264350329___30160247653.jpg', fit: BoxFit.fitHeight),
              )
              ] )
            ,),
            Container(height: 7, width: MediaQuery.of(context).size.width *.7,
            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(7)),)
          ]),) ,);
  }
}