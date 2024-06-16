//
//  ContentView.swift
//  SwiftConvert
//
//  Created by David Nwachukwu on 16/06/2024.
//

import SwiftUI

struct ContentView: View {
	enum Unit: CaseIterable {
		case milliliters, liters, cups, pints, gallons
	}
	
	@State private var inputUnit = Unit.liters
	@State private var outputUnit = Unit.milliliters
	@State private var inputValue = 0.0
	@FocusState private var inputIsFocused: Bool
	
	func getMultiplier(unit: Unit) -> Double {
		switch unit {
		case .liters:
			return 1000
		case .cups:
			return 284.1307
		case .pints:
			return 568.2615
		case .gallons:
			return 4546.09
		default:
			return 1
		}
	}
	
	var result: Double {
		if (inputUnit == outputUnit) {
			return inputValue
		}
		
		var inputInML = 0.0
		
		inputInML = inputValue * getMultiplier(unit: inputUnit)
		
		return inputInML / getMultiplier(unit: outputUnit)
	}
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Input", value: $inputValue, format: .number)
						.keyboardType(.decimalPad)
						.focused($inputIsFocused)
				} header: {
					Text("Input Value")
				}
				
				Section {
					Picker("From", selection: $inputUnit) {
						ForEach(Unit.allCases, id: \.self) {
							Text("\($0)")
						}
					}
					.pickerStyle(.automatic)
					
					Picker("To", selection: $outputUnit) {
						ForEach(Unit.allCases, id: \.self) {
							Text("\($0)")
						}
					}
					.pickerStyle(.automatic)
				} header: {
					Text("Select conversion units")
				}
				
				Section {
					Text(result, format: .number)
				} header: {
					Text("Result")
				}
			}
			.navigationTitle("SwiftConvert")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					
					Button("Done") {
						inputIsFocused = false
					}
				}
			}
		}
		.navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
