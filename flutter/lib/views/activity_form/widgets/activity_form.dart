import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/activity_model.dart';
import '../../../providers/city_provider.dart';

class ActivityForm extends StatefulWidget {
  final String cityName;

  const ActivityForm({super.key, required this.cityName});

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode _priceFocusNode;
  late FocusNode _urlFocusNode;
  late Activity _newActivity;
  late String? _nameInputAsync;
  bool _isLoading = false;
  FormState get form {
    return _formKey.currentState!;
  }

  @override
  void initState() {
    _newActivity = Activity(
      city: widget.cityName,
      name: '',
      price: 0,
      image: '',
      status: ActivityStatus.ongoing,
    );
    _priceFocusNode = FocusNode();
    _urlFocusNode = FocusNode();
    _nameInputAsync = null;
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _urlFocusNode.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    try {
      CityProvider cityProvider = Provider.of<CityProvider>(
        context,
        listen: false,
      );
      _formKey.currentState!.save();
      setState(() => _isLoading = true);
      _nameInputAsync = await cityProvider.verifyIfActivityNameIsUnique(
        widget.cityName,
        _newActivity.name,
      );
      if (form.validate()) {
        await cityProvider.addActivityToCity(_newActivity);
        if (mounted) Navigator.pop(context);
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Remplissez le nom';
                } else if (_nameInputAsync != null) {
                  return _nameInputAsync;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nom',
              ),
              onSaved: (value) => _newActivity.name = value!,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_priceFocusNode),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: _priceFocusNode,
              decoration: const InputDecoration(
                hintText: 'Prix',
              ),
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_urlFocusNode),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Remplissez le Prix';
                }
                return null;
              },
              onSaved: (value) => _newActivity.price = double.parse(value!),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.url,
              focusNode: _urlFocusNode,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Remplissez l\'url';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Url image',
              ),
              onSaved: (value) => _newActivity.image = value!,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('annuler'),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : submitForm,
                  child: const Text('sauvegarder'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
