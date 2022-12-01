//
//  MainViewModel.swift
//  sobesed
//
//  Created by Bogdan Sevcenco on 01.12.2022.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
  @Published var words = [String]()


  func addNewWord(new: String) {
    words.append(new)
  }

}

