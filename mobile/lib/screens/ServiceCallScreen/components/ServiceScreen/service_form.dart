import 'package:flutter/material.dart';

class ServiceForm extends StatelessWidget {
  final BuildContext context;
  final GlobalKey<FormState> _formKey;
  final List<Widget> children;

  const ServiceForm({
    Key key,
    @required this.context,
    @required GlobalKey<FormState> formKey,
    @required this.children,
  })  : _formKey = formKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
