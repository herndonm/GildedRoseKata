class GildedRose {
  List<Item> items; //List of items

  GildedRose(this.items);

  void updateQuality() {
    for (Item item in items) { //forin loop
      ItemCategory category = categorize(item); //creates new catagory
      ItemCategory().updateOneItem(item); //calls the main driver for the checks and updates
    }
  }

  ItemCategory categorize(Item item) { //method that seperates catagories
    if (item.name == "Sulfuras, Hand of Ragnaros") {
      return new Legendary();
    }
    if (item.name == "Aged Brie") {
      return new Cheese();
    }
    if (item.name == "Backstage passes to a TAFKAL80ETC concert"){
      return new BackStagePass();
    }
    if (item.name.startsWith("Conjured")) { //conjured items must start with the word conjured
      return new Conjured();
    }
    return new ItemCategory();
  }
}

class ItemCategory {
  //class that does most of the work for the checking and updating
  void updateOneItem(Item item) { //main method for initialing checks
    updateQual(item);
    updateSellIn(item);
    if (item.sellIn < 0) {
      updateExpired(item);
    }
  }

  void decrementQual(Item item) { //decreases quality if over 0
    if (item.quality > 0) {
      item.quality = item.quality - 1;
    }
  }

  void incrementQual(Item item) { //increases quality if under 50
    if (item.quality < 50) {
      item.quality = item.quality + 1;
    }
  }

  void updateExpired(Item item) { //if regular item decrease item quality by one
      decrementQual(item);
  }

  void updateQual(Item item) { //if regular item increase item quality by one
      decrementQual(item);
  }

  void updateSellIn(Item item) { //if not legendary decrease the sellin by one
    item.sellIn = item.sellIn - 1;
  }
}

class Legendary extends ItemCategory {
  //Lengdary category class the extemds ItemCategory. For all methods they extend orginals
  //but don't do anything as Item is legendary
  @override
  void updateExpired(Item item) {}

  @override
  void updateQual(Item item) {}

  @override
  void updateSellIn(Item item) {}
}

class Cheese extends ItemCategory {
  //Cheese category class the extemds ItemCategory
  @override
  void updateExpired(Item item) { //if Item is a cheese add one to quality
    incrementQual(item);
  }

  @override
  void updateQual(Item item) { //if Item is a cheese add one to quality
    incrementQual(item);
  }
}

class BackStagePass extends ItemCategory {
  //Back Stage Passes category class the extends ItemCategory
  @override
  void updateExpired(Item item) { //if Item is a Back Stage Pass set quality to 0
      item.quality = 0;

  }
@override
  void updateQual(Item item) { //if Item is a Back Stage Pass increment quality
      incrementQual(item);
      if (item.sellIn < 11) { //if sellin is under 11 add one more to quality
        incrementQual(item);
      }

      if (item.sellIn < 6) { //if sell in is under 6 add a third to quality
        incrementQual(item);
      }
    }
  }
  class Conjured extends ItemCategory {
    //Conjured category class the extends ItemCategory
    @override
    void updateExpired(Item item) { //if item is conjured decrease quality twice
      decrementQual(item);
      decrementQual(item);
    }
    @override
    void updateQual(Item item) { //if item is conjured decrease quality twice
      decrementQual(item);
      decrementQual(item);
    }
  }

class Item {
  String name;
  int sellIn;
  int quality;

  Item(this.name, this.sellIn, this.quality);

  String toString() => '$name, $sellIn, $quality';
}
