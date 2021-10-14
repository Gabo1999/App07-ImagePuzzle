//
//  DropViewDelegate.swift
//  App07-ImagePuzzle
//
//  Created by Alumno on 14/10/21.
//

import SwiftUI

struct DropViewDelegate: DropDelegate {
    
    var dataModel: DataModel
    var image: Img
    @Binding var isCompleted: Bool
    
    func performDrop(info: DropInfo) -> Bool {
        
        let fromIndex = dataModel.images.firstIndex { (img) -> Bool in
            return img.id == dataModel.currentImage?.id
        } ?? 0
        let toIndex = dataModel.images.firstIndex { (img) -> Bool in
            return img.id == image.id
        } ?? 0
        
        if fromIndex != toIndex {
//            print("from: \(fromIndex) to \(toIndex)")
//            let fromImage = dataModel.images[fromIndex]
//            dataModel.images[fromIndex] = dataModel.images[toIndex]
//            dataModel.images[toIndex] = fromImage
            
            dataModel.images.swapAt(fromIndex, toIndex)
            if dataModel.currentImage!.id == dataModel.images[toIndex].id {
                if validatePuzzle() {
                    isCompleted = true
                } else {
                    isCompleted = false
                }
            }
        }
        
        return true
    }
    
    func dropEntered(info: DropInfo) {
        print(image.id)
        print(dataModel.currentImage!.id)
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    private func validatePuzzle() -> Bool {

        for index in 0..<dataModel.images.count {
            if dataModel.images[index].id != index {
                return false
            }
        }
        return true
    }
}
