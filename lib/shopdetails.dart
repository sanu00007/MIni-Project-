
class ShopDetail {
  final String image, title, location;
  final int id;
  ShopDetail({
    this.image = "",
    this.title = "",
    this.location = "",
    this.id = 0,
  });
}

List<ShopDetail> ShopDetails = [
  ShopDetail(
      id: 1,
      image: "assets/images/malabar.jpg",
      title: "Malabar Chips",
      location: "Kundara"),
  ShopDetail(
      id: 2,
      image: "assets/images/anstore.webp",
      title: "AN stores",
      location: "Chavara"),
  ShopDetail(
      id: 3,
      image: "assets/images/pizzahut.jpg",
      title: "Medicos",
      location: "Kadapakkada"),
  ShopDetail(
      id: 4,
      image: "assets/images/akstore.jpg",
      title: "AK stores",
      location: "Kottarakkara"),
  ShopDetail(
      id: 5,
      image: "assets/images/tea.jpg",
      title: "Tea Shop",
      location: "chinnakada"),
  ShopDetail(
      id: 6,
      image: "assets/images/bakery.png",
      title: "Subway",
      location: "Randamkutty"),
  ShopDetail(
      id: 7,
      image: "assets/images/medico.jpg",
      title: "Liva",
      location: "Keralapuram"),
  ShopDetail(
      id: 8,
      image: "assets/images/tacobell.jpg",
      title: "TacoBell",
      location: "Koikkal"),
  ShopDetail(
      id: 9,
      image: "assets/images/bakery.png",
      title: "PizzaHut",
      location: "Karicode"),
];
