import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/create_company_bloc/bloc/create_company_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Blocs/form_submission_status.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';

import '../../Data Layer/Models/company_completion_model.dart';

class CompanySignupPage extends StatefulWidget {
  final Profile profile;

  const CompanySignupPage({Key? key, required this.profile}) : super(key: key);

  @override
  State<CompanySignupPage> createState() => _CompanySignupPageState();
}

class _CompanySignupPageState extends State<CompanySignupPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
      body: BlocProvider(
        create: (context) => CreateCompanyBloc(),
        child: Column(
          children: [
            const Text(
              'Welcome To Altrue Global',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Register Your Company',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold)),
            Expanded(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: _companySignUpForm()),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  Widget _companySignUpForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              _name(),
              _yearStarted(),
              _addressStreet(),
              _description(),
              _missionStatement(),
              _website(),
              _instagram(),
              _facebook(),
              _registerCompany(),
              Container(
                height: 50,
              )
            ],
          ),
        ));
  }

  Widget _name() {
    return BlocBuilder<CreateCompanyBloc, CreateCompanyState>(
      builder: (context, state) {
        return TextFormField(
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: 'Company Name',
                labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
            onChanged: (value) => {
                  context
                      .read<CreateCompanyBloc>()
                      .add(CompanyNameChange(companyName: value))
                },
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 3) {
                return 'Please choos a company name';
              }
              return null;
            }
            // state.city.length > 3 ? null : "Select A Valid Ciy",
            );
      },
    );
  }

  Widget _website() {
    return BlocBuilder<CreateCompanyBloc, CreateCompanyState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.url,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Company website',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            context
                .read<CreateCompanyBloc>()
                .add(CompanyWebsiteChange(companyWebsite: value))
          },
          // validator: (value) => value!.length > 3
          //     ? value
          //     : "Invalid website, please correct the web address",
        );
      },
    );
  }

  Widget _yearStarted() {
    return BlocBuilder<CreateCompanyBloc, CreateCompanyState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.url,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Year Started',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            context
                .read<CreateCompanyBloc>()
                .add(CompanyYearStartedChanged(companyYear: value))
          },
          // validator: (value) => value!.length == 4 && int.parse(value) > 1900
          //     ? value
          //     : "Invalid year",
        );
      },
    );
  }

  Widget _addressStreet() {
    return BlocBuilder<CreateCompanyBloc, CreateCompanyState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.streetAddress,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Street Address',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            context
                .read<CreateCompanyBloc>()
                .add(CompanyAddressChange(companyAddress: value))
          },
          // validator: (value) =>
          //     value!.length < 7 ? null : 'Please choose a valid address',
        );
      },
    );
  }

  Widget _missionStatement() {
    return BlocBuilder<CreateCompanyBloc, CreateCompanyState>(
      builder: (context, state) {
        return TextFormField(
          maxLines: 6,
          keyboardType: TextInputType.streetAddress,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: "Your organization's mission statement",
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            context
                .read<CreateCompanyBloc>()
                .add(CompanyMissionChanged(mission: value))
          },
          // validator: (value) =>
          //     value!.length > 7 ? value : "Describe your company's mission",
        );
      },
    );
  }

  Widget _instagram() {
    return BlocBuilder<CreateCompanyBloc, CreateCompanyState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: '@',
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Company Instagram',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            context
                .read<CreateCompanyBloc>()
                .add(CompanyInstagramChange(comInsta: value))
          }
          // context
          //     .read<UserProfileEditBloc>()
          //     .add(UserProfileZipChange(zip: value)),
          ,
          // validator: (value) =>
          //     value!.length > 5 ? value : 'Please enter a valid zip code',
        );
      },
    );
  }

  Widget _facebook() {
    return BlocBuilder<CreateCompanyBloc, CreateCompanyState>(
      builder: (context, state) {
        return TextFormField(
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: "Company's Facebook",
                labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
            onChanged: (value) => context
                .read<CreateCompanyBloc>()
                .add(CompanyFacebookChange(comFacebook: value)));
      },
    );
  }

  Widget _description() {
    return BlocBuilder<CreateCompanyBloc, CreateCompanyState>(
      builder: (context, state) {
        return TextFormField(
          maxLines: 6,
          keyboardType: TextInputType.streetAddress,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Give A Description Of Your Organization',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            context
                .read<CreateCompanyBloc>()
                .add(CompanyDescriptionChange(companyDescription: value))
          },
          // validator: (value) => value!.length > 7
          //     ? value
          //     : "Please describe the company's purpose",
        );
      },
    );
  }

  _registerCompany() {
    return BlocBuilder<CreateCompanyBloc, CreateCompanyState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : MaterialButton(
                color: Colors.amber,
                child: const Text(
                  'Register Your Company',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  print([
                    state.companyAddress,
                    state.companyName,
                    state.instagram
                  ]);
                  if (_formKey.currentState!.validate()) {
                    context.read<CreateCompanyBloc>().add(CompanyAttemptCreate(
                          profile: widget.profile,
                          completedCompany: CompanyCompletion(
                              userId: widget.profile.user!,
                              logo: state.logo,
                              instagram: state.instagram,
                              companyName: state.companyName,
                              description: state.description,
                              facebook: state.facebook,
                              companyAddress: state.companyAddress,
                              missionStatement: state.mission,
                              yearStarted: state.yearStarted,
                              profile: widget.profile,
                              mainImage: ''),
                        ));
                  } else {
                    context.read<CreateCompanyBloc>().add(
                        CompanyFailedRegistration(errorMessage: "Exception"));
                  }
                },
              );
      },
    );
  }
}
