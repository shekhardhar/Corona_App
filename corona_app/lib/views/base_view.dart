//System imports
import 'package:corona_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';



///Base view for the project whcih other views use to derive from
class BaseView<T extends Model> extends StatelessWidget {
  final ScopedModelDescendantBuilder<T> _builder;
  BaseView({ScopedModelDescendantBuilder<T> builder, MaterialApp child}) : _builder = builder;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(model: locator<T>(),
    child: ScopedModelDescendant<T>(builder: _builder,),
    );
  }
}
