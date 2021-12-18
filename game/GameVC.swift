//
//  ViewController.swift
//  aniswipe
//
//  Created by Anton Gor on 13.12.2021.
//

import UIKit

class GameVC: UIViewController {
  
  var cardOne = UIImageView()
  var cardTwo = UIImageView()
  
  var cardThree = UIView()
  
  var imageLine = [UIImageView]()
  
  var board = [[UIImageView]]()
  var boardView = UIView()
  var boardDim: Int = 0
  var swipeDuration = 0.3
  
  var twinCard = UIImageView()
  
  
  var shiftValue: CGFloat = 0
  var counter = 0
  var cardSide: CGFloat!
  var cardSize: CGSize!
 
  var swipeUp: UISwipeGestureRecognizer!
  var swipeDown: UISwipeGestureRecognizer!
  var swipeLeft: UISwipeGestureRecognizer!
  var swipeRight: UISwipeGestureRecognizer!
  
//  var pan: UIPanGestureRecognizer!
 
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  @objc func swiped(_ gest: UISwipeGestureRecognizer) {
//    UIView.animate(withDuration: 0.5) { [self] in
    var i = 0
     i = Int(gest.location(in: boardView).x / cardSide)
    var j = 0
      j = Int(gest.location(in: boardView).y / cardSide)
    
    switch gest.direction {
        case .up:
        twinCard.image = board[0][i].image
        twinCard.frame = board[0][i].frame
        twinCard.tintColor = board[0][i].tintColor
        twinCard.center.y = board[2][i].center.y + cardSide
        UIView.animate(withDuration: swipeDuration, animations: { [self] in
          (board[0][i].center.y,
           board[1][i].center.y,
           board[2][i].center.y,
           twinCard.center.y) =
          (board[0][i].center.y - cardSide,
           board[1][i].center.y - cardSide,
           board[2][i].center.y - cardSide,
           twinCard.center.y - cardSide)
        },
          completion: { [weak self]_ in
          guard let self = self else {return}
          self.board[0][i].center = self.twinCard.center
          self.twinCard.center = CGPoint(x: self.cardSide*1.5, y: -1.5*self.cardSide)
          self.twinCard.tintColor = .orange
          
          let card = self.board[0][i]
          self.board[0][i] = self.board[1][i]
          self.board[1][i] = self.board[2][i]
          self.board[2][i] = card
        })

          
        case .down:
        twinCard.image = board[2][i].image
        twinCard.frame = board[2][i].frame
        twinCard.tintColor = board[2][i].tintColor
        twinCard.center.y = board[0][i].center.y - cardSide
        UIView.animate(withDuration: swipeDuration, animations: { [self] in
          (board[0][i].center.y,
           board[1][i].center.y,
           board[2][i].center.y,
           twinCard.center.y) =
          (board[0][i].center.y + cardSide,
           board[1][i].center.y + cardSide,
           board[2][i].center.y + cardSide,
           twinCard.center.y + cardSide)
        },
          completion: { [weak self]_ in
          guard let self = self else {return}
          self.board[2][i].center = self.twinCard.center
          self.twinCard.center = CGPoint(x: self.cardSide*1.5, y: -1.5*self.cardSide)
          self.twinCard.tintColor = .orange
          
          let card = self.board[2][i]
          self.board[2][i] = self.board[1][i]
          self.board[1][i] = self.board[0][i]
          self.board[0][i] = card
        })
      
        case .left:
        twinCard.image = board[j][0].image
        twinCard.frame = board[j][0].frame
        twinCard.tintColor = board[j][0].tintColor
        twinCard.center.x = board[j][2].center.x + cardSide
        UIView.animate(withDuration: swipeDuration, animations: { [self] in
          (board[j][0].center.x,
           board[j][1].center.x,
           board[j][2].center.x,
           twinCard.center.x) =
          (board[j][0].center.x - cardSide,
           board[j][1].center.x - cardSide,
           board[j][2].center.x - cardSide,
           twinCard.center.x - cardSide)
        },
          completion: { [weak self]_ in
          guard let self = self else {return}
          self.board[j][0].center = self.twinCard.center
          self.twinCard.center = CGPoint(x: self.cardSide*1.5, y: -1.5*self.cardSide)
          self.twinCard.tintColor = .orange
    
          self.board[j].append(self.board[j].removeFirst())
        })
      case .right:
        twinCard.image = board[j][2].image
        twinCard.frame = board[j][2].frame
        twinCard.tintColor = board[j][2].tintColor
        twinCard.center.x = board[j][0].center.x - cardSide
        UIView.animate(withDuration: swipeDuration, animations: { [self] in
          (board[j][0].center.x,
           board[j][1].center.x,
           board[j][2].center.x,
           twinCard.center.x) =
          (board[j][0].center.x + cardSide,
           board[j][1].center.x + cardSide,
           board[j][2].center.x + cardSide,
           twinCard.center.x + cardSide)
        },
          completion: { [weak self]_ in
          guard let self = self else {return}
          self.board[j][2].center = self.twinCard.center
          self.twinCard.center = CGPoint(x: self.cardSide*1.5, y: -1.5*self.cardSide)
          self.twinCard.tintColor = .orange
        
          self.board[j].insert(self.board[j].removeLast(), at: 0)
        })
         default: break
      }

  }
  
  
  //MARK: OLDSWIPED
//  @objc func swiped(_ gest: UISwipeGestureRecognizer) {
//    UIView.animate(withDuration: 0.5) { [self] in
//      let item = self.cardOne
//      view.bringSubviewToFront(cardOne)
//      let two = self.cardTwo
//      switch gest.direction {
//        case .up:
////          item.center.y  = item.center.y - item.bounds.width
//          item.center.y -= cardSide
//          two.center.y += cardSide
//        case .down:
//          item.center.y  += cardSide
//          two.center.y -= cardSide
//          view.bringSubviewToFront(cardTwo)
//        case .left:
//          item.center.x  = item.center.x - item.bounds.width
//          two.transform = two.transform.rotated(by: 45)
//
//        case .right:
//          two.transform = two.transform.rotated(by: -45)
//          item.center.x  = item.center.x + item.bounds.width
//        default: break
//      }
//    counter += 1
//
//
//      cardThree.transform = two.transform.inverted()
////    cardOne.setTitle("\(counter)", for: .normal)
//  }
//  }
  
  }

extension GameVC {
  private func setup() {
    self.view.backgroundColor = .white
    
//  MARK: calc dims
    
    boardDim = 3
    
    func makeboard() {
      var i = 1
      for x in 0..<boardDim {
        imageLine = [UIImageView]()
        for y in 0..<boardDim {
          imageLine.append(
          // UIImageView(image: UIImage(named: "\(i)"))
           UIImageView(image: UIImage(systemName: "\(x)\(y).square.fill"))
          )
          i += 1
        }
        board.append(imageLine)
        imageLine.removeAll()
      }
          
    }
    
    makeboard()
    
    boardView.frame = CGRect(origin: .zero,
                             size: CGSize(
                              width: view.bounds.width*0.9,
                              height: view.bounds.width*0.9))
    boardView.center = view.center
    boardView.backgroundColor = .lightGray
    boardView.layer.cornerRadius = 20
    view.addSubview(boardView)
    boardView.clipsToBounds = true
    
    twinCard.layer.shadowOffset = CGSize(width: 5, height: 5)
    twinCard.layer.shadowOpacity = 0.5
    boardView.addSubview(twinCard)
   
    cardSide = view.bounds.width*0.3
    cardSize = CGSize(width: cardSide, height: cardSide)
                             
    for y in 0..<boardDim {
      for i in 0..<boardDim {
        var card = board[y][i]
        card.frame = CGRect(origin: CGPoint(x: cardSide * CGFloat(i),
                                                   y: cardSide * CGFloat(y)),
                                   size: cardSize)
        card.layer.shadowOffset = CGSize(width: 5, height: 5)
        card.layer.shadowOpacity = 0.5
        boardView.addSubview(card)
      }
    }
    
    boardView.subviews.forEach({$0.tintColor = .black})
    
    
   //MARK: oldCards
//
//    cardOne = UIImageView(image: UIImage(
//      cgImage: (UIImage(named: "1")?.cgImage?.cropping(
//        to: CGRect(origin: .zero,
//                   size: CGSize(width: cardSide / 2, height: cardSide / 2 )
//                  )
//      ))!
//    ))
//
//    cardTwo = UIImageView(image: UIImage(named: "5"))
//
//    cardOne.center = view.center
//    cardOne.contentMode = .scaleAspectFill
//    cardOne.bounds = CGRect(x: 0, y: 0, width: cardSide, height: cardSide)
//    cardOne.backgroundColor = .blue
////    cardOne.clipsToBounds = true
//    cardOne.layer.cornerRadius = cardSide / 2
//    cardOne.layer.shadowOpacity = 0.5
//    cardOne.layer.shadowOffset = CGSize(width: 10, height: 10)
//
//
//    cardTwo.center = view.center
//    cardTwo.center.y -= cardSide
//    cardTwo.bounds = CGRect(x: 0, y: 0, width: cardSide, height: cardSide)
//    cardTwo.backgroundColor = .red
//    cardTwo.layer.cornerRadius = cardOne.bounds.width / 2 * 0.5
//    cardTwo.layer.shadowOpacity = 0.5
//    cardTwo.layer.shadowOffset = CGSize(width: 10, height: 10)
//
//
//    cardThree.center = view.center
//    cardThree.center.y += cardSide
//    cardThree.bounds = CGRect(x: 0, y: 0, width: cardSide, height: cardSide)
//    cardThree.backgroundColor = .red
//    cardThree.layer.cornerRadius = cardOne.bounds.width / 2 * 0.5
//    cardThree.layer.shadowOpacity = 0.5
//    cardThree.layer.shadowOffset = CGSize(width: 10, height: 10)
//
//    cardThree.clipsToBounds = true
//    let pic = UIImageView(image: UIImage(named: "6"))
//    pic.contentMode = .center
//    pic.frame = CGRect(origin: .zero, size: CGSize(width: cardSide, height: cardSide))
//
//    cardThree.addSubview(pic)
//
//
//
//
//        view.addSubview(cardOne)
//        view.addSubview(cardTwo)
//        view.addSubview(cardThree)
//
    
    //MARK: Gesture setup
    
    swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
   
    swipeUp.direction = .up
    swipeDown.direction = .down
    swipeLeft.direction = .left
    swipeRight.direction = .right
    view.addGestureRecognizer(swipeUp)
    view.addGestureRecognizer(swipeDown)
    view.addGestureRecognizer(swipeLeft)
    view.addGestureRecognizer(swipeRight)
  
    }
    
//    moveButton.addTarget(.none, action: #selector(moveIt), for: .touchDown)
    
  
  
  func downIt() {
    let i = 1
//    self.board[0][i] = self.board[2][i]
//    self.board[1][i] = self.board[0][i]
//    self.board[2][i] = self.board[1][i]
//    self.board[0][i].tintColor = .red
//    self.board[1][i].tintColor = .yellow
//    self.board[2][i].tintColor = .green
//    board[0][i] = board[2][i]
//    board[1][i] = board[0][i]
//    board[2][i] = board[1][i]
//    board[0][i].tintColor = .red
//    board[1][i].tintColor = .yellow
    board[2][i].tintColor = .green
  }
  func goLeft() {
    board[0][0].tintColor = .blue
    board[0].append(board[0].removeFirst())
//    board[0][2].tintColor = .red
  }
}
