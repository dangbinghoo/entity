module entity.dialect.postgresqldialect;

import entity;

class PostgresqlDialect : Dialect
{
	string closeQuote() { return "'"; }
	string openQuote()  { return "'"; }
    Variant fromSqlValue(FieldInfo info)
	{
		if(typeid(info.fieldType) == typeid(dBoolType)){
			if(*info.fieldValue.peek!string == "true")
				return Variant(true);
			else
				return Variant(false);
		}else if(typeid(info.fieldType) == typeid(dFloatType))
			return Variant(safeConvert!(string,float)(*info.fieldValue.peek!string));
		else if(typeid(info.fieldType) == typeid(dDoubleType))
			return Variant(safeConvert!(string,double)(*info.fieldValue.peek!string));
		else if(typeid(info.fieldType) == typeid(dIntType))
			return Variant(safeConvert!(string,int)(*info.fieldValue.peek!string));
		else if(typeid(info.fieldType) == typeid(dLongType))
			return Variant(safeConvert!(string,long)(*info.fieldValue.peek!string));
		else 
			return info.fieldValue;	
	}
    string toSqlValueImpl(DlangDataType type,Variant value)
	{
		if(typeid(type) == typeid(dBoolType))
				return value.get!(bool) ? "TRUE" : "FALSE";
		else if(typeid(type) == typeid(dFloatType))
				//return isNaN(*value.peek!float) ? "0" : *value.peek!string;
				//return value.toString;
                return safeConvert!(float,string)(*value.peek!float);
		else if(typeid(type) == typeid(dDoubleType))
				//return isNaN(*value.peek!double) ? "0" : *value.peek!string;
				//return value.toString;
                return safeConvert!(double,string)(*value.peek!double);
		else if(typeid(type) == typeid(dIntType))
				return value.toString;
		else
			return openQuote ~ value.toString ~ closeQuote;
	}

}

string[] PGSQL_RESERVED_WORDS = [
	"ABORT",
	"ACTION",
	"ADD",
	"AFTER",
	"ALL",
	"ALTER",
	"ANALYZE",
	"AND",
	"AS",
	"ASC",
	"ATTACH",
	"AUTOINCREMENT",
	"BEFORE",
	"BEGIN",
	"BETWEEN",
	"BY",
	"CASCADE",
	"CASE",
	"CAST",
	"CHECK",
	"COLLATE",
	"COLUMN",
	"COMMIT",
	"CONFLICT",
	"CONSTRAINT",
	"CREATE",
	"CROSS",
	"CURRENT_DATE",
	"CURRENT_TIME",
	"CURRENT_TIMESTAMP",
	"DATABASE",
	"DEFAULT",
	"DEFERRABLE",
	"DEFERRED",
	"DELETE",
	"DESC",
	"DETACH",
	"DISTINCT",
	"DROP",
	"EACH",
	"ELSE",
	"END",
	"ESCAPE",
	"EXCEPT",
	"EXCLUSIVE",
	"EXISTS",
	"EXPLAIN",
	"FAIL",
	"FOR",
	"FOREIGN",
	"FROM",
	"FULL",
	"GLOB",
	"GROUP",
	"HAVING",
	"IF",
	"IGNORE",
	"IMMEDIATE",
	"IN",
	"INDEX",
	"INDEXED",
	"INITIALLY",
	"INNER",
	"INSERT",
	"INSTEAD",
	"INTERSECT",
	"INTO",
	"IS",
	"ISNULL",
	"JOIN",
	"KEY",
	"LEFT",
	"LIKE",
	"LIMIT",
	"MATCH",
	"NATURAL",
	"NO",
	"NOT",
	"NOTNULL",
	"NULL",
	"OF",
	"OFFSET",
	"ON",
	"OR",
	"ORDER",
	"OUTER",
	"PLAN",
	"PRAGMA",
	"PRIMARY",
	"QUERY",
	"RAISE",
	"REFERENCES",
	"REGEXP",
	"REINDEX",
	"RELEASE",
	"RENAME",
	"REPLACE",
	"RESTRICT",
	"RIGHT",
	"ROLLBACK",
	"ROW",
	"SAVEPOINT",
	"SELECT",
	"SET",
	"TABLE",
	"TEMP",
	"TEMPORARY",
	"THEN",
	"TO",
	"TRANSACTION",
	"TRIGGER",
	"UNION",
	"UNIQUE",
	"UPDATE",
	"USER",
	"USING",
	"VACUUM",
	"VALUES",
	"VIEW",
	"VIRTUAL",
	"WHEN",
	"WHERE",
	];
