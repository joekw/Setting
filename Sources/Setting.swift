//
//  Setting.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

enum Setting {
    static var labelColor: Color = {
        #if os(iOS)
            return Color(uiColor: .label)
        #else
            return Color(nsColor: .labelColor)
        #endif
    }()

    static var secondaryLabelColor: Color = {
        #if os(iOS)
            return Color(uiColor: .secondaryLabel)
        #else
            return Color(nsColor: .secondaryLabelColor)
        #endif
    }()

    static var backgroundColor: Color = {
        #if os(iOS)
            return Color(uiColor: .systemBackground)
        #else
            return Color(nsColor: .textBackgroundColor)
        #endif
    }()

    static var secondaryBackgroundColor: Color = {
        #if os(iOS)
            return Color(uiColor: .secondarySystemBackground)
        #else
            return Color(nsColor: .windowBackgroundColor)
        #endif
    }()
}
