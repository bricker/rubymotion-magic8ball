class Magic8BallViewController < UIViewController
  def loadView
    self.view = UIImageView.alloc.init
  end
  
  #--------------------
  
  def viewDidLoad
    view.image = UIImage.imageNamed('background.png')
    @label = makeLabel
    view.addSubview(@label)
    
    view.userInteractionEnabled = true
    recognizer = UITapGestureRecognizer.alloc.initWithTarget(self, action: 'showAnswer')
    view.addGestureRecognizer(recognizer)
    
    @eightBall = Magic8Ball.new
  end

  #--------------------
  
  private
  
  def showAnswer
    UIView.animateWithDuration 0.5, 
      animations: -> { 
        @label.alpha = 0
        @label.transform = CGAffineTransformMakeScale(0.1, 0.1)
      },
      
      completion: ->(finished) {
        @label.text = @eightBall.randomAnswer
        
        UIView.animateWithDuration 1.0, 
          animations: -> { 
            @label.alpha = 1
            @label.transform = CGAffineTransformIdentity
          }
      }
  end

  #--------------------
  
  def makeLabel
    labelOpts = {
      :backgroundColor => UIColor.lightGrayColor,
      :text            => "Tap for Answer!",
      :font            => UIFont.boldSystemFontOfSize(34),
      :textColor       => UIColor.darkGrayColor,
      :textAlignment   => UITextAlignmentCenter
    }

    label = UILabel.alloc.initWithFrame([[10, 60], [300, 80]])
    label.textAlignment = 0
    labelOpts.each { |k, v| label.send("#{k}=", v) }
    label
  end
end
