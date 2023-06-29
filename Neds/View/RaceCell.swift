//
//  FileService.swift
//  Neds
//
//  Created by Xavier.Z on 2023/6/23.
//

import SwiftUI

struct RaceCell: View {
    let viewModel : CellViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(viewModel.imageName()).resizable().scaledToFit().frame(width: 40,height: 40)
                    Text("R\(viewModel.model.raceNumber)  ").font(Font.system(.subheadline))
                    Spacer(minLength: 20)
                }
                Spacer().frame(height: 20)
                Text(viewModel.model.meetingName).font(Font.system(.headline)).padding(.top, -20)
            }
            Text(viewModel.raceInfo.interval).foregroundColor(viewModel.raceInfo.textColor)
            Image(systemName: "clock.arrow.circlepath").foregroundColor(viewModel.raceInfo.textColor)
        }
    }
}

struct RaceCell_Previews: PreviewProvider {
    static var previews: some View {
        let summary = RaceSummary(raceId: "a23096e6-f26d-4a0b-b0c2-a64fef7842ac", raceName: "Race 4 - Claiming", raceNumber: 4, meetingId: "72482b57-394c-4484-90b0-48ab58c9ef54", meetingName: "Penn National", categoryId: "4a2788f8-e825-4d36-9894-efd4baf1cfae", advertisedStart: AdvertisedStart(seconds: 1687999880))
        
        let vm = CellViewModel(model: summary, raceInfo: ("8m", .blue, "6minutes until the start of the race"))
        RaceCell(viewModel: vm)
    }
}
