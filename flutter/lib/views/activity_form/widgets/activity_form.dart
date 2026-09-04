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
  bool _isLoading = false;
  String? _nameInputAsync;

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
    super.initState();
  }

  Future<void> submitForm() async {
    form.save();
    setState(() => _isLoading = true);
    try {
      final cityProvider = Provider.of<CityProvider>(context, listen: false);
      _nameInputAsync = await cityProvider.verifyIfActivityNameIsUnique(
        widget.cityName,
        _newActivity.name,
      );
      if (!form.validate()) {
        if (mounted) {
          setState(() => _isLoading = false);
        }
        return;
      }
      await cityProvider.addActivityToCity(_newActivity);
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('L\'activité n\'a pas pu être enregistrée'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _urlFocusNode.dispose();
    super.dispose();
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
              decoration: const InputDecoration(labelText: 'Nom'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Remplissez le nom';
                }
                return _nameInputAsync;
              },
              onSaved: (value) => _newActivity.name = value!,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_priceFocusNode),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              decoration: const InputDecoration(hintText: 'Prix'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Remplissez le prix';
                }
                return null;
              },
              onSaved: (value) => _newActivity.price = double.parse(value!),
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_urlFocusNode),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.url,
              focusNode: _urlFocusNode,
              decoration: const InputDecoration(hintText: 'Url image'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Remplissez l\'Url';
                }
                return null;
              },
              onSaved: (value) => _newActivity.image = value!,
            ),
            const SizedBox(height: 10),
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
            ),
          ],
        ),
      ),
    );
  }
}
