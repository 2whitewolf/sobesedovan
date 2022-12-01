//
//  ContentView.swift
//  sobesed
//
//  Created by Bogdan Sevcenco on 01.12.2022.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
  @StateObject var vm = MainViewModel()
  @State private var isShowingScanner = false
    var body: some View {
        VStack {
           Text("Scanned words")
            .font(.title2)
          ScrollView {
            ForEach(vm.words , id: \.self) { word in
              VStack{
                Text(word)
                  .foregroundColor(.black)
                Divider()
              }
            }
          }
          HStack{
             Spacer()
            Button{
              isShowingScanner = true
            } label : {
              Image(systemName: "plus")
            }
          }

        }
        .padding(20)
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
        }

    }

  func handleScan(result: Result<ScanResult, ScanError>) {
     isShowingScanner = false
    switch result {
    case .success(let result):
        let details = result.string.components(separatedBy: "\n")
      guard details.count == 1 else { return }

      vm.addNewWord(new: details[0])

    case .failure(let error):
        print("Scanning failed: \(error.localizedDescription)")
    }
     // more code to come
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
