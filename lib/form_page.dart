import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {

  const FormPage({Key? key}) : super(key: key);

  @override
  FormPageState createState() => FormPageState();
}

class FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _phoneController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationPage(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ConfirmationPage extends StatelessWidget {
//   final String name;
//   final String email;
//   final String phone;
//
//   const ConfirmationPage({required this.name, required this.email, required this.phone, Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Confirmation Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text('Name: $name'),
//             Text('Email: $email'),
//             Text('Phone Number: $phone'),
//             const SizedBox(height: 16.0),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Save data here
//                 },
//                 child: const Text('Save Data'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class ConfirmationPage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;

  const ConfirmationPage({
    required this.name,
    required this.email,
    required this.phone,
    Key? key,
  }) : super(key: key);

  @override
  ConfirmationPageState createState() => ConfirmationPageState();
}

class ConfirmationPageState extends State<ConfirmationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller and animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Start animation when the widget is first displayed
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${widget.name}'),
            Text('Email: ${widget.email}'),
            Text('Phone Number: ${widget.phone}'),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _saveData();
                },
                child: const Text('Save Data'),
              ),
            ),
            const SizedBox(height: 16.0),
            // Animated widget that fades in the message when data is saved
            FadeTransition(
              opacity: _animation,
              child: const Text(
                'Data Tersimpan!',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveData() {
    // Simulate saving data with a delay of 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      // Start the animation and rebuild the widget tree
      _controller.forward(from: 0);
      setState(() {});
    });
  }
}
