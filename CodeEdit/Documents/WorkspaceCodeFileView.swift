//
//  WorkspaceCodeFileEditor.swift
//  CodeEdit
//
//  Created by Pavel Kasila on 20.03.22.
//

import SwiftUI
import CodeFile
import WorkspaceClient
import StatusBar
import Breadcrumbs

struct WorkspaceCodeFileView: View {
    var windowController: NSWindowController
    @ObservedObject var workspace: WorkspaceDocument

    @ViewBuilder
    var codeView: some View {
        if let item = workspace.selectionState.openFileItems.first(where: { file in
            if file.tabID == workspace.selectionState.selectedId {
                print("Item loaded is: ", file.url)
            }
            return file.tabID == workspace.selectionState.selectedId
        }) {
            if let codeFile = workspace.selectionState.openedCodeFiles[item] {
                CodeFileView(codeFile: codeFile)
                    .safeAreaInset(edge: .top, spacing: 0) {
                        VStack(spacing: 0) {
                            BreadcrumbsView(file: item, tappedOpenFile: workspace.openTab(item:))
                            Divider()
                        }
                    }
            } else {
                Text("CodeEdit cannot open this file because its file type is not supported.")
                    .frame(minHeight: 0)
                    .clipped()
            }
        } else {
            Text("No Editor")
                .font(.system(size: 17))
                .foregroundColor(.secondary)
                .frame(minHeight: 0)
                .clipped()
        }
    }

    var body: some View {
        codeView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
