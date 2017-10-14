//
//  ViewController.swift
//  Silly Song
//
//  Created by Luiz Arantes Sa on 10/14/17.
//  Copyright © 2017 Luiz Arantes Sa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        nameField.autocapitalizationType = .words
        nameField.returnKeyType = .done
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        guard let name = nameField.text, !name.isEmpty else {
            return
        }        
        lyricsView.text = lyricsForName(lyricsTemplate:bananaFanaTemplate, fullName:name)
    }
}

func shortNameForName(_ name: String) -> String {
    let vowels: [Character] = ["a", "e", "i", "o", "u"]
    var firstVowelIndex: String.Index?
    let lName = name.lowercased()
    
    for (i, char) in zip(lName.indices, lName) {
        if (vowels.index(of: char) != nil) {
            firstVowelIndex = i
            break
        }
    }
    if (firstVowelIndex == nil) {
        return lName
    }
    return String(lName[firstVowelIndex!...])
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    return lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortNameForName(fullName))
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


