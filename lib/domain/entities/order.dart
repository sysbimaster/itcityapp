
import './product.dart';
class Order {
  String id;
  String date;
  List<Product> products;
  String status;
  double total;
  double deliveryCharge;
  Order(this.id ,this.date, this.products, this.status , this.total , this.deliveryCharge);
}