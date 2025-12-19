import SwiftUI

struct FiltrationView: View {
    @Environment(\.dismiss) private var dismiss
    
    let onApply: (Set<TimePeriod>, TransferOption?) -> Void
    let initialTimePeriods: Set<TimePeriod>
    let initialTransferOption: TransferOption?
    
    @State private var selectedTimePeriods: Set<TimePeriod>
    @State private var selectedTransferOption: TransferOption?
    
    init(
        initialTimePeriods: Set<TimePeriod> = [],
        initialTransferOption: TransferOption? = nil,
        onApply: @escaping (Set<TimePeriod>, TransferOption?) -> Void
    ) {
        self.initialTimePeriods = initialTimePeriods
        self.initialTransferOption = initialTransferOption
        self.onApply = onApply
        _selectedTimePeriods = State(initialValue: initialTimePeriods)
        _selectedTransferOption = State(initialValue: initialTransferOption)
    }
    
    private var hasSelectedFilters: Bool {
        !selectedTimePeriods.isEmpty || selectedTransferOption != nil
    }
    
    var body: some View {
        ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Время отправления")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Colors.blackTopicColor)
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                            .padding(.bottom, 16)
                        
                        VStack(spacing: 0) {
                            ForEach(TimePeriod.allCases, id: \.self) { period in
                                let isSelected = selectedTimePeriods.contains(period)
                                Button {
                                    if isSelected {
                                        selectedTimePeriods.remove(period)
                                    } else {
                                        selectedTimePeriods.insert(period)
                                    }
                                } label: {
                                    HStack(spacing: 8) {
                                        Text(period.rawValue)
                                            .font(.system(size: 17, weight: .regular))
                                            .foregroundColor(Colors.blackTopicColor)
                                        Text(period.timeRange)
                                            .font(.system(size: 17, weight: .regular))
                                            .foregroundColor(Colors.blackTopicColor)
                                        Spacer()
                                        Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                                            .font(.system(size: 24))
                                            .foregroundColor(Colors.blackTopicColor)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .contentShape(Rectangle())
                                }
                            }
                        }
                        .background(Colors.viewBackgroundColor)
                    }
                    .background(Colors.viewBackgroundColor)

                    VStack(alignment: .leading, spacing: 0) {
                        Text("Показывать варианты с пересадками")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Colors.blackTopicColor)
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                            .padding(.bottom, 16)
                        
                        VStack(spacing: 0) {
                            ForEach(TransferOption.allCases, id: \.self) { option in
                                let isSelected = selectedTransferOption == option
                                Button {
                                    selectedTransferOption = option
                                } label: {
                                    HStack {
                                        Text(option.rawValue)
                                            .font(.system(size: 17, weight: .regular))
                                            .foregroundColor(Colors.blackTopicColor)
                                        Spacer()
                                        Image(systemName: isSelected ? "record.circle" : "circle")
                                            .font(.system(size: 24))
                                            .foregroundColor(Colors.blackTopicColor)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 16)
                                    .contentShape(Rectangle())
                                }
                            }
                        }
                        .background(Colors.viewBackgroundColor)
                    }
                    .background(Colors.viewBackgroundColor)
                }
                .padding(.bottom, 100)
            }
            .background(Colors.viewBackgroundColor)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17))
                            .foregroundColor(Colors.blackTopicColor)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                if hasSelectedFilters {
                    Button {
                        onApply(selectedTimePeriods, selectedTransferOption)
                    } label: {
                        Text("Применить")
                            .font(.system(size: 17, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(.ypBlueUniversal)
                            .foregroundColor(.ypWhiteUniversal)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    .background(Colors.viewBackgroundColor)
                }
            }
    }
}

#Preview {
    FiltrationView(onApply: { _, _ in })
}
