class Splash {
  String image;
  String header;
  String text;

  Splash({required this.image, required this.header, required this.text});
}

List<Splash> screens = [
  Splash(
      image: "assets/images/jordan3.jpg",
      header: "Find your favourite Shoes with us",
      text:
          "Polish up your selfies to make yourself more beautiful with this app."),
  Splash(
      image: "assets/images/retro.png",
      header: "Follow Latest Style Shoes with us ",
      text:
          "We Offer new Fashion shoes that are created with your every need in mind."),
  Splash(
      image: "assets/images/nike.jpg",
      header: "Great way to lift up your style",
      text: "Complete your style with awesome shoes and sneakers from us.")
];
