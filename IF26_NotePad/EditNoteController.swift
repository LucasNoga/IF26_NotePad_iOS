import UIKit

class EditNoteController: UIViewController{

    @IBOutlet var tfTitre: UITextField!
    @IBOutlet var tvContenu: UITextView!
    
    var cancel: Bool = false
    var save: Bool =  false
    
    var mainController: MainViewController!
    var note: Note!
    var posNote: Int = 0
    
    /*Methode lors de la creation de la scene*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationButton()
        
        editerVue()
        
        // permet de mettre a jour la vue avec la note
        updateNote()
        
        if(tvContenu.isFocused){
            print("focus")
        }
    }
    
    // Creation des boutons et des actions dans la barre du menu
    func setNavigationButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(sauvegardeNote))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel ,  target: self, action: #selector(cancelNote))
    }
    
    // Permet de pouvoir editer les notes
    func editerVue(){
        tfTitre.resignFirstResponder()
        tvContenu.isEditable = true
        tvContenu.resignFirstResponder()
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "retourNote" { //permet de revenir au main
            if save{
                print("save note")
                mainController = segue.destination as! MainViewController
                mainController.mNotes.append(note)
                print(mainController.mNotes.count)
                //mainController.tableView.reloadData()
                //Envoyer la note
            }
            else if cancel{
                print("cancel note")
                //annulerNote()
            }
        }
    }
    
    /** Affiche le titre et le contenu de la sélectionné */
    func updateNote() {
        self.tfTitre.insertText(note.titre)
        self.tvContenu.insertText(note.contenu)
    }
    
    // Action lorsque l'on clique sur save
    @objc func sauvegardeNote() {
        save = true
        note.setContenu(contenu: self.tvContenu.text!)
        note.setTitre(titre: self.tfTitre.text!)
        print(note.titre)
        performSegue(withIdentifier: "retourNote", sender: self)
    }
  
    // Action lorsque l'on clique sur cancel
    @objc func cancelNote(){
        cancel = true
        performSegue(withIdentifier: "retourNote", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


