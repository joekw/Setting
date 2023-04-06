//
//  SettingStack.swift
//  Setting
//
//  Created by Zheng on 2/21/23.
//

import SwiftUI

/**
 The main view for settings. Everything else goes in here.
 */
public struct SettingStack: View {

    @Environment(\.dismiss) var dismiss

    /**
     The main page to display.
     */
    public var page: () -> SettingPage

    /**
     A custom view to display when a search doesn't produce results.

     If this is nil, the default view will be used.
     */
    public var customNoResultsView: AnyView?

    public var closeButtonConfiguration: CloseButtonConfiguration?

    @StateObject var settingViewModel = SettingViewModel()

    public struct CloseButtonConfiguration {
        public var imageName: String
        public var color: Color

        public init(imageName: String, color: Color) {
            self.imageName = imageName
            self.color = color
        }
    }

    /**
     Create a new Settings view from a `SettingPage`. The default "no results" view will be used.
     */
    public init(closeButtonConfiguration: CloseButtonConfiguration? = nil, page: @escaping () -> SettingPage) {
        self.closeButtonConfiguration = closeButtonConfiguration
        self.page = page
    }

    /**
     Create a new Settings view from a `SettingPage`, with a custom `SettingViewModel` and custom "no results" view.
     */
    public init<Content>(
        settingViewModel: SettingViewModel,
        page: @escaping () -> SettingPage,
        @ViewBuilder customNoResultsView: @escaping () -> Content
    ) where Content: View {
        self._settingViewModel = StateObject(wrappedValue: settingViewModel)
        self.page = page
        self.customNoResultsView = AnyView(customNoResultsView())
    }

    public var body: some View {
        if #available(iOS 16.0, macOS 13.0, *) {
            NavigationStack {
                main
                .toolbar {
                    if let closeButtonConfiguration {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(action: {
                                dismiss()
                            }, label: {
                                Image(systemName: closeButtonConfiguration.imageName)
                                    .font(.title2)
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundColor(closeButtonConfiguration.color)
                            }).buttonStyle(.borderless)
                        }
                    }
                }
            }
        } else {
            NavigationView {
                main
            }
        }
    }

    @ViewBuilder var main: some View {
        let settingPage = page()

        VStack {
            if settingViewModel.searchText.isEmpty {
                SettingView(setting: settingPage, isInitialPage: true, isPagePreview: false)
            } else if
                let searchResult = settingViewModel.searchResult,
                !searchResult.sections.isEmpty
            {
                SettingSearchResultView(searchResult: searchResult)
            } else {
                if let customNoResultsView {
                    customNoResultsView
                } else {
                    Text("No results for '\(settingViewModel.searchText)'")
                        .foregroundColor(SettingTheme.secondaryLabelColor)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(SettingTheme.secondaryBackgroundColor)
                }
            }
        }
        .searchable(text: $settingViewModel.searchText)
        .environmentObject(settingViewModel)
        .onAppear {
            let paths = settingPage.generatePaths()
            settingViewModel.paths = paths
        }
        .onReceive(settingViewModel.regeneratePaths) { _ in
            let paths = settingPage.generatePaths()
            settingViewModel.paths = paths
        }
    }
}
