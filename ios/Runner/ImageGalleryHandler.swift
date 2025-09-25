//
//  ImageGalleryHandler.swift
//  Runner
//
//  Created by Mac on 09/05/25.
//

import Flutter
import UIKit
import Photos

@objc class ImageGalleryHandler: NSObject {
    static let shared = ImageGalleryHandler()
    private let channel: FlutterMethodChannel
    
    private override init() {
        channel = FlutterMethodChannel(name: "com.aichatsy.app/image_gallery", binaryMessenger: ((UIApplication.shared.delegate as! FlutterAppDelegate).window.rootViewController as! FlutterViewController).binaryMessenger)
        super.init()
        channel.setMethodCallHandler { [weak self] (call, result) in
            self?.handleMethodCall(call, result: result)
        }
    }
    
    private func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "saveImageToGallery":
            guard let args = call.arguments as? [String: Any],
                  let imageData = args["imageData"] as? FlutterStandardTypedData else {
                result(FlutterError(code: "INVALID_ARGUMENTS",
                                  message: "Invalid arguments",
                                  details: nil))
                return
            }
            
            saveImageToGallery(imageData: imageData.data, result: result)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func saveImageToGallery(imageData: Data, result: @escaping FlutterResult) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                UIImage(data: imageData)?.saveToPhotoLibrary { success, error in
                    if success {
                        result(true)
                    } else {
                        result(FlutterError(code: "SAVE_ERROR",
                                          message: error?.localizedDescription ?? "Failed to save image",
                                          details: nil))
                    }
                }
            } else {
                result(FlutterError(code: "PERMISSION_DENIED",
                                  message: "Photo library permission denied",
                                  details: nil))
            }
        }
    }
}

extension UIImage {
    func saveToPhotoLibrary(completion: @escaping (Bool, Error?) -> Void) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: self)
        }, completionHandler: completion)
    }
}
