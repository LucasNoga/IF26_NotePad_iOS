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
        
        afficherNote() // permet de mettre a jour la vue avec la note

    }
    
    // Creation des boutons et des actions dans la barre du menu
    func setNavigationButton(){
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "sauvegarder", style: UIBarButtonItemStyle.plain, target: self, action: #selector(sauvegardeNote)), animated: true)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(title: "Annuler", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelNote)), animated: true)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        self.navigationItem.LeftBarButtonItem?.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
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
            }
        }
    }
    
    /** Affiche le titre et le contenu de la sélectionné */
    func afficherNote() {
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


