// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'base_widget.dart';

class ClockWidgetState extends WidgetState {
  ClockWidgetState({
    required String id,
  }) : super(id: id, klass: WidgetClass.clock);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'classId': klass.id,
    };
  }

  @override
  String toTypeName() {
    return "時計ウィジェット";
  }

  ClockWidgetState copyWith({String? content}) {
    return ClockWidgetState(
      id: id,
    );
  }

  static ClockWidgetState fromMap(Map<String, dynamic> map) {
    return ClockWidgetState(
      id: map['id'],
    );
  }
}

class ClockWidget extends DashboardWidget<ClockWidgetState> {
  const ClockWidget({super.key, required List<String> paths})
      : super(paths: paths);

  @override
  Widget build(BuildContext context) {
    final state = useWidgetState();
    final datetime = useState<DateTime>(DateTime.now());

    useEffect(() {
      var timer = Timer.periodic(
        const Duration(microseconds: 500),
        (Timer timer) => {datetime.value = DateTime.now()},
      );

      return timer.cancel;
    }, const []);

    var dateFormatter = DateFormat('EEE MMM d yyyy');
    var timeFormatter = DateFormat('HH:mm:ss');
    var date = dateFormatter.format(datetime.value);
    var time = timeFormatter.format(datetime.value);
    return Text('${date} ${time}');
  }
}
