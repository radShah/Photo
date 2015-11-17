//
//  ViewController.swift
//  Photo
//
//  Created by Radha on 11/12/15.
//  Copyright © 2015 TurnToTech. All rights reserved.
//

// TO DO : picking a library photo doesn't set the image

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    var pop:UIPopoverController?
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var photoLibrary: UIToolbar!
    
    @IBAction func displayPhotoLibrary(sender: UIBarItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.setEditing(false, animated: false)
        imagePicker.delegate = self // doesn't this need to happen first?
        presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func takePhoto(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            switch UIDevice.currentDevice().userInterfaceIdiom {
            case .Phone:
                imagePicker.setEditing(false, animated: false)
                imagePicker.delegate = self // doesn't this need to happen first?
                presentViewController(imagePicker, animated: true, completion: nil)
                break
            case .Pad:
                pop = UIPopoverController(contentViewController: imagePicker)
                imagePicker.setEditing(false, animated: false)
                imagePicker.delegate = self // doesn't this need to happen first?
                pop!.delegate = self
                pop!.presentPopoverFromBarButtonItem(sender, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
                break
            default:
                break
            }
        }
        else {
            let ac = UIAlertController(title: "No camera", message: "You can't take pictures on this device", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
        }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [NSObject : AnyObject]?) {
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            self.dismissViewControllerAnimated(true, completion: nil)
            break
        case .Pad:
            pop?.dismissPopoverAnimated(true)
            break
        default:
            break
        }
        self.imageView.image = image
    }
    
    @IBAction func save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.bounds = self.view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

