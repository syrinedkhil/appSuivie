import 'package:app_suivie/user/controller/user.controller.dart';
import 'package:app_suivie/user/model/user.model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:app_suivie/user/view/mobileView/form/login.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [HexColor("#E7EFFC"), HexColor("#F3FEEC")],
          // Ajouter des couleurs supplémentaires ici si vous le souhaitez
        ),
      ),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(top: 100.0),
                  decoration: BoxDecoration(
                    color: HexColor("#F9F6E9").withOpacity(0.8),
                    boxShadow: [
                      const BoxShadow(
                        color: Color.fromRGBO(255, 198, 196, 196),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      _Logo(),
                      _FormContent(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Already have an account? ",
                    style: GoogleFonts.oleoScript(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: HexColor("#000000").withOpacity(0.4),
                    ),
                  ),
                  TextSpan(
                    text: "Sign In",
                    style: GoogleFonts.oleoScript(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      color: HexColor("#000000"),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Login()),
                        );
                      },
                  ),
                ],
              ),
            ),
            // Utiliser les media queries pour ajuster la position de l'élément en fonction de la taille de l'écran
            // Les valeurs par défaut sont utilisées pour les écrans plus petits que 600px
            // Les valeurs modifiées sont utilisées pour les écrans plus grands que 600px
            // Vous pouvez ajuster les valeurs en fonction de vos besoins
            left: MediaQuery.of(context).size.width > 600 ? 90.0 : 90.0,
            bottom: MediaQuery.of(context).size.width > 600 ? 30.0 : 14.0,
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 130, 20),
      child: Text(
        "Create Account",
        textAlign: TextAlign.right,
        style: GoogleFonts.oleoScript(
          fontSize: 30,
          fontStyle: FontStyle.italic,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password = '';
  String _confirmPassword = '';
  final _ctrname = TextEditingController();
  final _ctremail = TextEditingController();
  final _ctrpassword = TextEditingController();
  @override
  void dispose() {
    _ctrname.dispose();
    _ctremail.dispose();
    _ctrpassword.dispose();
    super.dispose();
  }

  bool isPay = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: HexColor("#F8F5E6").withOpacity(0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(7)),
              child: TextFormField(
                controller: _ctrname,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '  Please enter Full Name';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your Name',
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.person, color: Colors.black),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(
                          0.5), // Définit la couleur de la bordure d'erreur
                    ),
                  ),
                ),
                cursorColor: const Color.fromARGB(255, 67, 67, 67).withOpacity(1),
              ),
            ),
            _gap(),
            Container(
              decoration: BoxDecoration(
                  color: HexColor("#F8F5E6").withOpacity(0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(7)),
              child: TextFormField(
                controller: _ctremail,
                validator: (value) {
                  // add email validation
                  if (value == null || value.isEmpty) {
                    return '  Please enter some text';
                  }
                  if (value == 'admin@gmail.com') {
                    return ' Please try another adress';
                  }

                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return '  Please enter a valid email';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.email, color: Colors.black),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(
                          0.5), // Définit la couleur de la bordure d'erreur
                    ),
                  ),
                ),
                cursorColor: const Color.fromARGB(255, 67, 67, 67).withOpacity(1),
              ),
            ),
            _gap(),
            Container(
              decoration: BoxDecoration(
                  color: HexColor("#F8F5E6").withOpacity(0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(7)),
              child: TextFormField(
                controller: _ctrpassword,
                onChanged: (value) {
                  _password = value;
                },
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return ' Password is required please enter';
                  }
                  if (value!.length < 6) {
                    return '  Password must be at least 6 characters';
                  }
                  return null;
                },
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.black),
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.black),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    color: HexColor("#000000"),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(
                          0.5), // Définit la couleur de la bordure d'erreur
                    ),
                  ),
                ),
                cursorColor: const Color.fromARGB(255, 67, 67, 67).withOpacity(1),
              ),
            ),
            _gap(),
            Container(
              decoration: BoxDecoration(
                  color: HexColor("#F8F5E6").withOpacity(0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(7)),
              child: TextFormField(
                onChanged: (value) {
                  _confirmPassword = value;
                },
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return ' Conform password is required please enter';
                  }
                  if (value != _password) {
                    return ' Confirm password not matching!';
                  }
                  return null;
                },
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: const TextStyle(color: Colors.black),
                  hintText: 'Confirm your password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.black),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    color: HexColor("#000000"),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(
                          0.5), // Définit la couleur de la bordure d'erreur
                    ),
                  ),
                ),
                cursorColor: const Color.fromARGB(255, 67, 67, 67).withOpacity(1),
              ),
            ),
            _gap(),
            Container(
              margin: const EdgeInsets.only(left: 170),
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                //width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      primary: HexColor("#D7C773"),
                      onPrimary: Colors.black,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Go To Pay',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        /// do something
                        final user = User_app(
                            FullName: _ctrname.text,
                            email: _ctremail.text,
                            PassWord: _ctrpassword.text,
                            role:'parent'
                           );
                        /*  addUser(user);*/

                       // await makepayment("100", "INR", user);
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
  Map<String, dynamic>? paymentIntentData;
  Future<void> makepayment(
      String amount, String currency, User_app user) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                //applePay:true,
                googlePay: const PaymentSheetGooglePay(merchantCountryCode: "IN"),
                merchantDisplayName: "Prospects",
                customerId: paymentIntentData!['customer'],
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                customerEphemeralKeySecret:
                    paymentIntentData!['ephemeralkey']));

        await displayPaymentSheet(user);
      }
    } catch (e, s) {
      print("EXCEPTION ===$e$s");
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                "bearer sk_test_51N2CcwDAq0pPQLM4WHkFnEih0hnlg2uelxHuO0ZkP5VVAVgUZf34o0U8LenRSG7On2TiYKKJGDFxID2TUZ9GLxQD00VZpeTxTX",
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user $err');
    }
  }

  Future<void> displayPaymentSheet(User_app user) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar("Payment info", "pay successful");
      addUser(user);
    } on Exception catch (e) {
      if (e is StripeException) {
        print("error from stripe $e");
      } else {
        print("unforseen error $e");
      }
    } catch (e) {
      print("exception===$e");
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
