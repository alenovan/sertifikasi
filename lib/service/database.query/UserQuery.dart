class UserQuery {
  static const String TABLE_NAME = "users";
  static const String CREATE_TABLE =
      " CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY, name TEXT , password TEXT ) ";
  static const String SELECT = "select * from $TABLE_NAME";
}