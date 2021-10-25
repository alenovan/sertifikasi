class CashFlowQuery {
  static const String TABLE_NAME = "cashflow";
  static const String CREATE_TABLE =
      " CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT NOT NULL, nominal TEXT NOT NULL,keterangan TEXT NOT NULL,type INTEGER NOT NULL) ";
  static const String SELECT = "select * from $TABLE_NAME";
}