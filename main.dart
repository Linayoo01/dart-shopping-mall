import 'dart:convert';
import 'dart:io';

// ✅ Product 클래스 정의
class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

// ✅ ShoppingMall 클래스 정의
class ShoppingMall {
  List<Product> products = [
    Product("셔츠", 45000),
    Product("원피스", 30000),
    Product("반팔티", 35000),
    Product("반바지", 38000),
    Product("양말", 5000)
  ];

  int totalPrice = 0;

  // ✅ 상품 목록 출력
  void showProducts() {
    print("\n상품 목록:");
    for (var product in products) {
      print("${product.name} / ${product.price}원");
    }
  }

  // ✅ 장바구니에 상품 추가
  void addToCart(String itemName, int quantity) {
    // 입력값을 trim(), toLowerCase() 적용하여 비교
    var product = products.firstWhere(
      (p) => p.name.trim().toLowerCase() == itemName.trim().toLowerCase(),
      orElse: () => Product("", 0),
    );

    if (product.name.isEmpty) {
      print("❌ 입력하신 상품이 목록에 없습니다. 다시 확인해주세요.");
    } else if (quantity <= 0) {
      print("⚠️ 0개보다 많은 개수의 상품만 담을 수 있어요!");
    } else {
      totalPrice += product.price * quantity;
      print("✅ 장바구니에 상품이 담겼어요!");
    }
  }

  // ✅ 장바구니 총 가격 출력
  void showTotal() {
    print("🛒 장바구니에 $totalPrice 원 어치를 담으셨네요!");
  }
}

// ✅ main() 함수 실행
void main() {
  // Windows 환경에서 UTF-8 인코딩 강제 적용
  stdin.transform(utf8.decoder);

  ShoppingMall mall = ShoppingMall();

  print("🛍 쇼핑몰에 오신 것을 환영합니다!");

  while (true) {
    print("\n[1] 상품 목록 보기 / [2] 장바구니 담기 / [3] 장바구니 총 가격 보기 / [4] 프로그램 종료");
    stdout.write("선택: ");
    String? choice = stdin.readLineSync()?.trim();

    if (choice == "1") {
      mall.showProducts();
    } else if (choice == "2") {
      stdout.write("상품명을 입력하세요: ");
      String? itemName = stdin.readLineSync(encoding: utf8)?.trim();

      stdout.write("상품 개수를 입력하세요: ");
      String? quantityInput = stdin.readLineSync();
      int? quantity = int.tryParse(quantityInput ?? "");

      if (itemName != null && quantity != null) {
        mall.addToCart(itemName, quantity);
      } else {
        print("⚠️ 입력값이 올바르지 않아요!");
      }
    } else if (choice == "3") {
      mall.showTotal();
    } else if (choice == "4") {
      print("👏 이용해 주셔서 감사합니다 ~ 안녕히 가세요!");
      break;
    } else {
      print("⚠️ 지원하지 않는 기능입니다! 다시 시도해 주세요.");
    }
  }
}
