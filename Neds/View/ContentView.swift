//
//  FileService.swift
//  Neds
//
//  Created by Xavier.Z on 2023/6/23.
//

import SwiftUI

var showSheet = true

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    @State var timerForRepos = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(0..<vm.seletedRaceList.count,id: \.self) { index in
                        let model = vm.seletedRaceList[index]
                        let raceInfo = CountDown.processTimeStamp(model: model)
                        let cellVM = CellViewModel(model: model, raceInfo: raceInfo)
                        NavigationLink(destination:DetailView(model: model)) {
                            RaceCell(viewModel: cellVM)
                        }.accessibilityLabel(raceInfo.accessibilityLabel)
                    }
                }.onReceive(timerForRepos, perform: { time in
                    vm.updateUIData()
                })
                Picker(vm: vm.categoriesVM)
                Spacer(minLength: 30)
            }.navigationTitle("Next To Go")
            
        }.navigationViewStyle(.stack).onAppear{
            self.resetTimer()
            
            Task {
                await vm.fetchRaceList()
            }
            NotificationCenter.default.addObserver(forName: UIAccessibility.voiceOverStatusDidChangeNotification, object: nil, queue: .main) { noti in
                self.resetTimer()
            }
        }
    }
    
    func resetTimer() {
        if UIAccessibility.isVoiceOverRunning {
            self.timerForRepos = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
        } else {
            self.timerForRepos = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DetailView: View {
    @Environment(\.presentationMode) var mode
    var model: RaceSummary
    var body: some View {
        List {
            Text("meetingID:\n\(model.meetingId)")
            Text("categoryID:\n\(model.categoryId)")
            Text("meetingName:\(model.meetingName)")
        }.navigationTitle("Race Detail")
    }
}
