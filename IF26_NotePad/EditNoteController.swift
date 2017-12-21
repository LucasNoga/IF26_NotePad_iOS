//
//  EditNoteController.swift
//  IF26_NotePad
//
//  Created by lucas noga on 21/12/2017.
//  Copyright © 2017 lucas noga. All rights reserved.
//

import UIKit

class EditNoteController: UIViewController {

    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var noteTitle: UITextField!
    
    var note: Note!
    
    /*Methode lors de la creation de la scene*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButton))
        self.updateView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*Lorsqu'on quitte la scene*/
    override func viewDidDisappear(_ animated: Bool) {
        self.sauvegardeNote()
    }
    
    func sauvegardeNote() {
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        note.setContenu(contenu: noteText.text!)//sauvegarde le contenu de la note
        
        note.setTitre(titre: noteTitle.text!)//sauvegarde dans la note le titre
        
        do {
            //appDelegate.saveContext()////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
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
    
    //////////////////////??A VOIR A QUOI ELLE SERT////////////////////////////////////////////////////////////////////////////////////////////
    @objc func shareButton() {
        var itemsToShare = [String]()
        let note = self.note
        let noteTitle = note?.titre
        let noteBody = note?.contenu
        itemsToShare.append(noteTitle!)
        itemsToShare.append(noteBody!)
        
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
}


