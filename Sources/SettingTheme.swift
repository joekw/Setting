//
//  SettingTheme.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/24/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 Environment keys for overriding Setting view colors from the host app.
 When set, SettingPageView and SettingGroupView use these instead of their stored backgroundColor.
 */
private struct SettingPageBackgroundColorKey: EnvironmentKey {
    static let defaultValue: Color? = nil
}

private struct SettingGroupBackgroundColorKey: EnvironmentKey {
    static let defaultValue: Color? = nil
}

public extension EnvironmentValues {
    var settingPageBackgroundColor: Color? {
        get { self[SettingPageBackgroundColorKey.self] }
        set { self[SettingPageBackgroundColorKey.self] = newValue }
    }

    var settingGroupBackgroundColor: Color? {
        get { self[SettingGroupBackgroundColorKey.self] }
        set { self[SettingGroupBackgroundColorKey.self] = newValue }
    }
}

/**
 A collection of default color values.
 */
public enum SettingTheme {
    public static var labelColor: Color = {
        #if os(iOS) || os(visionOS)
            return Color(uiColor: .label)
        #else
            return Color(nsColor: .labelColor)
        #endif
    }()

    public static var secondaryLabelColor: Color = {
        #if os(iOS) || os(visionOS)
            return Color(uiColor: .secondaryLabel)
        #else
            return Color(nsColor: .secondaryLabelColor)
        #endif
    }()

    public static var backgroundColor: Color = {
        #if os(iOS) || os(visionOS)
            return Color(uiColor: .systemBackground)
        #else
            return Color(nsColor: .textBackgroundColor)
        #endif
    }()

    public static var secondaryBackgroundColor: Color = {
        #if os(iOS) || os(visionOS)
            return Color(uiColor: .secondarySystemBackground)
        #else
            return Color(nsColor: .windowBackgroundColor)
        #endif
    }()
}
