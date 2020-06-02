import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddJobDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Add Job Details',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: JobDetails(title: 'Add Job Details'),
    );
  }
}

class JobDetails extends StatefulWidget {
  JobDetails({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Job Details')),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          SizedBox(height: 20.0),
          Expanded(child: RegisterDetails()),
        ]),
      )),
    );
  }
}

class RegisterDetails extends StatefulWidget {
  RegisterDetails({Key key}) : super(key: key);

  @override
  _RegisterDetailsState createState() => _RegisterDetailsState();
}

class _RegisterDetailsState extends State<RegisterDetails> {
  final fb = FirebaseDatabase.instance;
  final formKey = new GlobalKey<FormState>();
  String key;
  List<String> _jobtitle = <String>[
    '',
    'Courier',
    'Delivery',
    'Electrician',
    'Mechanic',
    'Baby Care Taker',
    'House Keeping',
    'Helper',
    'Watchmen',
    'Driver',
    'Painter',
    'Cook',
    'Costume Desinger',
    'Event Manager',
    'Fitness  Trainer',
    'Office Admin',
    'Beautician',
    'Others',
  ];

  String jobtitle = '';
  String jobdescription;
  String age;
  String salary;
  List<String> _gender = <String>['', 'male', 'female', 'anyone'];
  String gender = '';
  List<String> _jobtype = <String>[
    '',
    'MorningShift',
    'NightShift',
    'HourlyBasis',
    'MonthlyBasis'
  ];
  String jobtype;
  String contactus;
  String location;
  final contactController = TextEditingController();
  final jobDController = TextEditingController();
  final ageController = TextEditingController();
  final salaryController = TextEditingController();
  final locationController = TextEditingController();
  final jobtypeController = TextEditingController();

  final dbRef = FirebaseDatabase.instance.reference().child("Add Job Details");

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              SizedBox(height: 10),
              new FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(15.0),
                      icon: const Icon(
                        Icons.title,
                        color: Colors.black,
                      ),
                      labelText: 'jobtitle',
                    ),
                    isEmpty: jobtitle == '',
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton(
                        value: jobtitle,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            jobtitle = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _jobtitle.map((String value) {
                          return new DropdownMenuItem(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Select JobTitle';
                  }
                  return null;
                },
              ),
              new SizedBox(height: 10.0),
              new TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                controller: jobDController,
                decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(),
                    labelText: 'Job Description',
                    icon: Icon(
                      Icons.description,
                      color: Colors.black,
                    )),
                validator: (value) =>
                    value.isEmpty ? 'Job Description can\'t be empty' : null,
                onSaved: (value) => jobdescription = value,
              ),
              new SizedBox(height: 10.0),
              new TextFormField(
                controller: ageController,
                decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                    icon: Icon(
                      Icons.plus_one,
                      color: Colors.black,
                    )),
                validator: (value) =>
                    value.isEmpty ? 'Age can\'t be empty' : null,
                onSaved: (value) => age = value,
              ),
              new SizedBox(height: 10.0),
              new FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(20.0),
                      icon: const Icon(
                        Icons.wc,
                        color: Colors.black,
                      ),
                      labelText: 'Gender',
                    ),
                    isEmpty: gender == '',
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton(
                        value: gender,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            gender = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _gender.map((String value) {
                          return new DropdownMenuItem(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Select Gender';
                  }
                  return null;
                },
              ),
              new SizedBox(height: 10.0),
              new FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(20.0),
                      icon:
                          const Icon(Icons.thumbs_up_down, color: Colors.black),
                      labelText: 'JobType',
                    ),
                    isEmpty: jobtype == '',
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton(
                        value: jobtype,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            jobtype = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _jobtype.map((String value) {
                          return new DropdownMenuItem(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Select JobType';
                  }
                  return null;
                },
              ),
              new SizedBox(height: 10.0),
              new TextFormField(
                controller: salaryController,
                decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(),
                    labelText: 'Pay',
                    icon: Icon(
                      Icons.attach_money,
                      color: Colors.black,
                    )),
                validator: (value) =>
                    value.isEmpty ? 'Salary can\'t be empty' : null,
                onSaved: (value) => salary = value,
              ),
              new SizedBox(height: 10.0),
              new TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                controller: locationController,
                decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(),
                    labelText: 'Location',
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.black,
                    )),
                validator: (value) =>
                    value.isEmpty ? 'Location can\'t be empty' : null,
                onSaved: (value) => location = value,
              ),
              new SizedBox(height: 10.0),
              new TextFormField(
                maxLines: 2,
                controller: contactController,
                decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(),
                    labelText: 'Contact Info Email/Phone',
                    icon: Icon(
                      Icons.email,
                      color: Colors.black,
                    )),
                validator: (value) =>
                    value.isEmpty ? 'Information can\'t be empty' : null,
                onSaved: (value) => contactus = value,
              ),
              new SizedBox(height: 25.0),
              new SizedBox(
                  width: 200.0,
                  height: 40.0,
                  child: new RaisedButton(
                    child: new Text(
                      'ADD JOB',
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.tealAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        dbRef.push().set({
                          "Job Title": jobtitle,
                          "Job Description": jobDController.text,
                          "age": ageController.text,
                          "type": gender,
                          "Job Type": jobtype,
                          "Payment": salaryController.text,
                          "Location": locationController.text,
                          "Contact Information": contactController.text,
                        }).then((_) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Successfully Added')));
                          ageController.clear();
                          //jobTController.clear();
                          jobDController.clear();
                          salaryController.clear();
                          contactController.clear();
                          locationController.clear();
                        }).catchError((onError) {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text(onError)));
                        });
                      }
                    },
                  )),
              new SizedBox(height: 300.0),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    ageController.dispose();
    //jobTController.dispose();
    jobDController.dispose();
    salaryController.dispose();
    contactController.dispose();
    locationController.dispose();
  }
}
