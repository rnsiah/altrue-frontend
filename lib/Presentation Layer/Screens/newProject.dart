import 'dart:io';

import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/addNP_project_bloc/bloc/add_np_project_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/nonprofit_project_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Presentation%20Layer/Widgets/company_dashboard/title_viiew.dart';
import '../../Data Layer/Blocs/form_submission_status.dart';
import '../../Data Layer/Models/category_model.dart';

class NewProject extends StatefulWidget {
  final NonProfit nonprofit;
  final Profile profile;

  const NewProject({Key? key, required this.nonprofit, required this.profile})
      : super(key: key);

  @override
  State<NewProject> createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _imageFile;
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Image(
          image: AssetImage('images/Altrue Logo White.png'),
          height: 40,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => print('Search'),
            icon: const Icon(Icons.search, color: Colors.amber, size: 30),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => AddNpProjectBloc(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleView(titleTxt: 'Add A Project'),
              const SizedBox(height: 20),
              _instructionSection(),
              _imagePicker(),
              Expanded(
                child: BlocProvider.value(
                  value: context.read<CategoryBloc>(),
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      return npProjectForm(
                        widget.nonprofit,
                        widget.profile,
                        state.categoryList,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageUrlController.clear(); // Clear URL if file is picked
      });
    }
  }

  Widget _imagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Project Image', style: TextStyle(color: Colors.amber)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amber),
              borderRadius: BorderRadius.circular(10),
            ),
            child: _imageFile == null
                ? const Center(
                    child: Text('Tap to select an image',
                        style: TextStyle(color: Colors.amber)),
                  )
                : Image.file(_imageFile!, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _imageUrlController,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
            hintText: 'Or Enter Image URL',
            hintStyle: TextStyle(color: Colors.white),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {
                _imageFile = null; // Clear file if URL is entered
              });
            }
          },
        ),
      ],
    );
  }

  Widget _instructionSection() {
    return Card(
      color: Colors.amber.withOpacity(0.1),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instructions for Creating a Project',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '1. Enter a descriptive and engaging project title.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '2. Select the category that best represents your project.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '3. Provide a detailed description of the project.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '4. Set a realistic fundraising goal.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '5. List any supplies needed for the project.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '6. Click "Create Project" to submit your project for review.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget npProjectForm(
    NonProfit nonprofit,
    Profile profile,
    List<Category> causes,
  ) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          _inputField('Project Title', 1, 'title', context),
          // const SizedBox(height: 16),
          // _categorySelector(causes),
          const SizedBox(height: 16),
          _inputField('Project Description', 6, 'description', context),
          const SizedBox(height: 16),
          _inputField('Fundraising Goal', 1, 'goal', context),
          const SizedBox(height: 16),
          _inputField('Supplies', 6, 'supplies', context),
          const SizedBox(height: 20),
          _submitButton(context),
        ],
      ),
    );
  }

  Widget _inputField(
      String label, int lines, String field, BuildContext context) {
    return BlocBuilder<AddNpProjectBloc, AddNpProjectState>(
      builder: (context, state) {
        return TextFormField(
          maxLines: lines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Colors.white12,
            filled: true,
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
          onChanged: (value) {
            switch (field) {
              case 'title':
                context
                    .read<AddNpProjectBloc>()
                    .add(NpProjectTitleEdited(title: value));
                break;
              case 'description':
                context
                    .read<AddNpProjectBloc>()
                    .add(NpProjectInformationEdited(information: value));
                break;
              case 'goal':
                context.read<AddNpProjectBloc>().add(
                    NpProjectFundraisingGoalEdited(
                        fundraisingGoal: int.parse(value)));
                break;
              case 'supplies':
                context
                    .read<AddNpProjectBloc>()
                    .add(NpProjectSuppliesEdited(supplies: value));
                break;
            }
          },
        );
      },
    );
  }

  // Widget _categorySelector(List<Category> causes) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text('Choose Cause', style: TextStyle(color: Colors.amber)),
  //       const SizedBox(height: 8),
  //       SmartSelect<String>.single(
  //         title: 'Select Category',
  //         placeholder: 'Select a category',
  //         selectedValue: '',
  //         onChange: (selected) {
  //           context
  //               .read<AddNpProjectBloc>()
  //               .add(NpProjectCategoryEdited(category: selected.value));
  //         },
  //         choiceItems: S2Choice.listFrom<String, Category>(
  //           source: causes,
  //           value: (index, item) => item.id!,
  //           title: (index, item) => item.name!,
  //         ),
  //         modalType: S2ModalType.popupDialog,
  //         tileBuilder: (context, state) {
  //           return S2Tile.fromState(
  //             state,
  //             hideValue: true,
  //             trailing: const Icon(Icons.arrow_drop_down, color: Colors.amber),
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget _submitButton(BuildContext context) {
    return BlocBuilder<AddNpProjectBloc, AddNpProjectState>(
      builder: (context, state) {
        if (state.status is FormSubmitting) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.amber));
        }
        return Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              overlayColor: Colors.amber,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                NonProfitProjectCreation project = NonProfitProjectCreation(
                  title: state.title,
                  atrocity: state.atrocity,
                  category: state.category,
                  information: state.information,
                  fundraisingGoal: state.fundraisingGoal,
                  supplies: state.supplies,
                  nonprofit: widget.nonprofit.id,
                );
                context.read<AddNpProjectBloc>().add(NpProjectSubmitted(
                      project: project,
                      nonProfit: widget.nonprofit,
                    ));
              }
            },
            child: const Text('Create Project',
                style: TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }
}
