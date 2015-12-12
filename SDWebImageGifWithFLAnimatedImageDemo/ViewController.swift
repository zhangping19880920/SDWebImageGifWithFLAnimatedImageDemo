//
//  ViewController.swift
//  SDWebImageGifWithFLAnimatedImageDemo
//
//  Created by zhangping on 15/12/12.
//  Copyright © 2015年 zhangping. All rights reserved.
//

import UIKit

import FLAnimatedImage

class ViewController: UIViewController {
    
    private lazy var gifImageView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        self.view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        let multiplier:CGFloat = 1/3
        
        self.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: multiplier, constant:0))
        
        self.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 30))
        
        return imageView
    }()
    
    private lazy var tipTxt: UILabel = {
        let label = UILabel(frame: CGRect(x: 30, y: 600, width: 200, height: 30))
        
        label.textColor = UIColor.blackColor()
        
        self.view.addSubview(label)
        
        return label
    }()
    
    var imageUrlString = "http://ww4.sinaimg.cn/large/66a4866egw1eyx4refeejg205k05knpd.gif"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: imageUrlString)
        
        gifImageView.qs_setGifImageWithURL(url, progress: { (recSize, totalSize) -> Void in
            var text = ""
            if recSize < totalSize {
                let val = Int( CGFloat(recSize) * 100.0 / CGFloat(totalSize) )
                text = "\(val)%"
            } else if recSize == totalSize {
                text = "load from net done"
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tipTxt.text = text
            })
            }) { (image, data, error, finished) -> Void in
                print("下载图片完成")
        }
    }

}

