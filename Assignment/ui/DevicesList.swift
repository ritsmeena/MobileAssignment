//
//  ComputerList.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct DevicesList: View {
    @Binding var searchText : String
    let devices: [DeviceData]
    let onSelect: (DeviceData) -> Void // Callback for item selection

    var body: some View {
        List(devices) { device in
            if searchText.isEmpty || device.name.contains(searchText){
                Button {
                    onSelect(device)
                } label: {
                    VStack(alignment: .leading) {
                        AssignmentText(text: device.name)
                        
                    }
                }
                .font(.headline)
                .foregroundColor(.blue)
            }
        }
    }
}
