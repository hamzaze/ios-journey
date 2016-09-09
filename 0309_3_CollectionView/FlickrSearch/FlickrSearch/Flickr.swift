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

let apiKey = "d1b8ef1b7053254deb6d8b6433a46539"

class Flickr {
  
  let processingQueue = NSOperationQueue()
  
  func searchFlickrForTerm(searchTerm: String, completion : (results: FlickrSearchResults?, error : NSError?) -> Void){
    
    guard let searchURL = flickrSearchURLForSearchTerm(searchTerm) else {
      let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
      completion(results: nil, error: APIError)
      return
    }
    
    let searchRequest = NSURLRequest(URL: searchURL)
    
    NSURLSession.sharedSession().dataTaskWithRequest(searchRequest) { (data, response, error) in
      
      if let _ = error {
        let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
        NSOperationQueue.mainQueue().addOperationWithBlock({
          completion(results: nil, error: APIError)
        })
        return
      }
      
      guard let _ = response as? NSHTTPURLResponse,
        data = data else {
          let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
          NSOperationQueue.mainQueue().addOperationWithBlock({
            completion(results: nil, error: APIError)
          })
          return
      }
      
      do {
        
        guard let resultsDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? [String: AnyObject],
        stat = resultsDictionary["stat"] as? String else {
          
          let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
          NSOperationQueue.mainQueue().addOperationWithBlock({
            completion(results: nil, error: APIError)
          })
          return
        }
        
        switch (stat) {
        case "ok":
          print("Results processed OK")
        case "fail":
          if let message = resultsDictionary["message"] {
            
            let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:message])
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
              completion(results: nil, error: APIError)
            })
          }
          
          let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: nil)
          
          NSOperationQueue.mainQueue().addOperationWithBlock({
            completion(results: nil, error: APIError)
          })
  
          return
        default:
          let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
          NSOperationQueue.mainQueue().addOperationWithBlock({
            completion(results: nil, error: APIError)
          })
          return
        }
        
        guard let photosContainer = resultsDictionary["photos"] as? [String: AnyObject], photosReceived = photosContainer["photo"] as? [[String: AnyObject]] else {
          
          let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
          NSOperationQueue.mainQueue().addOperationWithBlock({
            completion(results: nil, error: APIError)
          })
          return
        }
        
        var flickrPhotos = [FlickrPhoto]()
        
        for photoObject in photosReceived {
          guard let photoID = photoObject["id"] as? String,
            farm = photoObject["farm"] as? Int ,
            server = photoObject["server"] as? String ,
            secret = photoObject["secret"] as? String else {
              break
          }
          var flickrPhoto = FlickrPhoto(photoID: photoID, farm: farm, server: server, secret: secret)
          
          guard let url = flickrPhoto.flickrImageURL(),
            imageData = NSData(contentsOfURL: url) else {
              break
          }
          
          if let image = UIImage(data: imageData) {
            flickrPhoto.thumbnail = image
            flickrPhotos.append(flickrPhoto)
          }
        }
              
        NSOperationQueue.mainQueue().addOperationWithBlock({
          completion(results:FlickrSearchResults(searchTerm: searchTerm, searchResults: flickrPhotos), error: nil)
        })
        
      } catch _ {
        completion(results: nil, error: nil)
        return
      }
      
      
      }.resume()
  }
  
  private func flickrSearchURLForSearchTerm(searchTerm:String) -> NSURL? {
    
    guard let escapedTerm = searchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet()) else {
      return nil
    }
    
    let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(escapedTerm)&per_page=20&format=json&nojsoncallback=1"
    
    guard let url = NSURL(string:URLString) else {
      return nil
    }
    
    return url
  }
}
