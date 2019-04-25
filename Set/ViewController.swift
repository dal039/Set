//
//  ViewController.swift
//  Set
//
//  Created by David Lee on 8/4/18.
//  Copyright © 2018 David Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateViewFromModel()
    }

    var game = GameSet();
    var buttonsInPlay = [UIButton]()
    var selectedButtons = [UIButton]()
    var isMatched = false
    
    @IBAction func touchNewGame(_ sender: UIButton){
        game = GameSet()
        game.resetScore()
        buttonsInPlay.removeAll()
        selectedButtons.removeAll()
        cardButtons.forEach{ removeButtonSelection(of: $0)}
        updateViewFromModel()
    }
    
    @IBAction func dealThreeCards(_ sender: UIButton) {
        if game.cardsInPlay.count < 24
        {
            game.dealThree()
            updateViewFromModel()
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]! {
        didSet {
            for button in cardButtons
            {
                button.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
                button.layer.cornerRadius = 8.0
                button.setTitle("", for: UIControlState.normal)
            }
            print(buttonsInPlay)
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton)
    {
        // Remove all selections once selected 3 buttons, whether a set or not
        if selectedButtons.count == 3 {
            selectedButtons.forEach{ removeButtonSelection(of: $0) }
            selectedButtons.removeAll()
            updateViewFromModel()
        }
        // Selects and adds card to set matching process
        if !isMatched
        {
            if let cardIndex = buttonsInPlay.index(of: sender) {
                //print("CardIndex: \(cardIndex)")
                game.selectCard(cardIndex)
                if selectedButtons.contains(sender){
                    let buttonIndex = selectedButtons.index(of: sender)!
                    selectedButtons.remove(at: buttonIndex)
                    removeButtonSelection(of: sender)
                } else {
                    selectedButtons.append(sender)
                    addButtonSelection(of: sender)
                    if selectedButtons.count == 3 {
                        if game.checkIfSet(){
                            foundSetSelection(of: selectedButtons)
                            buttonsInPlay = buttonsInPlay.filter{ !selectedButtons.contains($0) }
                            game.increaseScore()
                            isMatched = true
                        } else {
                            game.decreaseScore()
                        }
                    }
                }
            }
        } else {
            isMatched = false
        }
        //print(cardButtons.index(of: sender) ?? "Not Found")
    }
    
    func removeButtonSelection(of sender: UIButton)
    {
        sender.layer.borderWidth = 0.0
        sender.layer.borderColor = UIColor.clear.cgColor
    }
    
    func addButtonSelection(of sender: UIButton)
    {
        sender.layer.borderWidth = 3.0
        sender.layer.borderColor = UIColor.cyan.cgColor
    }
    
    func foundSetSelection(of selectedButtons: [UIButton])
    {
        for button in selectedButtons{
            button.layer.borderWidth = 3.0
            button.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    func hideCardFromView(_ button: UIButton)
    {
        button.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        button.layer.cornerRadius = 8.0
        button.setAttributedTitle(NSAttributedString(string: "", attributes: [:]), for: UIControlState.normal)
    }
    
    func updateViewFromModel()
    {
//        for card in cardButtons
//        {
//            card.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
//        }
        var index = 0
        buttonsInPlay.removeAll()
        for button in cardButtons
        {
            hideCardFromView(button)
        }
        for card in game.cardsInPlay
        {
            let string = cardString(shapeProperty(of: card), numberProperty(of: card))
            let color = colorProperty(of: card)
            let symbolAttributes = symbolProperty(of: card)
            let attributes: [NSAttributedStringKey: Any] = [
                .strokeColor: color,
                .strokeWidth: symbolAttributes.strokeWidth,
                .foregroundColor: color.withAlphaComponent(symbolAttributes.alpha)
            ]
            let cardAttributedString = NSAttributedString(string: string, attributes: attributes)
            cardButtons[index].titleLabel?.numberOfLines = 0
            cardButtons[index].setAttributedTitle(cardAttributedString, for: UIControlState.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            buttonsInPlay.append(cardButtons[index])
            index += 1
        }
        scoreLabel.text = "Score: \(game.score)"
    }
    
    func cardString(_ shape: String, _ number: Int) -> String
    {
        var string = shape
        for _ in 1..<number
        {
            string.append("\n\(shape)")
        }
        return string
    }
    
    func shapeProperty(of card: Card) -> String
    {
        switch card.shape
        {
        case .A:
            return "▲"
        case .B:
            return "●"
        case .C:
            return "■"
        }
    }
    
    func numberProperty(of card: Card) -> Int
    {
        switch card.number
        {
        case .A:
            return 1
        case .B:
            return 2
        case .C:
            return 3
        }
    }
    
    func colorProperty(of card: Card) -> UIColor
    {
        switch card.color
        {
        case .A:
            return UIColor.purple
        case .B:
            return UIColor.green
        case .C:
            return UIColor.red
        }
    }
    
    func symbolProperty(of card: Card) ->
        (strokeWidth: NSNumber, alpha: CGFloat)
    {
        switch card.symbol
        {
        case .A:
            return (-5.0, 1.0)
        case .B:
            return (5.0, 0.0)
        case .C:
            return (-5.0, 0.15)
        }
    }
    
    
}
