import 'package:flutter/material.dart';

class ElemBuilder {
  State state;
  ElemBuilder(this.state);

  void buildAndShowSnackBar(
      String content, String actionLabel, Function onPressFunc) {
    ScaffoldMessenger.of(state.context).showSnackBar(
      SnackBar(
        content: Text(content),
        action: actionLabel.isNotEmpty
            ? SnackBarAction(
                label: actionLabel,
                onPressed: () => onPressFunc,
              )
            : null,
      ),
    );
  }
}
