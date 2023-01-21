//
//  File.swift
//  Navigation
//
//  Created by Maksim Kruglov on 04.12.2022.
//

import Foundation
import UIKit

protocol FileManagerServiceProtocol {
    
    func contentsOfDirectory (atPath: String) -> [DataForFileTab]
    
    func createDirectory(atPath: String, folderName: String)

    func createFile (fromUrl: URL, atPath: String, fileName: String)
    
}


class FileManagerService: FileManagerServiceProtocol {
    
    
    func contentsOfDirectory(atPath: String) -> [DataForFileTab] {
        var data: [DataForFileTab] = []
        let content = (try? FileManager.default.contentsOfDirectory(atPath: atPath)) ?? []
        
        for i in content {
            let fullPath = atPath + "/" + i
            var isDir: ObjCBool = false
            if FileManager.default.fileExists(atPath: fullPath, isDirectory: &isDir) {
                if isDir.boolValue == true {
                    data.append(DataForFileTab(name: i, type: .folder))
                } else {
                    data.append(DataForFileTab(name: i, type: .file))
                }
            }
        }
        return data
    }
    
    func createDirectory(atPath: String, folderName: String) {
        let fullPath = atPath + "/" + folderName
        try? FileManager.default.createDirectory(atPath: fullPath, withIntermediateDirectories: false)
    }
    
    func createFile(fromUrl: URL, atPath: String, fileName: String) {
        let fromPath = fromUrl.relativePath
        let fullPath = atPath + "/" + fileName
        try? FileManager.default.moveItem(atPath: fromPath, toPath: fullPath)
    }
}
