import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/UserProfileResponseModel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'Thankyou_join_activities.dart';

class PurchaseTicket extends StatefulWidget {
  @override
  int eventID;
  String eventAmount;
  String eventName;

  PurchaseTicket(this.eventID, this.eventAmount, this.eventName);
  _PurchaseTicketState createState() => _PurchaseTicketState();
}

class _PurchaseTicketState extends State<PurchaseTicket> {
  List<GlobalKey<FormState>> _formKeys = [GlobalKey<FormState>()];

  final _formKey1 = GlobalKey<FormState>();

  List<TextEditingController> _namecontrollers = new List();
  List<TextEditingController> _mobilecontroller = new List();
  List<FocusNode> _FocusNodename = new List();
  List<FocusNode> _FocusNodemobile = new List();
  FocusNode myFocusNodename = new FocusNode();
  FocusNode myFocusNodemobile = new FocusNode();

  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  ScrollController controller = ScrollController();
  var _count = 0;

  List<Map<String, dynamic>> _values;

  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;

  // _register(BuildContext context) async {
  //   participateRegister(nameController.text, mobileController.text,
  //       _namecontrollers, _mobilecontroller, widget.eventID, context);
  //   //openCheckout();
  //   Future.delayed(const Duration(milliseconds: 300), () {
  //     setState(() {
  //       openCheckout();
  //     });
  //   });
  // }

  _register(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        openCheckout();
      });
    });
  }

  void _validateInputs() {
    bool isValid = true;
    if (_count == 0) {
      if (_formKey1.currentState.validate()) {
        _register(context);
      }
    } else {
      for (int i = 0; i < _formKeys.length - 1; i++) {
        if (!(_formKeys[i].currentState.validate())) {
          isValid = false;
          break;
        }
        // else {
        //   if (!(_formKey1.currentState.validate())) {
        //     if (!(_formKeys[i].currentState.validate())) {
        //       isValid = false;
        //       return;
        //     }
        //   }
        // }
      }

      if (isValid) {
        _register(context);
      } else {
        return;
      }
    }
  }

  bool _autovalidatename = false;
  bool _autovalidatemobile = false;
  bool _validatename = false;
  bool _validatemobile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFfbf0d4),
        body: SingleChildScrollView(
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * .50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  //image: NetworkImage(widget.eventData.splitImage[0]),
                  image: ExactAssetImage("assets/images/dashboard_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.29,
              ),
              height: MediaQuery.of(context).size.height * .7,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: ExactAssetImage("assets/images/bg_color.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
              ),
              child: InkWell(
                child: new IconButton(
                    icon: new Icon(
                      Icons.arrow_back,
                      size: 20,
                    ),
                    color: Color(0xFF203040),
                    onPressed: () => {Navigator.pop(context)}),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .5),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 10,
                      child: Container(
                        //color: Colors.white,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(
                                  20.0) //                 <--- border radius here
                              ),
                        ),
                        child: Form(
                          key: _formKey1,
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * .71,
                                  height:
                                      MediaQuery.of(context).size.height * .085,
                                  child: new TextFormField(
                                    autovalidateMode: _validatename
                                        ? AutovalidateMode.always
                                        : AutovalidateMode.disabled,
                                    autofocus: false,
                                    onFieldSubmitted: (String value) {
                                      if (myFocusNodename.hasFocus) {
                                        _validatename = true;
                                      }
                                    },
                                    controller: nameController,
                                    focusNode: myFocusNodename,
                                    style: TextStyle(
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFFa5a5a5),
                                        fontSize: 12),
                                    cursorColor: const Color(0xFFa5a5a5),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    const Color(0xFFa5a5a5))),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFa5a5a5)),
                                        ),
                                        border: UnderlineInputBorder(),
                                        labelText: 'Name',
                                        labelStyle: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: myFocusNodename.hasFocus
                                                ? const Color(0xFFa5a5a5)
                                                : const Color(0xFFa5a5a5))),
                                    validator: (value) {
                                      if (value.length < 1 || value.isEmpty) {
                                        return "Please Enter Name";
                                      }

                                      return null;
                                      // if (_count > 0) {
                                      //   if (mobileController.text
                                      //           .trim()
                                      //           .isEmpty &&
                                      //       nameController.text
                                      //           .trim()
                                      //           .isEmpty) {
                                      //     return null;
                                      //   } else {
                                      //     if (value.length < 1 ||
                                      //         value.isEmpty) {
                                      //       return "Please Enter Name";
                                      //     }
                                      //   }
                                      // }
                                      // return null;
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .71,
                                height:
                                    MediaQuery.of(context).size.height * .085,
                                child: new TextFormField(
                                  autovalidateMode: _validatemobile
                                      ? AutovalidateMode.always
                                      : AutovalidateMode.disabled,
                                  autofocus: false,
                                  onFieldSubmitted: (String value) {
                                    if (myFocusNodemobile.hasFocus) {
                                      _validatemobile = true;
                                    }
                                  },
                                  maxLength: 10,
                                  controller: mobileController,
                                  focusNode: myFocusNodemobile,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xFFa5a5a5))),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFFa5a5a5)),
                                      ),
                                      fillColor: Colors.white,
                                      border: UnderlineInputBorder(),
                                      labelText: 'Mobile No',
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: myFocusNodemobile.hasFocus
                                              ? const Color(0xFFa5a5a5)
                                              : const Color(0xFFa5a5a5))),
                                  validator: (value) {
                                    if (value.length < 10 || value.isEmpty) {
                                      return "Atleast 10 digit required";
                                    }
                                    return null;
                                    // if (_count > 0) {
                                    //   if (mobileController.text
                                    //           .trim()
                                    //           .isEmpty &&
                                    //       nameController.text
                                    //           .trim()
                                    //           .isEmpty) {
                                    //     return null;
                                    //   } else {
                                    //     if (value.length < 10 ||
                                    //         value.isEmpty) {
                                    //       return "Atleast 10 digit required";
                                    //     }
                                    //   }
                                    // }
                                    // return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _count,
                      itemBuilder: (context, index) {
                        print(index);

                        return _row(index);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          child: Icon(
                            Icons.add,
                            color: Colors.red,
                            size: 35,
                          ),
                          backgroundColor: Color(0xFF9a7210),
                          onPressed: () async {
                            _namecontrollers.add(new TextEditingController());
                            _mobilecontroller.add(new TextEditingController());
                            _FocusNodename.add(new FocusNode());
                            _FocusNodemobile.add(new FocusNode());
                            _formKeys.add(new GlobalKey<FormState>());
                            setState(() {
                              _count++;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _validateInputs();
                          // openCheckout();
                          _register(context);
                          // print(nameController.text);
                          //  print(mobileController.text);
                          //   print( _namecontrollers[0].text);
                          //    print( _mobilecontroller[0].text);
                          //     print( _namecontrollers[1].text);
                          //    print( _mobilecontroller[1].text);
                        },
                        child: Container(
                          height: 70,
                          width: 260,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                const Color(0xFFb48919),
                                const Color(0xFF9a7210),
                              ],
                            ),
                            border: Border.all(color: Colors.white, width: 4),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    70.0) //                 <--- border radius here
                                ),
                          ),
                          child: Center(
                            child: Text("Submit",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 30,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  _row(int index) {
    return Form(
      key: _formKeys[index],
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 10,
                  child: Container(
                    //color: Colors.white,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(
                              20.0) //                 <--- border radius here
                          ),
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * .71,
                            height: MediaQuery.of(context).size.height * .085,
                            child: new TextFormField(
                                autovalidateMode: _autovalidatename
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                autofocus: false,
                                onFieldSubmitted: (String value) {
                                  if (_FocusNodename[index].hasFocus) {
                                    _autovalidatename = true;
                                  }
                                },
                                controller: _namecontrollers[index],
                                focusNode: _FocusNodename[index],
                                style: TextStyle(
                                    height: 1.5,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFa5a5a5),
                                    fontSize: 12),
                                cursorColor: const Color(0xFFa5a5a5),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFFa5a5a5))),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFa5a5a5)),
                                    ),
                                    border: UnderlineInputBorder(),
                                    labelText: 'Name',
                                    labelStyle: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: _FocusNodename[index].hasFocus
                                            ? const Color(0xFFa5a5a5)
                                            : const Color(0xFFa5a5a5))),
                                validator: (value) {
                                  // if (_namecontrollers[index]
                                  //         .text
                                  //         .trim()
                                  //         .isEmpty &&
                                  //     _mobilecontroller[index]
                                  //         .text
                                  //         .trim()
                                  //         .isEmpty) {
                                  //   return null;
                                  // } else {
                                  //   if (value.length < 1 || value.isEmpty) {
                                  //     return "Please Enter Name";
                                  //   }
                                  //   return null;
                                  // }
                                  if (value.length < 1 || value.isEmpty) {
                                    return "Please Enter Name";
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .71,
                          height: MediaQuery.of(context).size.height * .085,
                          child: new TextFormField(
                              autovalidateMode: _autovalidatemobile
                                  ? AutovalidateMode.always
                                  : AutovalidateMode.disabled,
                              maxLength: 10,
                              autofocus: false,
                              onFieldSubmitted: (String value) {
                                if (_FocusNodemobile[index].hasFocus) {
                                  _autovalidatemobile = true;
                                }
                              },
                              //enabled: _isEnable,
                              controller: _mobilecontroller[index],
                              focusNode: _FocusNodemobile[index],
                              style: TextStyle(
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFa5a5a5),
                                  fontSize: 12),
                              cursorColor: const Color(0xFFa5a5a5),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  counterText: '',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFFa5a5a5))),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xFFa5a5a5)),
                                  ),
                                  fillColor: Colors.white,
                                  border: UnderlineInputBorder(),
                                  labelText: 'Mobile No',
                                  labelStyle: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: _FocusNodemobile[index].hasFocus
                                          ? const Color(0xFFa5a5a5)
                                          : const Color(0xFFa5a5a5))),
                              validator: (value) {
                                // if (_namecontrollers[index]
                                //         .text
                                //         .trim()
                                //         .isEmpty &&
                                //     _mobilecontroller[index]
                                //         .text
                                //         .trim()
                                //         .isEmpty) {
                                //   return null;
                                // } else {
                                //   if (value.length < 10 || value.isEmpty) {
                                //     return "Atleast 10 digit required";
                                //   }
                                //   return null;
                                // }
                                if (value.length < 10 || value.isEmpty) {
                                  return "Atleast 10 digit required";
                                }
                                return null;
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Future _loadUserDetails;
  UserProfileResponseModel userProfileResponseModel;
  @override
  void initState() {
    super.initState();
    _loadUserDetails = userProfile();

    setState(() {
      userProfile().then((value) {
        userProfileResponseModel = value;
        print("OBJECT ${value.data.name}");
        setState(() {});
      });
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var amount = (int.parse(widget.eventAmount) * (_count + 1) * 100);
    var options = {
      // 'key': 'rzp_test_1DP5mmOlF5G5ag',
      'orderId': "Order1234",
      'key': 'rzp_live_TKrtmDZafufwpX',
      'amount': "100", //amount,
      'name': 'Total Amount',
      // 'description': 'Fine T-Shirt',
      'prefill': {
        'contact': userProfileResponseModel.data.mobile,
        'email': userProfileResponseModel.data.email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(
        "=============HANDLE PAYMENT START========================================================");
    // _register(context);
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
    // participateRegister(nameController.text, mobileController.text,
    //     _namecontrollers, _mobilecontroller, widget.eventID, context);
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => ThankyouJoinACtivitiesScreen(
            "Your request for ${widget.eventName} participation has been received. If more family members are keen to participate, please click on participate button again! ."))); //Seats will be alloted to you once it gets approved.")));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }
}
