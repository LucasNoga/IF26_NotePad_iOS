import UIKit

class EditNoteController: UIViewController {

    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var noteTitle: UITextField!
    
    var cancel: Bool = false
    var save: Bool =  false
    
    var note: Note!
    
    /*Methode lors de la creation de la scene*/
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sauvegardeNote))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel ,  target: self, action: #selector(cancelNote))
        print("EditController")
        //self.updateView()
        
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("ok1")/////////////////////////////////////////////////////////////////////////////////
        if segue.identifier == "retourNote" { //permet de revenir au main
            if save{
                print("save note")
                //Envoyer la note
            }
            else if cancel{
                print("cancel note")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*Lorsqu'on quitte la scene*/
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    /** Affiche le titre et le contenu de la sélectionné */
    func updateView() {
        self.noteTitle.insertText(note.titre)
        self.noteText.insertText(note.contenu)
    }
    
    /** Methode pour focus sur la vue d'edition de la note */
    @objc func tapFunction(sender: UITapGestureRecognizer) {
        noteText.isEditable = true
    }
    
    /** Methode pour unfocus sur la vue d'edition de la note */
    @objc func tapToEndFunction(sender: UITapGestureRecognizer) {
        noteText.isEditable = false
    }
    
    @objc func cancelNote(){
        cancel = true
        performSegue(withIdentifier: "retourNote", sender: self)
        
    }
    
    @objc func sauvegardeNote() {
        save = true
        note.setContenu(contenu: noteText.text!)//sauvegarde le contenu de la note
        note.setTitre(titre: noteTitle.text!)//sauvegarde dans la note le titre
        performSegue(withIdentifier: "retourNote", sender: self)
    }
}


