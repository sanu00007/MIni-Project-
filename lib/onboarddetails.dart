
class Detail {
  final String image, title;
  final int id;
  Detail({
    this.image = "",
    this.title = "",
    this.id = 0,
  });
}

List<Detail> details = [
  Detail(id: 1, image: "assets/images/crisps.png", title: "Packet Foods"),
  Detail(
      id: 2,
      image: "assets/images/shopping-bag.png",
      title: "Grocery Shopping"),
  Detail(
      id: 3,
      image: "assets/images/magnifying-glass.png",
      title: "Find Nearby Shops"),
  Detail(id: 4, image: "assets/images/sort.png", title: "Sort and Filter"),
  Detail(id: 5, image: "assets/images/time.png", title: "Expiration Remainder"),
  Detail(id: 6, image: "assets/images/favourite.png", title: "Favourites"),
  Detail(
      id: 7, image: "assets/images/distance.png", title: "Location Services"),
  Detail(id: 8, image: "assets/images/question.png", title: "Help"),
];
