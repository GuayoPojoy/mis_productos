import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _numberOfPeople;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _submitReservation() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Crear un mapa con los datos de la reservación
      Map<String, dynamic> reservationData = {
        'name': _name,
        'numberOfPeople': _numberOfPeople,
        'date': _selectedDate?.toIso8601String(),
        'time': _selectedTime?.format(context),
      };

      // Guardar los datos de la reservación en Firebase
      try {
        await FirebaseService.saveReservationData(reservationData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reservación guardada exitosamente')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar la reservación: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Número de personas'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese número de personas';
                  }
                  return null;
                },
                onSaved: (value) {
                  _numberOfPeople = int.tryParse(value!);
                },
              ),
              ListTile(
                title: Text('Fecha: ${_selectedDate != null ? _selectedDate!.toLocal().toString().split(' ')[0] : 'Seleccionar fecha'}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              ListTile(
                title: Text('Hora: ${_selectedTime != null ? _selectedTime!.format(context) : 'Seleccionar hora'}'),
                trailing: Icon(Icons.access_time),
                onTap: () => _selectTime(context),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitReservation,
                child: Text('Reservar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
