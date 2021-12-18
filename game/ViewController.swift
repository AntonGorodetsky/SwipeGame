//
//  ViewController.swift
//  aniswipe
//
//  Created by Anton Gor on 13.12.2021.
//

import UIKit

class ViewController: UIViewController {
  
  var cardOne = UIImageView()
  var cardTwo = UIImageView()
  
  var cardThree = UIView()
  
  var line = [UIImageView]()
  
  var board = [[UIImageView]]()
  var boardView = UIView()
  var boardSize: Int = 3
  
  
  var shiftValue: CGFloat = 0
  var counter = 0
  var cardSide: CGFloat!
  var cardSize: CGSize!
 
  var swipeUp: UISwipeGestureRecognizer!
  var swipeDown: UISwipeGestureRecognizer!
  var swipeLeft: UISwipeGestureRecognizer!
  var swipeRight: UISwipeGestureRecognizer!
  var pan: UIPanGestureRecognizer!
 
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    
    self.view.backgroundColor = .white
    
    
    view.addSubview(cardOne)
    view.addSubview(cardTwo)
    view.addSubview(cardThree)
    
    
    swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    pan = UIPanGestureRecognizer(target: self, action: #selector(panner))
    swipeUp.direction = .up
    swipeDown.direction = .down
    swipeLeft.direction = .left
    swipeRight.direction = .right
//    view.addGestureRecognizer(swipeUp)
//    view.addGestureRecognizer(swipeDown)
//    view.addGestureRecognizer(swipeLeft)
//    view.addGestureRecognizer(swipeRight)
   view.addGestureRecognizer(pan)

  }
  
  @objc func swiped(_ gest: UISwipeGestureRecognizer) {
    UIView.animate(withDuration: 0.5) { [self] in
      let item = self.cardOne
      view.bringSubviewToFront(cardOne)
      let two = self.cardTwo
      switch gest.direction {
        case .up:
//          item.center.y  = item.center.y - item.bounds.width
          item.center.y -= cardSide
          two.center.y += cardSide
        case .down:
          item.center.y  += cardSide
          two.center.y -= cardSide
          view.bringSubviewToFront(cardTwo)
        case .left:
          item.center.x  = item.center.x - item.bounds.width
          two.transform = two.transform.rotated(by: 45)
          
        case .right:
          two.transform = two.transform.rotated(by: -45)
          item.center.x  = item.center.x + item.bounds.width
        default: break
      }
    counter += 1
      cardThree.transform = two.transform.inverted()
//    cardOne.setTitle("\(counter)", for: .normal)
  }
  }
  
  @objc func panner(_ gest: UIPanGestureRecognizer) {
    let shift = gest.translation(in: view)
    if abs(shift.x) < 3 * abs(shift.y) {print("going up,down")}
    switch gest.state {
      case .began: shiftValue = 0
      case .changed:
        for i in line {
//          print(shiftValue, cardSide, shift.x, shift.y)
          if abs(shiftValue) < cardSide {
             gest.setTranslation(.zero, in: view)
            i.center = CGPoint(x: i.center.x + shift.x, y: i.center.y + shift.y)
          } else {view.backgroundColor = .red }
          shiftValue += shift.x
          
        }
        view.backgroundColor = .black
      case .ended: view.backgroundColor = .white
      default: shiftValue = 0
    }
//gest.setTranslation(.zero, in: view)
  }
}

extension ViewController {
  private func setup() {
    cardSide = view.bounds.width*0.3
    cardSize = CGSize(width: cardSide, height: cardSide)
    
    line.append(UIImageView(image: UIImage(named: "1")))
    line.append(UIImageView(image: UIImage(named: "2")))
    line.append(UIImageView(image: UIImage(named: "3")))
    
   
    for i in line.indices {
//      line[i].center = CGPoint(x: (cardSide + (cardSide * CGFloat(i))), y: view.bounds.y - 2 * cardSide)
      line[i].frame = CGRect(origin: CGPoint(x: (cardSide/4 + (cardSide * CGFloat(i))), y: view.bounds.height - 2*cardSide), size: cardSize)

      //      line[i].frame = CGRect(origin: CGPoint(x: 0, y: 0), size: cardSize)
      line[i].contentMode = .scaleToFill
      line[i].backgroundColor = .gray
      view.addSubview(line[i])
      
    }
    
    
    
    
//    cardOne = UIImageView(image: UIImage(named: "4"))
    
    
    cardOne = UIImageView(image: UIImage(
      cgImage: (UIImage(named: "1")?.cgImage?.cropping(
        to: CGRect(origin: CGPoint(x: cardSide, y: cardSide),
                   size: cardSize
                  )
      ))!
    ))
    print(UIImage(named: "1")?.cgImage?.width)
    cardTwo = UIImageView(image: UIImage(named: "5"))
    
    cardOne.center = view.center
    cardOne.contentMode = .scaleAspectFill
    cardOne.bounds = CGRect(x: 0, y: 0, width: cardSide, height: cardSide)
    cardOne.backgroundColor = .blue
//    cardOne.clipsToBounds = true
    cardOne.layer.cornerRadius = cardSide / 2
    cardOne.layer.shadowOpacity = 0.5
    cardOne.layer.shadowOffset = CGSize(width: 10, height: 10)
    
    
    cardTwo.center = view.center
    cardTwo.center.y -= cardSide
    cardTwo.bounds = CGRect(x: 0, y: 0, width: cardSide, height: cardSide)
    cardTwo.backgroundColor = .red
    cardTwo.layer.cornerRadius = cardOne.bounds.width / 2 * 0.5
    cardTwo.layer.shadowOpacity = 0.5
    cardTwo.layer.shadowOffset = CGSize(width: 10, height: 10)
    
    
    cardThree.center = view.center
    cardThree.center.y += cardSide
    cardThree.bounds = CGRect(x: 0, y: 0, width: cardSide, height: cardSide)
    cardThree.backgroundColor = .red
    cardThree.layer.cornerRadius = cardOne.bounds.width / 2 * 0.5
    cardThree.layer.shadowOpacity = 0.5
    cardThree.layer.shadowOffset = CGSize(width: 10, height: 10)
    
    cardThree.clipsToBounds = true
    let pic = UIImageView(image: UIImage(named: "6"))
    pic.contentMode = .center
    pic.frame = CGRect(origin: .zero, size: CGSize(width: cardSide, height: cardSide))
    
    cardThree.addSubview(pic)
    
    
   
    
    //MARK: Gesture setup
  
  
    }
    
//    moveButton.addTarget(.none, action: #selector(moveIt), for: .touchDown)
    
  
  
 
}
