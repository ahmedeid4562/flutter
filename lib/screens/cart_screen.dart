import 'package:flutter/material.dart';
import '../model/product.dart';
import 'order_accepted_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cart;
  final Function(Product) onAddToCart;

  const CartScreen({ super.key, required this.cart, required this.onAddToCart,});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String selectedPayment = '';

  Map<Product, int> get _quantities {
    final quantities = <Product, int>{};
    for (var product in widget.cart) {
      quantities[product] = (quantities[product] ?? 0) + 1;
    }
    return quantities;
  }

  List<Product> get _uniqueProducts => widget.cart.toSet().toList();

  double get _total {
    double total = 0;
    _quantities.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final uniqueProducts = _uniqueProducts;
    final quantities = _quantities;
    final total = _total;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Color(0xff181725),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: uniqueProducts.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, color: Color(0xff7C7C7C)),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: uniqueProducts.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      final product = uniqueProducts[index];
                      final quantity = quantities[product] ?? 1;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xffE2E2E2),
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              product.image,
                              width: 70,
                              height: 70,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.image,
                                size: 70,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          product.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color(0xff181725),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            widget.cart.removeWhere(
                                              (p) => p == product,
                                            );
                                          });
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: Color(0xffB3B3B3),
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    product.description,
                                    style: const TextStyle(
                                      color: Color(0xff7C7C7C),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (quantity > 1) {
                                                  widget.cart.remove(product);
                                                }
                                              });
                                            },
                                            child: Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffE2E2E2),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                size: 18,
                                                color: Color(0xff7C7C7C),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                            ),
                                            child: Text(
                                              '$quantity',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff181725),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget.onAddToCart(product);
                                              });
                                            },
                                            child: Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffE2E2E2),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                size: 18,
                                                color: Color(0xff53B175),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '\$${(product.price * quantity).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Color(0xff181725),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: uniqueProducts.isEmpty
                          ? null
                          : () => _showCheckoutBottomSheet(context, total),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff53B175),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 20),
                          const Text(
                            'Go to Checkout',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xff489E67),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              '\$${total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _showCheckoutBottomSheet(BuildContext sheetContext, double total) {
    showModalBottomSheet(
      context: sheetContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff181725),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 22,
                      color: Color(0xff181725),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(color: Color(0xffE2E2E2)),
              const SizedBox(height: 10),
              _buildCheckoutRow(
                title: 'Delivery',
                trailingText: 'Select Method',
                onTap: () => _showDeliveryOptions(context),
              ),
              _buildCheckoutRow(
                title: 'Payment',
                trailingWidget: Image.asset(
                  'assets/images/image25.png',
                  width: 32,
                  height: 24,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.credit_card,
                    color: Colors.blue,
                    size: 24,
                  ),
                ),
                onTap: () => _showPaymentOptions(context),
              ),
              _buildCheckoutRow(
                title: 'Promo Code',
                trailingText: 'Pick discount',
                onTap: () => _showPromoCode(context),
              ),
              _buildCheckoutRow(
                title: 'Total Cost',
                trailingText: '\$${total.toStringAsFixed(2)}',
                onTap: () {},
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'By placing an order you agree to our\n',
                  style: TextStyle(
                    color: Color(0xff7C7C7C),
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms',
                      style: TextStyle(
                        color: Color(0xff181725),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' And '),
                    TextSpan(
                      text: 'Conditions',
                      style: TextStyle(
                        color: Color(0xff181725),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() => widget.cart.clear());
                    Navigator.push(
                      sheetContext,
                      MaterialPageRoute(
                        builder: (_) => const OrderAcceptedScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff53B175),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showDeliveryOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Delivery Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff181725),
                ),
              ),
              const SizedBox(height: 20),
              _optionTile(
                title: 'Standard Delivery',
                subtitle: 'Delivered to your address',
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 10),
              _optionTile(
                title: 'Express Delivery',
                subtitle: 'Fast delivery',
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Payment Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff181725),
                ),
              ),
              const SizedBox(height: 20),
              _optionTile(
                title: 'Credit / Debit Card',
                subtitle: 'Pay securely by card',
                onTap: () {
                  setState(() => selectedPayment = 'Card');
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showPromoCode(BuildContext context) {
    final promoController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Promo Code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff181725),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: promoController,
                decoration: InputDecoration(
                  hintText: 'Enter promo code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff53B175),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _optionTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE2E2E2)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Color(0xff53B175),
              size: 25,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff181725),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff7C7C7C),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutRow({
    required String title,
    String? trailingText,
    Widget? trailingWidget,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff7C7C7C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    if (trailingText != null)
                      Text(
                        trailingText!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff181725),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (trailingWidget != null) trailingWidget,
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Color(0xff181725),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Divider(
          color: Color(0xffE2E2E2),
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}

