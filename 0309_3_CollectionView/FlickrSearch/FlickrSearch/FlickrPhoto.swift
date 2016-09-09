/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

struct FlickrPhoto : Equatable {
  var thumbnail : UIImage?
  var largeImage : UIImage?
  let photoID : String
  let farm : Int
  let server : String
  let secret : String
  
  init (photoID:String,farm:Int, server:String, secret:String) {
    self.photoID = photoID
    self.farm = farm
    self.server = server
    self.secret = secret
  }
  
  func flickrImageURL(size:String = "m") -> NSURL? {
    if let url =  NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg") {
      return url
    }
    return nil
  }
  
  mutating func loadLargeImage(completion: (flickrPhoto:FlickrPhoto, error: NSError?) -> Void) {
    guard let loadURL = flickrImageURL("b") else {
      NSOperationQueue.mainQueue().addOperationWithBlock({
        completion(flickrPhoto: self, error: nil)
      })
      return
    }
    
    let loadRequest = NSURLRequest(URL:loadURL)
    
    NSURLSession.sharedSession().dataTaskWithRequest(loadRequest) { (data, response, error) in
      if let error = error {
        NSOperationQueue.mainQueue().addOperationWithBlock({
          completion(flickrPhoto: self, error: error)
        })
        return
      }
      
      guard let data = data else {
        NSOperationQueue.mainQueue().addOperationWithBlock({
          completion(flickrPhoto: self, error:nil)
        })
        return
      }
      
      let returnedImage = UIImage(data: data)
      self.largeImage = returnedImage
      NSOperationQueue.mainQueue().addOperationWithBlock({
        completion(flickrPhoto: self, error: nil)
      })
      
      return
      
      }.resume()
  }
  
  func sizeToFillWidthOfSize(size:CGSize) -> CGSize {
    
    guard let thumbnail = thumbnail else {
      return size
    }
    
    let imageSize = thumbnail.size
    var returnSize = size
    
    let aspectRatio = imageSize.width / imageSize.height
    
    returnSize.height = returnSize.width / aspectRatio
    
    if returnSize.height > size.height {
      returnSize.height = size.height
      returnSize.width = size.height * aspectRatio
    }
    
    return returnSize
  }
  
}

func == (lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
  return lhs.photoID == rhs.photoID
}