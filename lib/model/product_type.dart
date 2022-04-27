enum ProductType {
  baby,
  bakery,
  beautyAndPersonalHygiene,
  beerWineAndSpirits,
  beverages,
  cansAndJars,
  cerealAndMuesli,
  clothing,
  coffeeAndTea,
  dairyAndEggs,
  electronicsAndOffice,
  fishAndSeafood,
  frozen,
  fruitsAndVegetables,
  gardenAndDiy,
  grainsAndPasta,
  health,
  homeBaking,
  houseCleaningProducts,
  meatAndPoultry,
  oils,
  other,
  pets,
  readyMeals,
  snacksAndSweets,
  spicesAndSauces
}

String parseEntryTypeToString(ProductType type) {
  StringBuffer sb = StringBuffer();
  String entryString = type.toString().replaceFirst("EntryType.", "");
  var words = entryString.split(RegExp(r"([A-Z])"));
  words[0] = words[0].substring(1);
  for (String word in words) {
    var i = entryString.indexOf(word.trim());
    sb.write(entryString.substring(i - 1, i).toUpperCase() +
        entryString.substring(i, i + word.length) +
        " ");
  }
  return sb.toString().replaceAll("And", "&");
}

ProductType getEntryType(String type) {
  for (var entryType in ProductType.values) {
    if (type == parseEntryTypeToString(entryType)) return entryType;
  }
  throw "No entry type found for '$type'.";
}
