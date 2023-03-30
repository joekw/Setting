//
//  SettingButton.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A plain button.
 */
public struct SettingButton: View, Setting {
    public var id: AnyHashable?
    public var title: String
    public var indicator: String? = "arrow.up.forward"
    public var indicatorColor: Color = SettingTheme.secondaryLabelColor
    public var horizontalSpacing = CGFloat(12)
    public var verticalPadding = CGFloat(14)
    public var horizontalPadding = CGFloat(16)
    public var icon: SettingIcon?
    public var showProgressIndicator = false
    public var action: () -> Void


    public init(
        id: AnyHashable? = nil,
        title: String,
        indicator: String? = "arrow.up.forward",
        indicatorColor: Color = SettingTheme.secondaryLabelColor,
        horizontalSpacing: CGFloat = CGFloat(12),
        verticalPadding: CGFloat = CGFloat(14),
        horizontalPadding: CGFloat = CGFloat(16),
        icon: SettingIcon? = nil,
        showProgressIndicator: Bool = false,
        action: @escaping () -> Void
    ) {
        self.id = id
        self.title = title
        self.indicator = indicator
        self.indicatorColor = indicatorColor
        self.horizontalSpacing = horizontalSpacing
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.icon = icon
        self.showProgressIndicator = showProgressIndicator
        self.action = action
    }

    public var body: some View {
        SettingButtonView(
            title: title,
            icon: icon,
            indicator: indicator,
            indicatorColor: indicatorColor,
            horizontalSpacing: horizontalSpacing,
            verticalPadding: verticalPadding,
            horizontalPadding: horizontalPadding,
            showProgressIndicator: showProgressIndicator,
            action: action
        )
    }
}

struct SettingButtonView: View {
    let title: String
    var icon: SettingIcon?
    var indicator: String? = "arrow.up.forward"
    var indicatorColor: Color = SettingTheme.secondaryLabelColor
    var horizontalSpacing = CGFloat(12)
    var verticalPadding = CGFloat(14)
    var horizontalPadding = CGFloat(16)
    var showProgressIndicator = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: horizontalSpacing) {
                if let icon {
                    SettingIconView(icon: icon)
                }

                Text(title)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, verticalPadding)

                if showProgressIndicator {
                    ProgressView()
                } else if let indicator {
                    Image(systemName: indicator)
                        .foregroundColor(indicatorColor)
                }
            }
            .padding(.horizontal, horizontalPadding)
            .accessibilityElement(children: .combine)
        }
        .buttonStyle(.row)
    }
}
