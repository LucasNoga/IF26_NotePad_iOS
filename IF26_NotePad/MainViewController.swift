import UIKit

class MainViewController: UITableViewController {
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var mNotes = [Note]()
    var editNoteController: EditNoteController!
    
    //let database: Database = Database()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mNotes = appDelegate.loadNotes()
        //creationTableau()
        
        setNavigationButton()
        
        //print("taille du tableau \(mNotes.count)")
        //Si on a modifié des notes
        //print("didLoad")
        
        self.tableView.delegate = self
        tableView.reloadData()
    }
    
    // Creation des boutons et des actions dans la barre du menu
    func setNavigationButton(){
        self.navigationItem.leftBarButtonItem = self.editButtonItem //bouton edition et suppression pour une tableView
        let addNote = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ajoutNote))
        self.navigationItem.setRightBarButton(addNote, animated: true)
    }

    func creationTableau(){
        mNotes = [Note.init(titre: "salut", contenu: "monContenu"), Note.init(titre: "salut2", contenu: "monContenu"),
                  Note.init(titre: "salut3", contenu: "monContenu"), Note.init(titre: "salut4", contenu: "monContenu")]
    }
    
    //Segue et traite les notes existantes des nouvelles notes
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //nous redirige vers la scene d'edition
        if segue.identifier == "editerNote" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //si on a selectionner une note deja existante
                editerNote(segue: segue, indexPath: indexPath)
            }
        }
    }
    
    // Action lorsque l'on clique sur +
    @objc func ajoutNote(_ sender: AnyObject) {
        mNotes.append(Note(titre: "nouvelle note" , contenu:"nouveau contenu"))
        tableView.reloadData()
    }
    
    //Pour editer une note existante
    func editerNote(segue: UIStoryboardSegue, indexPath: IndexPath){
        let nav = segue.destination as! UINavigationController
        editNoteController = nav.topViewController as! EditNoteController
        editNoteController.note = self.mNotes[indexPath.row] // on recupere la note
        editNoteController.posNote = indexPath.row //on recupere la ligne de la note
        editNoteController.mainController = self
        print(editNoteController.note.titre)
    }
    
    //Fonction qui permet de supprimer une note
    func supprimerNote(index: Int){
        mNotes.remove(at: index)
        tableView.reloadData()
    }
    
    //Gestion de la tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Compteur d'element de la liste
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mNotes.count
    }

    //Mis en forme de la liste
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let note = mNotes[indexPath.row]
        cell.textLabel?.text = note.titre
        cell.detailTextLabel?.text = note.contenu
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //Supprime la note selectionner voulue
        if editingStyle == .delete {
            supprimerNote(index: indexPath.row)
        
        // Ajoute une nouvelle note
        } else if editingStyle == .insert {
            print("insertion d'une note")
        }    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Permet de recharger la vue
    override func viewDidAppear(_ animated: Bool) {
        //print("viewDidAppear")
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("disparu")
        appDelegate.saveNotes(notes: mNotes)
        //Il faut sauvegarder le tableau ailleurs
    }
}
