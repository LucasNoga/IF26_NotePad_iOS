import Foundation

class Note {
    var titre: String
    var contenu: String
    
    init() {
        self.contenu = ""
        self.titre = ""
    }
    
    init(titre: String, contenu: String) {
        self.titre = titre
        self.contenu = contenu
    }
    
    func setContenu(contenu : String){
        self.contenu = contenu;
    }
    
    func setTitre(titre : String){
        self.titre = titre;
    }
}
