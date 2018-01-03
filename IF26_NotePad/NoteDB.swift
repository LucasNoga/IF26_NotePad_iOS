import Foundation
import SQLite

class NoteDB {
    var db: Connection!
    let noteTable = Table("note")
    let id = Expression<Int>("id")
    let title = Expression<String>("titre")
    let content = Expression<String>("contenu")
    
     //Demmare la connexion a la bd
    init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("NotePadProject").appendingPathExtension("sqlite3")
            db = try Connection(fileUrl.path)
        } catch {
            print("error \(error)")
        }
        createTable()
    }
    
    func createTable() {
        let createTableNotes = self.noteTable.create(ifNotExists: true) {(table) in
            table.column(id, primaryKey: true)
            table.column(self.title)
            table.column(self.content)
        }
        do {
            try self.db.run(createTableNotes)
            print()
        } catch {
            print(error)
            print("probleme creat")
        }
    }
    
    func dropTables() {
        do {
            try self.db.run(noteTable.drop(ifExists: true))
        } catch {
            print(error)
            print("probleme drop")
        }
    }
    
    func insertNote(note: Note) {
        do {
           let insert = self.noteTable.insert(or: .ignore, self.title <- note.titre, self.content <- note.contenu)
           try self.db.run(insert)
        } catch {
            print(error)
            print("probleme insert")
        }
    }
    
    func affiche(){
        do{
            let notes = try? db.prepare(noteTable)
            for note in notes!{
                print("id: \(note[id]), name: \(note[title]), contenu: \(note[content])")
            }
        }
    }

    
    func selectNote() -> [Note] {
        var listNote:[Note] = []
        do {
            for note in try self.db.prepare(self.noteTable) {
                listNote.append(Note.init(titre: note[title], contenu: note[content]))
            }
        } catch {
            print("Erreur")
        }
        print(listNote)
        return listNote
    }
    
    func deleteNote(id_note: Int) {
        do {
            let note = self.noteTable.filter(id == id_note)
            try self.db.run(note.delete())
        } catch {
            print(error)
        }
    }
}
