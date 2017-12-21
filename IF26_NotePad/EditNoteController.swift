import UIKit

class EditNoteController: UIViewController{

    @IBOutlet var tfTitre: UITextField!
    @IBOutlet var tfContenu: UITextField!
    
    var cancel: Bool = false
    var save: Bool =  false
    
    var note: Note!
    
    /*Methode lors de la creation de la scene*/
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(sauvegardeNote))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel ,  target: self, action: #selector(cancelNote))
        print("EditController")
        
        tfTitre.resignFirstResponder()
        tfContenu.resignFirstResponder()

        self.updateNote()
    }
    
    //Pouvoir tapez dans les champs de texts
    //func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      //  tfTitre.resignFirstResponder()
        //return true;
    //}
    
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
    func updateNote() {
        self.tfTitre.insertText(note.titre)
        self.tfContenu.insertText(note.contenu)
    }
    
    /** Methode pour focus sur la vue d'edition de la note */
    @objc func tapFunction(sender: UITapGestureRecognizer) {
        
    }
    
    /** Methode pour unfocus sur la vue d'edition de la note */
    @objc func tapToEndFunction(sender: UITapGestureRecognizer) {
        print("tapEndFunction")
        
    }
    
    @objc func cancelNote(){
        cancel = true
        performSegue(withIdentifier: "retourNote", sender: self)
    }
    
    @objc func sauvegardeNote() {
        save = true
        note.setContenu(contenu: self.tfContenu.text!)//sauvegarde le contenu de la note
        note.setTitre(titre: self.tfTitre.text!)//sauvegarde dans la note le titre
        performSegue(withIdentifier: "retourNote", sender: self)
    }
}


