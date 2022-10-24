//
//  db.swift
//  SimpleKeyboard
//  handle the connection with sqllite
//
//  Created by Peter on 24/10/22.
//

import Foundation
import SQLite3

class DBHelper{
    
    init() {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "myDB.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer? {
        // The database file is in the application bundle.
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        // Open the database.
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                    "in the Getting Started section.")
            return nil
        }
    }

    // create table for phrases with id, phrase, and emoji, if not already exist
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Phrases(Id INTEGER PRIMARY KEY,Texts TEXT,Emoji TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Phrases table created.")
            } else {
                print("Phrases table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(texts: String, emoji: String) {
        let insertStatementString = "INSERT INTO Phrases (Texts, Emoji) VALUES (?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (texts as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (emoji as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }

    func read () -> [Phrase] {
        let queryStatementString = "SELECT * FROM Phrases;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Phrase] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let texts = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let emoji = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                psns.append(Phrase(id: Int32(id), texts: texts, emoji: emoji))
                print("Query Result:")
                print("\(id) | \(texts) | \(emoji)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }

    func readStartWith(startText: String) -> [Phrase]{
        let queryStatementString = "SELECT * FROM Phrases WHERE Texts LIKE '\(startText)%';"
        var queryStatement: OpaquePointer? = nil
        var psns : [Phrase] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let texts = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let emoji = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                psns.append(Phrase(id: Int32(id), texts: texts, emoji: emoji))
                print("Query Result:")
                print("\(id) | \(texts) | \(emoji)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }

    func deleteByID(id: Int32) {
        let deleteStatementStirng = "DELETE FROM Phrases WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, id)
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }

    func updateByID(id: Int32, texts: String, emoji: String) {
        let updateStatementString = "UPDATE Phrases SET Texts = ?, Emoji = ? WHERE Id = ?;"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (texts as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (emoji as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 3, id)
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
}
