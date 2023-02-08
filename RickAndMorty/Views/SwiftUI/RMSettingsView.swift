//
//  RMSettingsView.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-02-07.
//

import SwiftUI

struct RMSettingsView: View {
    
    let viewModel: RMSettingsViewViewModel
    init(viewModel: RMSettingsViewViewModel){
        self.viewModel = viewModel
    }
    let strings = ["a", "b", "c"]
    var body: some View {
        ScrollView(.vertical) {
            // List loops over the data
            List(viewModel.cellViewModel) { viewModel in
                Text(viewModel.title)
            }
        }
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(viewModel: .init(cellViewModel: RMSettingsOption.allCases.compactMap({
            return RMSettingsCellViewModel(type: $0)
        })))
    }
}
