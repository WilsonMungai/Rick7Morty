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
            // List loops over the data
//            ForEach(viewModel.cellViewModel) { viewModel in
//                Text(viewModel.title)
//            }
            List(viewModel.cellViewModel) { viewModel in
                HStack {
                    if let image = viewModel.image{
                        Image(uiImage: image)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color(viewModel.iconContainerColor))
                            .cornerRadius(6)
                    }
                    Text(viewModel.title)
                        .padding(.leading, 10)
                    // Add spacer to push view to the right most edge for tap recognition
                    Spacer()
                }
                .padding(.bottom, 3)
                .onTapGesture {
                    viewModel.onTapHandler(viewModel.type)
                }
//                .background(Color.red)
            }
            
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(viewModel: .init(cellViewModel: RMSettingsOption.allCases.compactMap({
            return RMSettingsCellViewModel(type: $0) { option in
                
            }
        })))
    }
}
