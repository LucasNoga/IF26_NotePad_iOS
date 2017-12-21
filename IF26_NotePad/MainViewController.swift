//
//  MainViewController.swift
//  IF26_NotePad
//
//  Created by lucas noga on 21/12/2017.
//  Copyright © 2017 lucas noga. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    var mNotes : [Note] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()

        creationTableau()
        print("Salut")
        
        
        //self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.tableView.delegate = self
        
        let addNote = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ajoutNote))
        self.navigationItem.setRightBarButton(addButton, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func creationTableau(){
        mNotes = [Note.init(titre: "salut", contenu: "monContenu"), Note.init(titre: "salut2", contenu: "monContenu"),
                  Note.init(titre: "salut3", contenu: "monContenu"), Note.init(titre: "salut4", contenu: "monContenu")]
    }
    
    @objc func ajoutNote(_ sender: AnyObject) {
        performSegue(withIdentifier: "editerNote", sender: self)
        mNotes.append(Note())
    }

    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //nous redirige vers la scene d'edition
        if segue.identifier == "editerNote" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //si on a selectionner une note deja existante
                editerNote(segue: segue, indexPath: indexPath)
            }
            else{
                //sinon on creer une nouvelle note
                creerNote(segue: segue)
            }
        }
    }
    
    //Pour editer une note existante
    func editerNote(segue: UIStoryboardSegue, indexPath: IndexPath){
        print("ok3")////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        let note = self.mNotes[indexPath.row] //on recupere la note
        //let controller = segue.destination as! EditNoteController //on lance la scene d'edition
        //controller.note = note
        print("\(note.titre)  \(note.contenu)" )///////////////////////////////////////////////////////////////////
        //controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
        //controller.navigationItem.leftItemsSupplementBackButton = true
    }
    
    //Creation de la nouvelle note
    func creerNote(segue: UIStoryboardSegue){
        let note = mNotes[mNotes.count-1]//on prend la note qu'on vien de creer
        //let controller = (segue.destination as! EditNoteController //on lance la scene d'edition
        let nav = segue.destination as! UINavigationController
        let controller = nav.topViewController as! EditNoteController
        controller.note = note
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
