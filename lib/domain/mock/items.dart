class Item {
  String name;
  String image;
  String price;

  Item({String n, String i, String p}) {
    name = n;
    image = i;
    price = p;
  }
}

List<Item> items = [
  Item(
      n: 'Samsung Galaxy M31 \n(Space Black, 6GB RAM,\n128GB Storage',
      i: 'assets/images/items/i1.jpg',
      p: 'KWD 164'),
  Item(
      n: 'realme C15 64 GB,\n4 GB RAM, Power Silver,\nSmartphone',
      i: 'assets/images/items/i2.png',
      p: 'KWD 144'),
  Item(
      n: 'Realme Narzo 20 \n(Glory Silver, 128 GB)\n(4 GB RAM)',
      i: 'assets/images/items/i3.jpg',
      p: 'KWD 251'),
  Item(
      n: 'Realme 6 64 GB,\n6 GB RAM, Comet Blue,\nSmartphone',
      i: 'assets/images/items/i4.jpg',
      p: 'KWD 258'),
  Item(
      n: 'realme X \n(Space Blue, 4GB+128GB)',
      i: 'assets/images/items/i5.png',
      p: 'KWD 154'),
  //  Item(n: 'Redmi Note 9 128 GB, 6 GB RAM, Pebble Grey, Smartphone', i:'', p: 'KWD 257'),
  //  Item(n: 'Apple iPhone 11 Pro Max (64GB) - Space Greye', i:'', p: 'KWD 1654'),
  //  Item(n: '', i:'', p: 'KWD 1654'),
  //  Item(n: 'Samsung Galaxy M31 (Space Black, 6GB RAM, 128GB Storage', i:'', p: 'KWD 1654'),
  //  Item(n: 'Samsung Galaxy M31 (Space Black, 6GB RAM, 128GB Storage', i:'', p: 'KWD 1654'),
];
