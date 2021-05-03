import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider instance = DBProvider._(); //Declares an object of this class and initializes it
  static Database _database; //Inits an object of Database wich is provided by the sqlite dependency

  //Constructor
  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }

  //Function that opens the database and creates the tables
  initializeDatabase() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'flashcard_database.db'),
        version: 1, onCreate: (db, version) async {
      await db.execute("CREATE TABLE IF NOT EXISTS sets ("
          "setID TEXT,"
          "numCards INTEGER,"
          "title TEXT,"
          "PRIMARY KEY (setID)"
          ");");
      await db.execute("CREATE TABLE IF NOT EXISTS flashcards ("
          "setID TEXT,"
          "cardID TEXT,"
          "title TEXT,"
          "engTerm TEXT,"
          "crkTerm TEXT,"
          "PRIMARY KEY (cardID)"
          "FOREIGN KEY(setID)"
          "REFERENCES sets(setID)"
          "ON DELETE CASCADE"
          ");");
    });
  }

  //Function for inserting a flashcard into the flashcards table
  insertFlashCard(FlashCard flashCard) async {
    final Database db = await database;

    await db.insert(
      'flashcards',
      flashCard.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Function for inserting multiple flashcards at the same time
  insertFlashCards(List<FlashCard> flashCards) async {
    final Database db = await database;
    final Batch batch  = db.batch();

    flashCards.forEach((element) async {
      batch.insert("flashcards", element.toMap());
    });
    await batch.commit(noResult: true);
  }

  //Function for inserting a set into the sets table
  insertFlashCardSet(FlashCardSet flashCardSet) async {
    final Database db = await database;

    await db.insert(
      'sets',
      flashCardSet.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Function for getting all sets from the sets table
  Future<List<FlashCardSet>> getFlashCardSets() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sets');

    // Convert the List<Map<String, dynamic> into a List<FlashCardSets>.
    return List.generate(maps.length, (i) {
      return FlashCardSet(
        setID: maps[i]['setID'],
        numCards: maps[i]['numCards'],
        title: maps[i]['title'],
      );
    });
  }

  //Function for getting all flashcards from a set
  Future<List<FlashCard>> getFlashCards(String setID) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'flashcards',
      where: "setID = ?",
      // Pass the FlashCardSet's id as a whereArg to prevent SQL injection.
      whereArgs: [setID],
    );

    // Convert the List<Map<String, dynamic> into a List<FlashCard>.
    return List.generate(maps.length, (i) {
      return FlashCard(
        setID: maps[i]['setID'],
        cardID: maps[i]['cardID'],
        title: maps[i]['title'],
        engTerm: maps[i]['engTerm'],
        crkTerm: maps[i]['crkTerm'],
      );
    });
  }

  //Function for getting a set
  Future<FlashCardSet> getSetByID(String setID) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'sets',
      where: "setID = ?",
      // Pass the FlashCardSet's id as a whereArg to prevent SQL injection.
      whereArgs: [setID],
    );

    // Convert the List<Map<String, dynamic> into a List<FlashCard>.
    return FlashCardSet(
      setID: maps[0]['setID'],
      numCards: maps[0]['numCards'],
      title: maps[0]['title'],
    );
  }

  //Function for updating a set
  updateSet(FlashCardSet flashCardSet) async {
    final db = await database;

    await db.update(
      'sets',
      flashCardSet.toMapNumCards(),
      // Ensure that the card has a matching id.
      where: "setID = ?",
      // Pass the card's id as a whereArg to prevent SQL injection.
      whereArgs: [flashCardSet.setID],
    );
  }

  //Function for updating a flashcard
  updateFlashCard(FlashCard flashCard) async {
    final db = await database;

    await db.update(
      'flashcards',
      flashCard.toMapTerms(),
      // Ensure that the card has a matching id.
      where: "cardID = ?",
      // Pass the card's id as a whereArg to prevent SQL injection.
      whereArgs: [flashCard.cardID],
    );
  }

  //Function for deleting a set
  deleteFlashCardSetAt(String setID) async {
    final db = await database;

    await db.delete(
      'sets',
      // Use a `where` clause to delete a specific FlashcardSet
      where: "setID = ?",
      // Pass the FlashCardSet's id as a whereArg to prevent SQL injection.
      whereArgs: [setID],
    );
  }

  //Function for deleting a flashcard
  deleteFlashCardAt(String cardID) async {
    final db = await database;

    await db.delete(
      'flashcards',
      // Use a `where` clause to delete a specific FlashcardSet
      where: "cardID = ?",
      // Pass the FlashCardSet's id as a whereArg to prevent SQL injection.
      whereArgs: [cardID],
    );
  }
}

//Class that models a set
class FlashCardSet {
  final String setID;
  final int numCards;
  final String title;

  FlashCardSet({this.setID, this.numCards, this.title});

  Map<String, dynamic> toMap() {
    return {
      'setID': setID,
      'numCards': numCards,
      'title': title,
    };
  }

  Map<String, dynamic> toMapNumCards() {
    return {
      'numCards': numCards,
    };
  }

  // Implement toString to make it easier to see information about
  // each FlashCardSet when using the print statement.
  @override
  String toString() {
    return 'FlashCardSet{setID: $setID, numCards: $numCards, title: $title}';
  }
}

//Class that models a flashcard
class FlashCard {
  final String setID;
  final String cardID;
  final String title;
  final String engTerm;
  final String crkTerm;

  FlashCard({this.setID, this.cardID, this.title, this.engTerm, this.crkTerm});

  Map<String, dynamic> toMap() {
    return {
      'setID': setID,
      'cardID': cardID,
      'title': title,
      'engTerm': engTerm,
      'crkTerm': crkTerm,
    };
  }

  Map<String, dynamic> toMapTerms() {
    return {
      'engTerm': engTerm,
      'crkTerm': crkTerm,
    };
  }

  // Implement toString to make it easier to see information about
  // each set/card when using the print statement.
  @override
  String toString() {
    return 'FlashCard{setID: $setID, cardID: $cardID, title: $title, engTerm: $engTerm, crkTerm: $crkTerm}';
  }
}
