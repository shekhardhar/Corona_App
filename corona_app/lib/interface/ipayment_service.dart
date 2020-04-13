class IPaymentService {
  Future<dynamic> addPaymentStatus(List orderIdListString, String userId, String razorpayOrderId, String paymentId, String signature, String status) async {}
  Future<Map> createOrder(String receipt, String amount, String email) async {}
  Future<dynamic> addToOrder(List<Map<dynamic, dynamic>> ids) async {}
  Future<dynamic> cancelOrder(int orderId) async {}
  

}
