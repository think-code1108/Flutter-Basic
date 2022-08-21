
void main() {
  dartDataType();
  dartVariable();
  dartFunction();
}

void dartDataType() {
  print("-------------------- Dart Data Type --------------------");

  int angkaInteger = 0;
  angkaInteger += 2;
  print("Nilai Integer: $angkaInteger");

  String variabelString = "Univ. Mercubuana";
  print("Ini adalah fungsi interpolasi: $variabelString");

  List dataList = ["zico", "ronald", "andre"];
  print("Jumlah data array: ");
  print(dataList.length);

  print("Index ke-0:");
  print(dataList[0]);

  print("Index ke-2:");
  print(dataList[2]);  
}

void dartVariable() {
  print("-------------------- Dart Variable --------------------");

  var name = "zico alamsyah";
  print("Nilai awal variable Name: $name");
  name = "Ronald";
  print("Nilai baru variable Name: $name");

  final gender = "laki-laki";
  print("Jenis kelamin: $gender");

  int? umur = 30;
  print("Umur: $umur");

}

void dartFunction() {
  print("-------------------- Dart Function --------------------");

  cetakAngka(8);
  print(cetakFungsiString());
  print(cetakFungsiString2());
}

void cetakAngka(int angka) {
  print("Angka yang dicetak adalah angka $angka");
}

String cetakFungsiString() {
  return "Fungsi ini mengembalikan nilai String";
}

String cetakFungsiString2() =>  "Fungsi Arrow ini mengembalikan nilai String";
