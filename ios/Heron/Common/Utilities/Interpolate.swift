import SwiftUI

func interpolate(from input: CGFloat, inputRange: (CGFloat, CGFloat), outputRange: (CGFloat, CGFloat)) -> CGFloat {
    let (inputMin, inputMax) = inputRange
    let (outputMin, outputMax) = outputRange
    let clampedInput = max(min(input, inputMax), inputMin) // Ensure the input stays within the range
    let progress = (clampedInput - inputMin) / (inputMax - inputMin)
    return outputMin + progress * (outputMax - outputMin)
}
