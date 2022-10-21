import 'package:flutter/material.dart';
import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CardDetails? _cardDetails;

  void scanCard() async {
    final cardDetails = await CardScanner.scanCard(
      scanOptions: const CardScanOptions(
        scanCardHolderName: true,
        scanExpiryDate: true,
        maxCardHolderNameLength: 55,
        validCardsToScanBeforeFinishingScan: 10,
      ),
    );

    setState(() {
      _cardDetails = cardDetails;
    });

    print(cardDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Card Scanner'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanCard,
        child: const Icon(Icons.camera_alt_outlined),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(5),
        child: Center(
          child: CreditCardWidget(
            cardNumber: _cardDetails?.cardNumber ?? '',
            expiryDate: _cardDetails?.expiryDate ?? '',
            isHolderNameVisible: true,
            cardHolderName: _cardDetails != null && _cardDetails!.cardHolderName.isNotEmpty ? _cardDetails!.cardHolderName : '-',
            cvvCode: '',
            showBackView: false,
            isSwipeGestureEnabled: false,
            onCreditCardWidgetChange: (brand) {},
          ),
        ),
      ),
    );
  }
}
