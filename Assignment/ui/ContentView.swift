//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var path: [DeviceData] = [] // Navigation path
    @State var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if viewModel.data != nil {
                    if !viewModel.data!.isEmpty {
                        DevicesList(searchText: $searchText, devices: viewModel.data!) { selectedComputer in
                            searchText = ""
                            viewModel.navigateToDetail(navigateDetail: selectedComputer)
                        }
                    } else {
                        ProgressView("Loading...")
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
            .onChange(of: viewModel.navigateDetail, {
                if let navigate = viewModel.navigateDetail {
                    path.append(navigate)
                }
            })
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(viewModel: viewModel, device: computer)
                
            }
            .onAppear {
                viewModel.fetchAPI()
                let navigate = viewModel.navigateDetail
                if (navigate != nil)  {
                    if !path.contains(navigate!) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            path.append(navigate!)
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Look for something")
    }
}
