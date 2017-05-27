//
//  GameSummaryViewController.swift
//  LANLineV2
//
//  Created by Shane Nelson on 5/27/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit

class GameSummaryViewController: UIViewController
{
  @IBOutlet weak var summaryBackground: UIImageView!

  override func viewDidLoad()
  {
      super.viewDidLoad()
    
    
//    var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//    var blurEffectView = UIVisualEffectView(effect: blurEffect)
//    blurEffectView.frame = view.bounds
//    view.addSubview(blurEffectView)
//    
//    // Vibrancy Effect
//    var vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
//    var vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
//    vibrancyEffectView.frame = view.bounds
//    
//    // Label for vibrant text
//    var vibrantLabel = UILabel()
//    vibrantLabel.text = "Vibrant"
//    vibrantLabel.font = UIFont.systemFont(ofSize: 72.0)
//    vibrantLabel.sizeToFit()
//    vibrantLabel.center = view.center
//    
//    // Add label to the vibrancy view
//    vibrancyEffectView.contentView.addSubview(vibrantLabel)
//    
//    // Add the vibrancy view to the blur view
//    blurEffectView.contentView.addSubview(vibrancyEffectView)
  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  @IBAction func doneButtonTapped(_ sender: Any)
  {
    self.dismiss(animated: true, completion: nil)
  }
  
//  override func viewDidAppear(_ animated: Bool)
//  {
//    super.viewDidAppear(animated)
//
//    let blurView = UIView(frame: summaryBackground.frame)
//    blurView.alpha = 0
//    blurView.backgroundColor = .black
//    view.addSubview(blurView)
//
//    UIView.animate(withDuration: 0.1)
//    {
//      blurView.alpha = 0.6
//    }
//  }
//


  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */

}
