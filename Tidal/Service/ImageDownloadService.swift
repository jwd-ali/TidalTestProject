//
//  ImageDownloadService.swift
//  Tidal
//
//  Created by Jawad on 03/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit

typealias ImageDownloadHandlerOperation = (_ image: UIImage?, _ url: URL, _ indexPath: IndexPath? , _ error: Error? ) -> Void
typealias ImageDownloadHandler = (_ image: UIImage?,_ indexPath: IndexPath?,_ error: Error?)-> Void

final class ImageDownloadService {
    private var completionHandler: ImageDownloadHandler?
    private lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "lazy loading"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    private let imageCache = NSCache<NSString, UIImage>()
    static let shared = ImageDownloadService()
    private init () {}
    
    func downloadImage(_ imageUrl: URL, indexPath: IndexPath? = nil, completion: @escaping ImageDownloadHandler) {
        self.completionHandler = completion
       
        if let cachedImage = imageCache.object(forKey: imageUrl.absoluteString as NSString) {
            /* check for the cached image for url, if YES then return the cached image */
            print("Return cached Image for \(imageUrl)")
           self.completionHandler?(cachedImage,indexPath,nil)
        } else {
             /* check if there is a download task that is currently downloading the same image. */
            if let operations = (imageDownloadQueue.operations as? [TOperation])?.filter({$0.imageUrl.absoluteString == imageUrl.absoluteString && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {
                print("Increase the priority for \(imageUrl)")
                operation.queuePriority = .veryHigh
            }else {
                /* create a new task to download the image.  */
                print("Create a new task for \(imageUrl)")
                let operation = TOperation(url: imageUrl, indexPath: indexPath)
                if indexPath == nil {
                    operation.queuePriority = .high
                }
                operation.downloadHandler = { (image, url, indexPath, error) in
                    if let newImage = image {
                        self.imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
                    }
                    self.completionHandler?(image,indexPath,error)
                }
                imageDownloadQueue.addOperation(operation)
            }
        }
    }
    
    /* FUNCTION to reduce the priority of the network operation in case the user scrolls and an image is no longer visible. */
    func slowDownImageDownloadTaskfor (_ imageUrl: URL) {
       
        if let operations = (imageDownloadQueue.operations as? [TOperation])?.filter({$0.imageUrl.absoluteString == imageUrl.absoluteString && $0.isFinished == false && $0.isExecuting == true }), let operation = operations.first {
            print("Reduce the priority for \(imageUrl)")
            operation.queuePriority = .low
        }
    }
    
    func cancelAll() {
        imageDownloadQueue.cancelAllOperations()
    }
    
}




