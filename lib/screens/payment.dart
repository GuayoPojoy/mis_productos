import 'package:flutter/material.dart';
import 'package:mis_productos/services/firebase_service.dart';
import 'package:mis_productos/widgets/custom_button.dart';

class PaymentScreen extends StatefulWidget {
  final String userName;

  const PaymentScreen({Key? key, required this.userName}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderNameController = TextEditingController();
  double _totalAmount = 0.0;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _calculateTotalAmount();
  }

  Future<void> _calculateTotalAmount() async {
    double total = await FirebaseService.getTotalOrders();
    setState(() {
      _totalAmount = total;
    });
  }

  Future<void> _pay() async {
    setState(() {
      _isProcessing = true;
    });

    final paymentData = {
      'userName': widget.userName,
      'cardNumber': _cardNumberController.text,
      'expiryDate': _expiryDateController.text,
      'cvv': _cvvController.text,
      'cardHolderName': _cardHolderNameController.text,
      'totalAmount': _totalAmount,
    };

    try {
      await FirebaseService.savePaymentData(paymentData);
      await FirebaseService.clearOrders(); 
      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog('Error al procesar el pago: $e');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Pago Exitoso'),
        content: Text('Su pago ha sido procesado con éxito.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop(); 
            },
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pago'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total a pagar: Q. $_totalAmount',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _cardNumberController,
              decoration: InputDecoration(
                labelText: 'Número de Tarjeta',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _expiryDateController,
              decoration: InputDecoration(
                labelText: 'Fecha de Expiración (MM/AA)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _cvvController,
              decoration: InputDecoration(
                labelText: 'CVV',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _cardHolderNameController,
              decoration: InputDecoration(
                labelText: 'Nombre del Titular',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
           CustomButton(
              color: const Color.fromARGB(156, 255, 23, 23),
              iconVisible: false,
              text: 'Pagar',
              textColor: const Color.fromARGB(255, 255, 255, 255),
              onPressed: _pay,
            ),
            
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }
}
