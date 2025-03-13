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

  Map<Product, int> cart = {}; // 🛒 장바구니: 상품과 수량 저장
  int totalPrice = 0;

  // ✅ 상품 목록 출력
  void showProducts() {
    print("\n📌 상품 목록:");
    for (var product in products) {
      print("${product.name} / ${product.price}원");
    }
  }

  // ✅ 장바구니에 상품 추가
  void addToCart(String itemName, int quantity) {
    var product = products.firstWhere(
      (p) => p.name.trim().toLowerCase() == itemName.trim().toLowerCase(),
      orElse: () => Product("", 0),
    );

    if (product.name.isEmpty) {
      print("❌ 입력하신 상품이 목록에 없습니다. 다시 확인해주세요.");
    } else if (quantity <= 0) {
      print("⚠️ 0개보다 많은 개수의 상품만 담을 수 있어요!");
    } else {
      cart.update(product, (existingQuantity) => existingQuantity + quantity,
          ifAbsent: () => quantity);
      totalPrice += product.price * quantity;
      print("✅ ${product.name} $quantity개가 장바구니에 추가되었습니다.");
    }
  }

  // ✅ 장바구니 총 가격 출력 (할인 기능 추가)
  void showTotal() {
    print("\n🛒 장바구니 총 가격: $totalPrice 원");

    // 랜덤 할인 기능 (10~30%)
    int discountRate = (10 + (20 * (DateTime.now().millisecondsSinceEpoch % 100) ~/ 100)).toInt();
    int discountAmount = (totalPrice * discountRate ~/ 100);
    int discountedPrice = totalPrice - discountAmount;

    print("🎁 랜덤 할인 적용: ${discountRate}% 할인! (-$discountAmount 원)");
    print("💰 할인 적용 후 총 결제 금액: $discountedPrice 원");
  }

  // ✅ 장바구니 목록 출력
  void showCartItems() {
    if (cart.isEmpty) {
      print("🛒 장바구니가 비어 있습니다.");
    } else {
      print("\n🛍 장바구니에 담긴 상품:");
      cart.forEach((product, quantity) {
        print("- ${product.name}: ${quantity}개 / 개당 ${product.price}원");
      });
    }
  }

  // ✅ 장바구니 초기화
  void resetCart() {
    cart.clear();
    totalPrice = 0;
    print("🔄 장바구니가 초기화되었습니다.");
  }
}

// ✅ main() 함수 실행
void main() {
  stdin.transform(utf8.decoder); // Windows 환경에서 UTF-8 인코딩 강제 적용
  ShoppingMall mall = ShoppingMall();

  print("🛍 쇼핑몰에 오신 것을 환영합니다!");

  while (true) {
    print("\n[1] 상품 목록 보기 / [2] 장바구니 담기 / [3] 장바구니 총 가격 보기");
    print("[4] 장바구니 목록 보기 / [5] 장바구니 초기화 / [6] 프로그램 종료");
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
      mall.showCartItems();
    } else if (choice == "5") {
      mall.resetCart();
    } else if (choice == "6") {
      stdout.write("프로그램을 종료하시겠습니까? (Y/N): ");
      String? confirmExit = stdin.readLineSync()?.trim().toLowerCase();
      if (confirmExit == "y") {
        print("👏 이용해 주셔서 감사합니다 ~ 안녕히 가세요!");
        break;
      } else {
        print("🔄 프로그램이 계속 실행됩니다.");
      }
    } else {
      print("⚠️ 지원하지 않는 기능입니다! 다시 시도해 주세요.");
    }
  }
}
