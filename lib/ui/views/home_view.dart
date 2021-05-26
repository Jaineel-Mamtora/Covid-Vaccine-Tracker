import 'dart:convert';

import 'package:cowin_vaccine_slots/managers/notification_handler.dart';
import 'package:cowin_vaccine_slots/models/available_slot.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../locator.dart';
import '../../ui/views/base_view.dart';
import '../../viewmodels/home_viewmodel.dart';

import 'package:cowin_vaccine_slots/models/district.dart';
import 'package:cowin_vaccine_slots/managers/cowin_api_manager.dart';
import 'package:cowin_vaccine_slots/models/state.dart' as CountryState;
import 'package:cowin_vaccine_slots/models/schedule_for_week.dart' as SFW;

class HomeView extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _notificationHandler = locator<NotificationHandler>();
  CountryState.State selectedState;
  District selectedDistrict;

  String selectedStateName;
  String selectedDistrictName;

  DateTime selectedDate = DateTime.now();
  TextEditingController dateTextController;

  List<String> ageGroups = ['18 - 44 Years', '45+ Years'];

  String selectedAgeGroup;
  int selectedAgeGroup1;

  Map<String, int> selectedAgeGroupMap = {
    '18 - 44 Years': 18,
    '45+ Years': 45,
  };

  String selectedRadioButtonValue = 'Free';
  int id = 1;

  SFW.ScheduleForWeek scheduleForWeek;
  List<AvailableSlot> availableSlots = [];

  String selectedVaccinationCenter;

  @override
  void initState() {
    super.initState();
    dateTextController = TextEditingController();
  }

  @override
  void dispose() {
    dateTextController.dispose();
    super.dispose();
  }

  Future<DateTime> showMyDatePicker({
    BuildContext ctx,
  }) async {
    DateTime date = await showDatePicker(
      context: ctx,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030, 12, 31),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (date != null) {
      return date;
    } else {
      date = selectedDate;
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Cowin Vaccine Slots'),
            centerTitle: true,
          ),
          body: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Find Vaccination Center',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FutureBuilder(
                    future: CowinApiManager.getStates(),
                    builder:
                        (context, AsyncSnapshot<CountryState.States> snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButton(
                          icon: Icon(Icons.expand_more),
                          isExpanded: true,
                          value: selectedStateName,
                          onChanged: (String state) {
                            setState(() {
                              selectedStateName = state;
                            });
                          },
                          hint: Text('Select a State'),
                          items: snapshot.data.states
                              .map((CountryState.State state) {
                            return DropdownMenuItem<String>(
                              value: state.stateName,
                              child: Text(state.stateName),
                              onTap: () {
                                setState(() {
                                  selectedState = state;
                                  selectedDistrictName = null;
                                  selectedVaccinationCenter = null;
                                });
                              },
                            );
                          }).toList(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Some Error Occurred'),
                        );
                      }
                      return Container();
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if (selectedState != null)
                    FutureBuilder(
                      future: CowinApiManager.getDistrictFromStateId(
                          selectedState.stateId),
                      builder: (context, AsyncSnapshot<Districts> snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButton(
                            icon: Icon(Icons.expand_more),
                            isExpanded: true,
                            value: selectedDistrictName,
                            onChanged: (String district) {
                              setState(() {
                                selectedDistrictName = district;
                              });
                            },
                            hint: Text('Select a District'),
                            items: snapshot.data.districts
                                .map((District district) {
                              return DropdownMenuItem<String>(
                                value: district.districtName,
                                child: Text(district.districtName),
                                onTap: () {
                                  setState(() {
                                    selectedDistrict = district;
                                    selectedVaccinationCenter = null;
                                  });
                                },
                              );
                            }).toList(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Some Error Occurred'),
                          );
                        }
                        return Container();
                      },
                    ),
                  SizedBox(height: 5),
                  DropdownButton(
                    icon: Icon(Icons.expand_more),
                    isExpanded: true,
                    value: selectedAgeGroup,
                    onChanged: (String ageGroup) {
                      setState(() {
                        selectedAgeGroup = ageGroup;
                        selectedAgeGroup1 = selectedAgeGroupMap[ageGroup];
                      });
                    },
                    hint: Text('Select the Age Group'),
                    items: ageGroups.map((String ageGroup) {
                      return DropdownMenuItem<String>(
                        value: ageGroup,
                        child: Text(ageGroup),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 55,
                    child: TextFormField(
                      readOnly: true,
                      autofocus: false,
                      keyboardType: TextInputType.datetime,
                      controller: dateTextController,
                      decoration: InputDecoration(
                        hintText: 'Select a Date',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        suffixIcon: Icon(Icons.date_range_outlined),
                      ),
                      onTap: () async {
                        selectedDate = await showMyDatePicker(ctx: context);
                        setState(() {
                          dateTextController.text =
                              DateFormat('dd-MM-yyyy').format(selectedDate);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: id,
                        onChanged: (val) {
                          setState(() {
                            selectedRadioButtonValue = 'Free';
                            id = 1;
                          });
                        },
                      ),
                      Text(
                        'Free',
                        style: new TextStyle(fontSize: 17.0),
                      ),
                      SizedBox(width: 10),
                      Radio(
                        value: 2,
                        groupValue: id,
                        onChanged: (val) {
                          setState(() {
                            selectedRadioButtonValue = 'Paid';
                            id = 2;
                          });
                        },
                      ),
                      Text(
                        'Paid',
                        style: new TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        onPressed: () async {
                          bool notify = false;
                          if (selectedDistrict != null &&
                              selectedDate != null &&
                              selectedAgeGroup != null) {
                            scheduleForWeek =
                                await CowinApiManager.getCalendarByDistrict(
                                    selectedDistrict.districtId,
                                    dateTextController.text);
                            Stream<SFW.ScheduleForWeek> val =
                                Stream.periodic(Duration(seconds: 5)).asyncMap(
                                    (i) =>
                                        CowinApiManager.getCalendarByDistrict(
                                            selectedDistrict.districtId,
                                            dateTextController.text));
                            val.listen((sfw) async {
                              scheduleForWeek = sfw;
                              print('listening...');
                              print(SFW.scheduleForWeekToJson(scheduleForWeek));
                              setState(() {});
                              if (scheduleForWeek.centers.isNotEmpty) {
                                for (SFW.Center center
                                    in scheduleForWeek.centers) {
                                  if (center.feeType ==
                                          selectedRadioButtonValue &&
                                      center.sessions.isNotEmpty) {
                                    DateTime from = DateFormat("HH:mm:ss")
                                        .parse(center.from);
                                    DateTime to =
                                        DateFormat("HH:mm:ss").parse(center.to);
                                    for (SFW.Session session
                                        in center.sessions) {
                                      if (session.date ==
                                              dateTextController.text &&
                                          session.minAgeLimit ==
                                              selectedAgeGroup1 &&
                                          session.slots.isNotEmpty) {
                                        AvailableSlot availableSlot =
                                            AvailableSlot(
                                          centerId: center.centerId,
                                          name: center.name,
                                          pincode: center.pincode,
                                          sessionId: session.sessionId,
                                          date: session.date,
                                          feeType: center.feeType,
                                          availableCapacity:
                                              session.availableCapacity,
                                          minimumAgeLimit: session.minAgeLimit,
                                          vaccine: session.vaccine,
                                          slot: DateFormat.jm().format(from) +
                                              ' - ' +
                                              DateFormat.jm().format(to),
                                        );
                                        if (availableSlots.firstWhere(
                                                (AvailableSlot element) =>
                                                    element.centerId ==
                                                        availableSlot
                                                            .centerId &&
                                                    element.availableCapacity <=
                                                        0,
                                                orElse: () => null) !=
                                            null) {
                                          continue;
                                        } else if (availableSlots
                                            .contains(availableSlot)) {
                                          print('contains');
                                          continue;
                                        } else {
                                          notify = true;
                                          availableSlots.add(availableSlot);
                                          await _notificationHandler
                                              .showBigTextNotification(
                                            id: availableSlot.centerId,
                                            title: 'Center Name: ' +
                                                availableSlot.name,
                                            body: 'Date: ' +
                                                availableSlot.date +
                                                ' | Timings: ' +
                                                availableSlot.slot +
                                                ' | Payment Type: ' +
                                                availableSlot.feeType +
                                                ' | Available Vaccine count: ' +
                                                availableSlot.availableCapacity
                                                    .toString(),
                                            payload: jsonEncode({}),
                                          );
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            });
                          } else {
                            await Fluttertoast.showToast(
                              msg: 'Please fill all the details.',
                            );
                          }
                          if (notify == true) {
                            await Fluttertoast.showToast(
                              msg: 'Notification created successfully!',
                            );
                          }
                        },
                        child: Text(
                          'NOTIFY ME',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
