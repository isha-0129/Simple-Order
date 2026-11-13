const menu = {'Adobo rice': 85.0, 'Iced tea': 35.0, 'Turon': 25.0};

class OrderItem {
  final String name;
  final double price;
  final int qty;

  OrderItem(this.name, this.price, this.qty);

  double get subtotal => price * qty;
}

OrderItem orderOf(String name, int qty) {
  final price = menu[name];
  if (price == null) {
    throw ArgumentError('Item not found on the menu: $name');
  }
  return OrderItem(name, price, qty);
}

double total(List<OrderItem> items) =>
    items.fold(0.0, (sum, item) => sum + item.subtotal);

void printReceipt(List<OrderItem> items, {String? customer}) {
  final customerName = customer ?? 'Guest';
  print('Order for $customerName');

  for (var item in items) {
    final lineDesc = '${item.qty} x ${item.name}';
    final linePrice = item.subtotal.toStringAsFixed(2);
    print('${lineDesc.padRight(16)}${linePrice.padLeft(10)}');
  }

  final subtotalVal = total(items);
  print('${'Subtotal'.padRight(16)}${subtotalVal.toStringAsFixed(2).padLeft(10)}');

  if (subtotalVal >= 300) {
    final discount = subtotalVal * 0.10;
    print(
      '${'Discount 10%'.padRight(16)}${(-discount).toStringAsFixed(2).padLeft(10)}',
    );
    final finalTotal = subtotalVal - discount;
    print('${'Total'.padRight(16)}${finalTotal.toStringAsFixed(2).padLeft(10)}');
  } else {
    print('${'Total'.padRight(16)}${subtotalVal.toStringAsFixed(2).padLeft(10)}');
  }
}

void main() {
  // First order: 3 Adobo rice, 1 Iced tea, 3 Turon (total >= 300, gets 10% discount)
  final order1 = [
    orderOf('Adobo rice', 3),
    orderOf('Iced tea', 1),
    orderOf('Turon', 3),
  ];
  printReceipt(order1);

  print('\n--------------------\n');

  // Second order for a named customer below 300 (no discount line)
  final order2 = [orderOf('Adobo rice', 1), orderOf('Iced tea', 1)];
  printReceipt(order2, customer: 'Usui');
}