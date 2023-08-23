//
//  TransactionDetailsView.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 23.08.23.
//

import SwiftUI

struct TransactionDetailsView: View {
    
    let partnerDisplayName: String
    var description: String?
    
    var body: some View {
        VStack {
            Text(partnerDisplayName)
                .font(.title)
            if let description {
                Text(description)
                    .font(.title3)
                    .foregroundColor(.gray)
            }
        }
        .padding(.bottom, 150)
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsView(partnerDisplayName: "")
    }
}
