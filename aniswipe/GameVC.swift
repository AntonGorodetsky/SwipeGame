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
           board[0][i].center.y -= cardSide
           board[1][i].center.y -= cardSide
           board[2][i].center.y -= cardSide
           twinCard.center.y -= cardSide
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
          board[0][i].center.y += cardSide
          board[1][i].center.y += cardSide
          board[2][i].center.y += cardSide
          twinCard.center.y += cardSide
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
           board[j][0].center.x -= cardSide
           board[j][1].center.x -= cardSide
           board[j][2].center.x -= cardSide
           twinCard.center.x -= cardSide
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
          board[j][0].center.x += cardSide
          board[j][1].center.x += cardSide
          board[j][2].center.x += cardSide
          twinCard.center.x += cardSide
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
  
 
  }

extension GameVC {
  private func setup() {
    self.view.backgroundColor = .white
    
//  MARK: calc dims
    
    boardDim = 3
    
    func makeboard() {
      var i = 1
      let picSide = CGFloat(( UIImage(named: "1")?.cgImage?.width ?? 30 ) / boardDim )
      for y in 0..<boardDim {
        imageLine = [UIImageView]()
        for x in 0..<boardDim {
//          imageLine.append(
//           UIImageView(image: UIImage(systemName: "\(y)\(x).square.fill")))
         
          imageLine.append(
            UIImageView(image: UIImage(
              cgImage: (UIImage(named: "1")?.cgImage?.cropping(
                to: CGRect(origin: CGPoint(x: picSide * CGFloat(x), y: picSide * CGFloat(y)),
                           size: CGSize(width: picSide, height: picSide)
                          )
              ))!
            ))
          )
         
          i += 1
        }
        board.append(imageLine)

      }
          
    }
    
    
    
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
     
    makeboard()
    
    for y in 0..<boardDim {
      for i in 0..<boardDim {
        let card = board[y][i]
        card.frame = CGRect(origin: CGPoint(x: cardSide * CGFloat(i),
                                           y: cardSide * CGFloat(y)),
                                   size: cardSize)
        card.layer.shadowOffset = CGSize(width: 5, height: 5)
        card.layer.shadowOpacity = 0.5
        boardView.addSubview(card)
      }
    }
    
    boardView.subviews.forEach({$0.tintColor = .black})

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
}
